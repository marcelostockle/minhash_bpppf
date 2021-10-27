function [mh_count, hash_size] = minhash_f1(seq, k, period, F1)
  
  heap_order = 2;
  windows = floor(numel(seq) / period);
  hash_bits = 2 * nextpow2(windows);
  hash_size = pow2(hash_bits);
  
  cols = size(F1, 1);
  mh_count = [];
  mh_count.hash = 2 * hash_size * ones(k, cols);
  mh_count.sig_len = zeros(1, cols);
  
  aux_win = 1:period;
  for (j = 1:windows)
    h = randi(hash_size);
    win = aux_win + (j - 1) * period;
    for (i = 1:cols)
      if (seq(win(F1(i, 2))) == F1(i, 1))
        if (mh_count.sig_len(i) < k)
          mh_count.sig_len(i)++;
          mh_count.hash(mh_count.sig_len(i), i) = h;
          mh_count.hash(:, i) = maxheap_adjust(mh_count.hash(:, 1), mh_count.sig_len(i), heap_order);
        elseif (h < mh_count.hash(1, i))
          mh_count.hash(1, i) = h;
          mh_count.hash(:, i) = maxheap_adjust(mh_count.hash(:, i), 1, heap_order);
        endif
      endif
    endfor
  endfor
  
  for (i = 1:cols)
    mh_count.hash(:, i) = sort(mh_count.hash(:, i), 'ascend');
    mh_count.maxind(i) = mh_count.sig_len(i);
  endfor
  mh_count.maxhash(mh_count.sig_len == 0) = -1;
  mh_count.hash(mh_count.hash > hash_size) = -1;
  
  mh_count.pattern = -1 * ones(cols, period);
  for (i = 1:cols)
    mh_count.pattern(i, F1(i, 2)) = F1(i, 1);
  endfor  