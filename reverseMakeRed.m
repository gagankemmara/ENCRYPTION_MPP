function original = reverseMakeRed(out)
    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end

    original = rotateLeft(out, 3);

    for i = 1:8
        if mod(i-1, 2) == 0
            original(i) = notGate(original(i));  % use same notGate
        end
    end
end
