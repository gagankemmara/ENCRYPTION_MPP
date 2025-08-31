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
BIT = [1 1 0 1 1 0 1 1];
B = makeBlue(BIT);

disp("Input: "); disp(BIT)
fprintf("BLUE  : "); disp(B)
fprintf("REVERSED : "); disp(reverseMakeBlue(B))