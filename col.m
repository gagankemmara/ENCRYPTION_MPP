function out=col(BIN)
     BIN = BIN - '0'; 
     out = zeros(1, 8);
    
    for i = 1:8
        if mod(i-1, 2) == 0   
            out(i) = notGate(BIN(i));
        else
            out(i) = BIN(i);
        end
    end

    out = rotateRight(out, 3);

    for i = 1:8
        out(i) = xorGate(out(i), 1);
    end
end