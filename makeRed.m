%% Make RED
function out = makeRed(B)
    out = zeros(1, 8);
    
    for i = 1:8
        if mod(i-1, 2) == 0   
            out(i) = notGate(B(i));
        else
            out(i) = B(i);
        end
    end

    out = rotateRight(out, 3);

    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end
end