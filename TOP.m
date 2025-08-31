%TEST CASE - COMPLETE ENCRYPTION AND DECRYPTION TEST
function TOP_mod()
    disp(' TOP MODULE ');
    
    % Test data
    plaintext_original = input("Enter the Plaintext : ", 's');
    secret_key = 'lokijbhygtfrdesw';
    
    disp(['Original plaintext: ' plaintext_original]);
    disp(['Secret key: ' secret_key]);
    
    

    %% Encryption
    disp('--- Encryption ---');

    ciphertext = AES_MODULE(plaintext_original, secret_key);
    

    [RED, GREEN, BLUE] = RGB_CONVERTER_MODULE(ciphertext); 
    

    IMAGE_CONVERTER_MODULE(RED, GREEN, BLUE, secret_key);



    %% Decryption
    
        disp('--- Decryption ---');
        disp('Decrypted result:');
        img256 = imread(input('Enter the Image address :','s'));
        [RED, GREEN, BLUE] = REVERSE_IMAGE_CONVERTER(img256, secret_key);
        disp("RED : "); disp(RED);
        disp("GREEN : ");disp(GREEN);
        disp("BLUE : ");disp(BLUE);
        ciphertext = REVERSE_RGB(RED, GREEN, BLUE);

        disp('reversiddu');disp(ciphertext)
        decrypted = AES_DECRYPT_MODULE(ciphertext, secret_key);
        
        % Verify
        if strcmp(char(decrypted), plaintext_original)
            disp('---> DATA DECRYPTED SUCCESSFULLY ');
         else
            disp(' ERROR');
            
        end


end

% Run the complete test
TOP_mod();