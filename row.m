function out = row(BIN)
    BIN = BIN - '0';  % Convert char array to numeric [0 1 1 ...]
    out = zeros(1, 8);

    for i = 1:8
        if mod(i-1, 2) == 1
            out(i) = notGate(BIN(i));
        else
            out(i) = BIN(i);
        end
    end

    out = rotateRight(out, 5);

    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end
end
