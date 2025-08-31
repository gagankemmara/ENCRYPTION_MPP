function positions = generate_unique_positions(key)
    seed = key_to_seed(key);
    rng(seed);
    idx = randperm(256, 16);
    rows = floor((idx - 1) / 16);
    cols = mod((idx - 1), 16);
    positions = [rows', cols'];
end
