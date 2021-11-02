function clique = isclique(G)
  k = size(G, 1);
  if (k < 2)
    clique = true;
  elseif (k == 2)
    clique = G(k, 1) == 1;
  elseif (G(k, 1) == 1)
    clique = isclique(G(1:k-1, 1:k-1)) && isclique(G(2:k, 2:k));
  else
    clique = false;
  endif