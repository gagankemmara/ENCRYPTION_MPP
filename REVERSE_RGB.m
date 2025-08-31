function cipher = REVERSE_RGB(RED, GREEN, BLUE)
    % REVERSE_RGB_MODULE
    % Input:  RED, GREEN, BLUE arrays (1x16 each)
    % Output: cipher 4x4 matrix (decimal values)

    % Check input length
    assert(length(RED) == 16 && length(GREEN) == 16 && length(BLUE) == 16, ...
        'All RGB arrays must be length 16.');

    cipher = zeros(4,4,'uint8'); % 4x4 output matrix

    index = 1;
    for row = 1:4
        for col = 1:4
            % Convert each channel to 8-bit binary
            Rbin = dec2bin(RED(index),8) - '0';
            Gbin = dec2bin(GREEN(index),8) - '0';
            Bbin = dec2bin(BLUE(index),8) - '0';

            % Apply reverse transformations
            Rorig = reverseMakeRed(Rbin);
            Gorig = reverseMakeGreen(Gbin);
            Borig = reverseMakeBlue(Bbin);

      
            cipher(row, col) = uint8(bi2de(Rorig)); 
            %cipher(row,col) = uint8(bi2de(Gorig)); 
           % cipher(row,col) = uint8(bi2de(Borig)); 
           cipher(row,col) = uint8(bi2de(Borig));
           

            index = index + 1;
            
        end
    end
    
end


