function randomizer(img, secret_key)

    % Convert secret key to uint8
    secret_array = uint8(secret_key);

    % Initialize a 16x16 RGB image
    img256 = uint8(randi([0, 255], [16, 16, 3]));

    k = 1;
    for i1 = 1:16
        for j1 = 1:16
            % Make sure k does not exceed secret_array length
            if k > length(secret_array)
                break;
            end

            % Compute 1-based indices
            i = floor(secret_array(k)/16) + 1; 
            j = mod(secret_array(k),16) + 1;

            % Assign RGB pixel
            img256(i,j,:) = img(i1,j1,:);

            k = k + 1;
        end
    end

    % Display and save original image
    imshow(imresize(img, [400 400], 'nearest'));
    imwrite(img, 'Image1.png');

    % Display and save randomized image
    imshow(imresize(img256, [512, 512], 'nearest'));
    imwrite(img256, 'Image2.png');
end
