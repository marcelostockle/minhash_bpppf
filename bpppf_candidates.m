function [subind, C] = bpppf_candidates(mh_count, order, symbols)
  
  Fminus = mh_count{order - 1}.pattern;
  n = size(Fminus, 1);
  P = size(Fminus, 2);
  power_vec = (symbols + 1).^((1:P) - 1);
  
  bstree = bstree_create(n);
  for (i = 1:n)
    for (j = i+1:n)
      coincidences = Fminus(i,:) == Fminus(j,:);
      conditional_a = sum(Fminus(i,:) == -1 & coincidences) == P - order;
      conditional_b = sum(Fminus(i,:) != -1 & coincidences) == order - 2;
      if (conditional_a && conditional_b)
        superpattern = -1 * ones(1, P);
        ind = Fminus(i,:) != -1;
        superpattern(ind) = Fminus(i, ind);
        ind = Fminus(j,:) != -1;
        superpattern(ind) = Fminus(j, ind);
        h = (superpattern + 1) * power_vec';
        [bstree, bstree.root] = bstree_insert(bstree, h);
      endif
    endfor
  endfor
  
  clique = order * (order - 1) / 2;
  C_h = bstree.tree(bstree.counts == clique);  
  C = zeros(numel(C_h), P);
  
  for (p = 1:P)
    C(:, p) = mod(C_h, symbols + 1);
    C_h -= C(:, p);
    C_h /= (symbols + 1);
  endfor
  C--;

  subind = zeros(numel(C_h), order);
  subind_c = ones(size(C_h));
  for (i = 1:numel(C_h))
    for (j = 1:n)
      if (sum(C(i,:) == Fminus(j,:)) == P - 1)
        subind(i, subind_c(i)) = j;
        subind_c(i)++;
      endif
    endfor
  endfor