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

%%%  REVERSE ANALOGY 
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

%% NOT
function out = notGate(bit)
    if bit
        out = 0;
    else 
        out = 1;
    end
end

%% XOR
function out = xorGate(b1,b2)
    if b1 == b2
        out = 0;
    else
        out = 1;
    end
end

%% RotateRight
function result = rotateRight(arr, N)
    result = circshift(arr, [0 N]);
end

%% RotateLeft
function result = rotateLeft(arr, N)
    result = circshift(arr, [0 -N]);
end

%% Test case
BIT = [1 0 1 1 1 1 1 1];
B = makeGreen(BIT);

disp("Input: "); disp(BIT)
fprintf("GREEN    :"); disp(B)
fprintf("REVERSED :"); disp(reverseMakeGreen(B))
