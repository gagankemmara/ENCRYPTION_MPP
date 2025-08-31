
function result = rotateLeft(arr, N)
    result = circshift(arr, [0 -N]);
end
