n = 40;
G = randi(2, n)-1;

for (i = 1:n)
  for (j = i:n)
    G(i,j) = 0;
  endfor
endfor

clique = isclique(G, 4);