function polybucket = polybucket_compress(query, insert, period)  
  
  if (query == 0)
    polybucket = insert;
  else
    bucket_len = 0;
    aux = query;
    while (aux > 0)
      bucket_len++;
      aux -= period^bucket_len;
    endwhile
    
    query = query - 1;
    polybucket = 1 + query + insert * period^bucket_len;
  endif
  