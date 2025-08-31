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
%% Reverse RED
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




function result = rotateRight(arr, N)
    result = circshift(arr, [0 N]);
end

function result = rotateLeft(arr, N)
    result = circshift(arr, [0 -N]);
end

%% Test the functions ---
BIT = [1 0 1 1 1 1 1 1];
B = makeRed(BIT);

disp("Input: "); disp(BIT)
fprintf("RED    :"); disp(B)
fprintf("REVERSED :"); disp(reverseMakeRed(B))
