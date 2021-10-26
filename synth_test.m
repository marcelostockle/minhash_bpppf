function [seq, max_pattern] = synth_test(N, seq, period)
  
  max_pattern = randi(N, 1, period) - 1;
  
  p = 0;
  while (p * (period + 1) < numel(seq))
    ind = p * period + (1:period);
    for (i = 1:numel(ind))
      if (mod(p, i) == 0)
        seq(ind(i)) = max_pattern(i);
      endif
    endfor
    p++;
  endwhile
