function [RED, GREEN, BLUE] = IMAGE_TO_RGBe(imagePath)

    img = imread(imagePath);

    % Extract the RGB channels
    RED = img(:, :, 1);   % Red Channel
    GREEN = img(:, :, 2); % Green Channel
    BLUE = img(:, :, 3);  % Blue Channel

    % Convert to 1x16 vectors
    RED = RED(:)';
    GREEN = GREEN(:)';
    BLUE = BLUE(:)';

   
end
[r,g,b]=IMAGE_TO_RGBe('C:\Users\VIKAS K S\OneDrive\Desktop\LOHITH\LOHI_MAT\hdl coder\Image2.png');
disp(r);
disp(g);
disp(b);