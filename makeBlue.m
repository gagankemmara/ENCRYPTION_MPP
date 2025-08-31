function out = makeBlue(B)
    out = zeros(1, 8);

    % Step 1: Complement all bits
    for i = 1:8
        out(i) = notGate(B(i));
    end

    % Step 2: Rotate right by 4
    out = rotateRight(out, 4);

    % Step 3: XOR each bit with 1
    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end
end