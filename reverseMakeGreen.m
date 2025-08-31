function original = reverseMakeGreen(out)
    %  XOR each bit with 1
    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end

    % Rotate left by 5 
    original = rotateLeft(out, 5);

    % Complement odd bits 
    for i = 1:8
        if mod(i-1, 2) == 1
            original(i) = ~original(i);
        end
    end
end
