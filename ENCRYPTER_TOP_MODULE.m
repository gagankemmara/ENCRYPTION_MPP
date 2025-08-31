
function ENCRYPTER_TOP_MODULE()
    plane = input("Enter THE PLAINTEXT: ", 's');
    
    secret_key = 'lokijuhygtfrdesw'; 

    % Encrypt (Assume AES_MODULE returns 16 bytes of cipher text)
    cipherText = AES_MODULE(plane, secret_key);  
    % Convert to RGB
    [RED, GREEN, BLUE] = RGB_CONVERTER_MODULE(cipherText); 

    % Convert and embed into image
    IMAGE_CONVERTER_MODULE(RED, GREEN, BLUE, secret_key);
end
