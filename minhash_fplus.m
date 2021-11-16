function [mh_count, similarity] = minhash_fplus(mh_count, order, subind, min_sim)
  if (nargin < 4)
    min_sim = 0;
  endif
  
  n_candidates = size(subind, 1);
  similarity = zeros(n_candidates, 1);
  k = size(mh_count{1}.hash, 1);
  period = size(mh_count{1}.pattern, 2);
  for (i = 1:n_candidates)
    sigs = mh_count{order - 1}.hash(:, subind(i, :));
    sig_len = mh_count{order - 1}.sig_len(subind(i, :));
    similarity(i) = minhash_candidateset(sigs, sig_len, period);
  endfor
  
  heap_order = 2;
  I = find(similarity >= min_sim);
  cols = numel(I);
  mh_count{order}.hash = zeros(k, cols);
  mh_count{order}.sig_len = k * ones(1, cols);
  mh_count{order}.pattern = -1 * ones(cols, period);
  mh_count{order}.similarity = similarity(I);
  for (i = 1:cols)
    pattern_a = mh_count{order - 1}.pattern(subind(I(i),1),:);
    pattern_b = mh_count{order - 1}.pattern(subind(I(i),2),:);
    non_comodin = pattern_a != -1;
    mh_count{order}.pattern(i, non_comodin) = pattern_a(non_comodin);
    non_comodin = pattern_b != -1;
    mh_count{order}.pattern(i, non_comodin) = pattern_b(non_comodin);
    
    heap_new = -1 * ones(k, 1);
    sig_len = 0;
    multiheap = mh_count{order - 1}.hash(:, subind(I(i),:));
    [~, multimax] = max(multiheap(1, :));
    heapend = mh_count{order - 1}.sig_len(subind(I(i),:));
    while (sig_len < k && ~isempty(heapend))
      match = multiheap(1, :) == multiheap(1, multimax);
      if (sum(match) > 1)
        match_val = multiheap(1, match);
        sig_len++;
        heap_new(sig_len) = match_val(1);
        heap_new = maxheap_adjust(heap_new, sig_len, sig_len, heap_order);
      endif
      
      for (j = 1:numel(heapend))
        if (match(j))
          multiheap(1,j) = multiheap(heapend(j), j);
          heapend(j)--;
          multiheap(:,j) = maxheap_adjust(multiheap(:,j), heapend(j), 1, heap_order);
        endif
      endfor
      
      sel = true(size(heapend));
      sel(heapend == 0) = false;
      heapend = heapend(sel);
      multiheap = multiheap(:, sel);
      [~, multimax] = max(multiheap(1, :));
    endwhile
    mh_count{order}.hash(:, i) = heap_new;
    mh_count{order}.sig_len(i) = sig_len;
  endfor
