function [F1, count] = bpppf_f1(seq, N, period, min_support)  % F1 contains all the 1-patterns that have a minimum support of min_count.  % F1 includes three atributes:  % - A numerical symbol (1st column)  % - An index pointing to the single non-* element in a   %     particular pattern (2nd column)  % - The specific support value (3rd column)    aux_win = 1:period;  count = zeros(N, period);  len = numel(seq);    windows = floor( len / period );  if (windows > 0)    for (j = 1:windows)      win = aux_win + (j - 1) * period;      for (p = aux_win)        count(1 + seq(win(p)), p)++;      endfor    endfor  endif    [I, J] = find(count / len >= min_support);  V = count(find(count / len >= min_support));  I--;  F1 = cat(2, I, J, V);endfunction