function [similarity, bstree] = minhash_candidateset(sigs, sig_len, period)
  
  cols = numel(sig_len);
  k = size(sigs, 1);
  bstree = bstree_create(k * cols);
  sim_counts = zeros(cols, cols);
  similarity = zeros(cols, cols);
  
  for (i = 1:cols)
    for (j = 1:sig_len(i))
      [bstree, bstree.root] = bstree_insert(bstree, sigs(j, i));
    endfor
  endfor
  size_inter = sum(bstree.counts > 1);
  size_union = sum(sig_len) - size_inter;
  similarity = size_inter / size_union;
  
