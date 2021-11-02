function clique = findclique(G, k)
  n = size(G, 1);
  ind = 1:k;
  pivot = k - 1;
  clique = zeros(100, k);
  c = 1;
  while (ind(1) <= n - k + 1)
    if (isclique(G(ind, ind)))
      clique(c, :) = ind;
      c++;
    endif
    
    if (c > size(clique, 1))
      clique = cat(1, clique, zeros(100, k));
    endif
    
    ind(k)++; 
    while(pivot > 0 && ind(k) > n)
      ind(pivot)++;
      ind((pivot+1):end) = ind(pivot) + (1:(k - pivot));
      pivot--;
    endwhile
    pivot = k - 1;
  endwhile
  
  c--;
  clique = clique(1:c, :);