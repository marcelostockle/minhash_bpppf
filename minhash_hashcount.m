function [similarity, htable] = minhash_hashcount(mh_count, k, hash_size, period)
  
  cols = numel(mh_count.maxind);
  htable = sparse(hash_size, 1);
  sim_counts = zeros(cols, cols);
  similarity = zeros(cols, cols);
  
  for (i = 1:cols)
    for (j = 1:mh_count.sig_len(i))
      query = htable(mh_count.hash(j, i));
      if (query == 0)
        htable(mh_count.hash(j, i)) = i;
      else
        bucket = polybucket_decompress(query, period);
        sim_counts(i, bucket)++;
        
        htable(mh_count.hash(j, i)) = polybucket_compress(query, i, period);
      endif
    endfor
    for (j = 1:(i - 1))
      size_union = mh_count.sig_len(i) + mh_count.sig_len(j) - sim_counts(i, j);
      similarity(i, j) = sim_counts(i, j) / min([k, size_union]);
    endfor
  endfor
  
