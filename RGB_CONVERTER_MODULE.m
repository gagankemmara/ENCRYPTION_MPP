function [RED, GREEN, BLUE] = RGB_CONVERTER_MODULE(cipher)
    % Check if the cipher is 4x4
    [rows, cols] = size(cipher);
    assert(rows == 4 && cols == 4, 'Input cipher must be a 4x4 matrix.');
    
    % Initialize RGB arrays
    RED = zeros(1, 16);
    GREEN = zeros(1, 16);
    BLUE = zeros(1, 16);

    % Iterate through the 4x4 cipher matrix
    index = 1;
    for row = 1:4
        for col = 1:4
            % Get the current decimal value
            decimalValue = cipher(row, col);

            % Convert to 8-bit binary array
            binArray = dec2bin(decimalValue, 8) - '0';

            % Apply transformations
            RED(index) = bi2de(makeRed(binArray));
            GREEN(index) = bi2de(makeGreen(binArray));
            BLUE(index) = bi2de(makeBlue(binArray));

            % Increment index
            index = index + 1;
        end
    end
end
