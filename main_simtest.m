% IMPORTANT: synthetic sequences take integer values from 0 to args.symbols-1

args.len = 100000;
args.symbols = 300;
args.period = 5;
% args.support = 1000;
args.k = 60:20:200;
args.min_support = 300 / args.len;
args.min_sim = 0.01;

seq = synth_random(args.symbols, args.len);
%% [seq_d, maxpattern]= synth_semideterm(args.symbols, seq, args.period, args.support);
[seq_d, maxpattern]= synth_test(args.symbols, seq, args.period);

disp("Finding F1...");
[F1, count] = bpppf_f1(seq_d, args.symbols, args.period, args.min_support);

experiments = 10;

sim_err_mean = zeros(size(args.k));
sim_err_std = zeros(size(args.k));
for (y = 1:numel(args.k))
  printf("k = %d\n", args.k(y));
  a = size(F1, 1);
  similarity = zeros(experiments, a * (a - 1) / 2);

  mh_count = cell(args.period, 1);
  for (x = 1:experiments)
    printf("Begin experiment #%d out of %d\n", x, experiments);
    disp("Hashing F1...");
    [mh_count{1}, hash_size] = minhash_f1(seq_d, args.k(y), args.period, F1);

    disp("Hash count (F2)...");
    [sim_instance, htable] = minhash_hashcount(mh_count{1}, args.k(y), hash_size, args.period);
    count_a = 2; count_b = 1;
    for (j = 1:size(similarity, 2))
      similarity(x, j) = sim_instance(count_a, count_b);
      count_a++;
      if (count_a > size(sim_instance, 1))
        count_b++;
        count_a = count_b + 1;
      endif
    endfor
  endfor

  disp("Hashing F2...");
  mh_count{2} = bpppf_f2(mh_count{1}, sim_instance, args.k(y), args.period, args.min_sim);

  disp("Finding exact F2 similarities...");
  [exact_sim, exact_supp] = exact_similarity(mh_count{2}, seq_d, args.period);

  exact_sim = repmat(exact_sim, experiments, 1);
  sim_err = abs(exact_sim - similarity);
  sim_err = reshape(sim_err, size(sim_err, 1) * size(sim_err, 2), 1);
  sim_err_mean(y) = mean(sim_err);
  sim_err_std(y) = std(sim_err);
  disp("END");
endfor