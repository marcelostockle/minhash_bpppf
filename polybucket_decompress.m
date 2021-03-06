function bucket = polybucket_decompress(query, period)
  
  bucket = [];
  if (query > 0)
    bucket_len = 0;
    aux = query;
    while (aux > 0)
      bucket_len++;
      aux -= period^bucket_len;
    endwhile
    
    query = query - 1;
    bucket = zeros(bucket_len, 1);
    bucket_i = 1;
    while (query > 0)
      bucket(bucket_i) = mod(query, period);
      query -= bucket(bucket_i);
      query /= period;
      query--;
      bucket_i++;
    endwhile
    bucket++;
  endif
  
