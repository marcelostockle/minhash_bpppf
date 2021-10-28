function [similarity, support] =  exact_similarity(mh_count, seq, period)
  cols = size(mh_count.hash, 2);
  similarity = zeros(1, cols);
  sim_or = zeros(1, cols);
  sim_and = zeros(1, cols);
  order = sum(mh_count.pattern(1,:) >= 0);
  
  windows = floor(numel(seq) / period);
  aux_win = 1:period;
  for (i = 1:windows)
    win = aux_win + (i - 1) * period;
    for (j = 1:cols)
      match = sum(seq(win) == mh_count.pattern(j, :)');
      if (match > 0)
        sim_or(j)++;        
        if (match == order);
          sim_and(j)++;
        endif
      endif
    endfor
  endfor
  
  similarity = sim_and ./ sim_or;
  support = sim_and / windows;