function original = reverseMakeBlue(out)
    % Step 1: XOR each bit with 1
    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end

    % Step 2: Rotate left by 4
    original = rotateLeft(out, 4);

    % Step 3: Complement all bits
    for i = 1:8
        original(i) = notGate(original(i));
    end
end