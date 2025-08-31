function reverseRandomizerr(img256,secrect_key)
          img = uint8(randi([0, 255], [4, 4, 3]));

          % Get binary mapping from key
            secretArray = uint8(secrect_key);  % Correct conversion
            ROW = zeros(1, 16);
            COL = zeros(1, 16);

      % Raeding serect_key
      for i = 1:16
        BIN = dec2bin(secretArray(i), 8);   % 8-bit padded string
        ROW(i) = bin2dec(char(row(BIN) + '0'));
        COL(i) = bin2dec(char(col(BIN) + '0'));
      end
      % Reestablish 4X4 encrypted image from 64X64 random
    index = 1;
    for i = 1:4
        for j = 1:4
            x = ROW(index);
            y = COL(index);
            img(i, j, :)=img256(x, y, :);
            index = index + 1;
        end
    end
    imshow(imresize(img, 40, 'nearest'));
    imwrite(img, 'Image3.png');
    disp(ROW);
    disp(COL);
end
%% TEST case
img256=imread('Image2.png');
secrect_key = 'thishjksfrthnbgf';
reverseRandomizerr(img256,secrect_key)