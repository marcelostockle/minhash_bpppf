function [mh_count_f2] = bpppf_f2(mh_count, similarity, k, period, min_sim)
  
  heap_order = 2;
  [I, J] = find(similarity >= min_sim);
  cols = numel(I);
  mh_count_f2.hash = zeros(k, cols);
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
    
    heap_new = -1 * ones(k, 1);
    sig_len = 0;
    heap_a = mh_count.hash(:, I(i));
    heap_b = mh_count.hash(:, J(i));
    heapend_a = mh_count.sig_len(I(i));
    heapend_b = mh_count.sig_len(I(i));
    while (sig_len < k && heapend_a > 0 && heapend_b > 0)
      if (heap_a(1) == heap_b(1))
        sig_len++;
        heap_new(sig_len) = heap_b(1);
        heap_new = maxheap_adjust(heap_new, sig_len, sig_len, heap_order);
        
        heap_a(1) = heap_a(heapend_a);
        heapend_a--;
        heap_a = maxheap_adjust(heap_a, heapend_a, 1, heap_order);
        
        heap_b(1) = heap_b(heapend_b);
        heapend_b--;
        heap_b = maxheap_adjust(heap_b, heapend_b, 1, heap_order);
      elseif (heap_a(1) > heap_b(1))
        heap_a(1) = heap_a(heapend_a);
        heapend_a--;
        heap_a = maxheap_adjust(heap_a, heapend_a, 1, heap_order);
      else
        heap_b(1) = heap_b(heapend_b);
        heapend_b--;
        heap_b = maxheap_adjust(heap_b, heapend_b, 1, heap_order);
      endif
    endwhile
    mh_count_f2.hash(:, i) = heap_new;
    mh_count_f2.sig_len(i) = sig_len;
  endfor