function DECRYPTER_TOP_MODULE()
    img256_addr = imread(input("Enter the address of the encrypted Image: ", 's'));
    
    secret_key = 'lokijuhygtfrdesw'; 

    % Image to RGB arrays
    [RED, GREEN, BLUE] = REVERSE_IMAGE_CONVERTER(img256_addr, secret_key) ;
    % RGB to Cipher state matrix
    cipher = REVERSE_RGB(RED, GREEN, BLUE);

    % AES decrypter
    decrypted = AES_DECRYPT_MODULE(cipher, secret_key);



    disp('=== Complete AES Encryption/Decryption Test ===');
    
    % Test data
    plaintext_original = 'aqswdefrgthyjuki';
    secret_key = 'lokijuhygtfrdesw';
    
    disp(['Original plaintext: ' plaintext_original]);
    disp(['Secret key: ' secret_key]);
    
    
    disp('--- Decryption ---');
    disp('Decrypted result:');
    
    
    % Verify
    if strcmp(char(decrypted), plaintext_original)
        disp('✓ SUCCESS: Perfect match! Encryption and decryption work correctly.');
    else
        disp('✗ ERROR: Mismatch detected');
        disp(['Expected: ' plaintext_original]);
        disp(['Got: ' char(decrypted)]);
    end
end
