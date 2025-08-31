function IMAGE_CONVERTER_MODULE(RED, GREEN, BLUE, secret_key)
    disp("RED : ");disp(RED)
disp("GREEN : "); disp(GREEN);
disp("BLUE : "); disp(BLUE);
    % Step 1: Construct 4x4 RGB image from R,G,B arrays
    img = uint8(zeros(4, 4, 3));
    index = 1;
    for i = 1:4
        for j = 1:4
            img(i,j,1) = RED(index);
            img(i,j,2) = GREEN(index);
            img(i,j,3) = BLUE(index);
            index = index + 1;
        end
    end

    % Step 2: Prepare secret key
    secret_array = uint8(secret_key);

    % Step 3: Initialize 16x16 RGB random image
    img256 = uint8(randi([0, 255], [64, 64, 3]));

    k = 1;
    for i1 = 1:4
        for j1 = 1:4
            % Check key length
            if k > length(secret_array)
                error('Secret key too short. Must be >= 16 for 4x4 image.');
            end

            % Map to 16x16 location
            i = floor(secret_array(k) / 16) + 1; 
            j = mod(secret_array(k), 16) + 1;

            % Place 4x4 pixel into 16x16 random map
            img256(i,j,:) = img(i1,j1,:);

            k = k + 1;
        end
    end

    % Step 4: Display & Save
    imshow(imresize(img, [400 400], 'nearest'));
    imwrite(img, 'Image1.png');

    imshow(imresize(img256, [512 512], 'nearest'));
    imwrite(img256, 'encrpted.png');

end
