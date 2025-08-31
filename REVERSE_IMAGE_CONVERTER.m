function [RED, GREEN, BLUE] = REVERSE_IMAGE_CONVERTER(img256, secret_key)

    % Step 1: Prepare secret key
    secret_array = uint8(secret_key);

    % Step 2: Initialize arrays
    RED   = zeros(1,16,'uint8');
    GREEN = zeros(1,16,'uint8');
    BLUE  = zeros(1,16,'uint8');

    % Step 3: Extract the 16 hidden pixels in order
    k = 1;
    for i1 = 1:4
        for j1 = 1:4
            % Compute the 16x16 location using the same mapping
            i = floor(secret_array(k) / 16) + 1;
            j = mod(secret_array(k), 16) + 1;

            % Extract the pixel from img256
            pixel = squeeze(img256(i,j,:));

            % Store into output arrays
            RED(k)   = pixel(1);
            GREEN(k) = pixel(2);
            BLUE(k)  = pixel(3);

            k = k + 1;
        end
    end

    % Optional: Display the recovered 4x4 image
    img_recovered = uint8(zeros(4,4,3));
    index = 1;
    for i = 1:4
        for j = 1:4
            img_recovered(i,j,1) = RED(index);
            img_recovered(i,j,2) = GREEN(index);
            img_recovered(i,j,3) = BLUE(index);
            index = index + 1;
        end
    end

end
