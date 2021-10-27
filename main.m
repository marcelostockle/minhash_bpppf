% IMPORTANT: synthetic sequences take integer values from 0 to args.symbols-1

args.len = 100000;
args.symbols = 300;
args.period = 5;
args.support = 1000;
args.k = 100;
args.min_support = 300 / args.len;
args.min_sim = 0.01;

seq = synth_random(args.symbols, args.len);
%% [seq_d, maxpattern]= synth_semideterm(args.symbols, seq, args.period, args.support);
[seq_d, maxpattern]= synth_test(args.symbols, seq, args.period);

[F1, count] = bpppf_f1(seq_d, args.symbols, args.period, args.min_support);

mh_count = cell(args.period, 1);
[mh_count{1}, hash_size] = minhash_hashing(seq_d, args.k, args.period, F1);

[similarity, htable] = minhash_candidates(mh_count{1}, args.k, hash_size, args.period);
mh_count{2} = bpppf_f2(mh_count{1}, similarity, args.k, args.period, args.min_sim);

exact_sim = exact_similarity(mh_count{2}, seq_d, args.period);