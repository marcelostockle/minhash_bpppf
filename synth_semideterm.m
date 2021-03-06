function [seq, max_pattern] = synth_semideterm(N, seq, period, support)
  
  max_pattern = randi(N, 1, period) - 1;
  
  if (length(seq) < support * period)
    printf("synth_determ.m: WARNING, sequence not long enough to");
    printf(" meet the required support. Returning without changes.\n");
    return;
  endif
  
  for (p = (1:support)-1)
    rand_ind = rand(1, period);
    rand_ind = find(rand_ind <= 0.5);
    
    ind = p * period + (1:period);
    ind = ind(rand_ind);
    seq(ind) = max_pattern(rand_ind);
  endfor
