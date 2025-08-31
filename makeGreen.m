function out = makeGreen(B)
    out = zeros(1, 8);

    % Complement odd bits (zero-based indices 1,3,5,7)
    for i = 1:8
        if mod(i-1, 2) == 1  % odd zero-based indices
            out(i) = ~B(i);
        else
            out(i) = B(i);
        end
    end

    % Rotate right by 5
    out = rotateRight(out, 5);

    % XOR each bit with 1
    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end
end