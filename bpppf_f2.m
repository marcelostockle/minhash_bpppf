function [mh_count_f2] = bpppf_f2(mh_count, similarity, k, period, min_sim)
  
  [I, J] = find(similarity >= min_sim);
  cols = numel(I);
  mh_count_f2.hash = -1 * ones(k, cols);
  mh_count_f2.sig_len = k * ones(1, cols);
  mh_count_f2.pattern = -1 * ones(cols, period);
  mh_count_f2.similarity = zeros(1, cols);
  for (i = 1:cols)
    mh_count_f2.similarity(i) = similarity(I(i), J(i));
    pattern_a = mh_count.pattern(I(i),:);
    pattern_b = mh_count.pattern(J(i),:);
    
    non_comodin = pattern_a != -1;
    mh_count_f2.pattern(i, non_comodin) = pattern_a(non_comodin);
    non_comodin = pattern_b != -1;
    mh_count_f2.pattern(i, non_comodin) = pattern_b(non_comodin);
    
    ind_a = 1;
    ind_b = 1;
    hash_a = mh_count.hash(ind_a, I(i));
    hash_b = mh_count.hash(ind_b, J(i));
    sig_len = 0;
    while (sig_len < k && ind_a <= k && ind_b <= k)
      hash_a = mh_count.hash(ind_a, I(i));
      hash_b = mh_count.hash(ind_b, J(i));
      if (hash_a == hash_b)
        sig_len++;
        mh_count_f2.hash(sig_len, i) = hash_a;
        ind_a++;
        ind_b++;
      elseif (hash_a < hash_b)
        ind_a++;
      else
        ind_b++;
      endif
    endwhile
    mh_count_f2.sig_len(i) = sig_len;
  endfor