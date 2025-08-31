%% AES DECRYPTION MODULE - FIXED TO MATCH YOUR ENCRYPTION
function plaintext = AES_DECRYPT_MODULE(ciphertext, secret_key)
    cipher = uint8(ciphertext);
    key = uint8(secret_key);
    
    % If input is 4x4 matrix, flatten it (reverse of encryption reshape)
    if size(cipher, 1) == 4 && size(cipher, 2) == 4
        cipher = reshape(cipher', 1, []);
    end
    
    % Decrypt
    plaintext = aes128_decrypt(cipher, key);
    
    % Display only the decrypted value as characters
    disp(char(plaintext));
end

function plaintext = aes128_decrypt(ciphertext, key)
    assert(isa(ciphertext, 'uint8') && isa(key, 'uint8'), 'Inputs must be uint8');
    assert(length(ciphertext) == 16 && length(key) == 16, 'Inputs must be 16 bytes');
    
    sbox = get_sbox();
    inv_sbox = get_inv_sbox();
    round_keys = key_expansion(key, sbox);
    
    % Initialize state
    state = reshape(ciphertext, 4, 4);
    
    % Initial round key addition (last round key)
    state = bitxor(state, round_keys(:,:,11));
    
    % Reverse rounds 10 down to 2
    for r = 10:-1:2
        state = inv_shift_rows(state);
        state = inv_sub_bytes(state, inv_sbox);
        state = bitxor(state, round_keys(:,:,r));
        state = inv_mix_columns(state);
    end
    
    % Final round (no inv_mix_columns)
    state = inv_shift_rows(state);
    state = inv_sub_bytes(state, inv_sbox);
    state = bitxor(state, round_keys(:,:,1));
    
    plaintext = reshape(state, 1, []);

    
end

%% INVERSE FUNCTIONS FOR DECRYPTION
function inv_sbox = get_inv_sbox()
    inv_sbox = uint8([...
        82 9 106 213 48 54 165 56 191 64 163 158 129 243 215 251;
        124 227 57 130 155 47 255 135 52 142 67 68 196 222 233 203;
        84 123 148 50 166 194 35 61 238 76 149 11 66 250 195 78;
        8 46 161 102 40 217 36 178 118 91 162 73 109 139 209 37;
        114 248 246 100 134 104 152 22 212 164 92 204 93 101 182 146;
        108 112 72 80 253 237 185 218 94 21 70 87 167 141 157 132;
        144 216 171 0 140 188 211 10 247 228 88 5 184 179 69 6;
        208 44 30 143 202 63 15 2 193 175 189 3 1 19 138 107;
        58 145 17 65 79 103 220 234 151 242 207 206 240 180 230 115;
        150 172 116 34 231 173 53 133 226 249 55 232 28 117 223 110;
        71 241 26 113 29 41 197 137 111 183 98 14 170 24 190 27;
        252 86 62 75 198 210 121 32 154 219 192 254 120 205 90 244;
        31 221 168 51 136 7 199 49 177 18 16 89 39 128 236 95;
        96 81 127 169 25 181 74 13 45 229 122 159 147 201 156 239;
        160 224 59 77 174 42 245 176 200 235 187 60 131 83 153 97;
        23 43 4 126 186 119 214 38 225 105 20 99 85 33 12 125]);
    inv_sbox = reshape(inv_sbox', 1, []);
end

function state = inv_sub_bytes(state, inv_sbox)
    state = arrayfun(@(x) inv_sbox(double(x)+1), state);
end

function state = inv_shift_rows(state)
    state(2,:) = circshift(state(2,:), 1);
    state(3,:) = circshift(state(3,:), 2);
    state(4,:) = circshift(state(4,:), 3);
end

% FIXED: Use your xtime function approach for inverse mix columns
function state = inv_mix_columns(s)
    for c = 1:4
        a = s(:,c);
        % Inverse MixColumns using your xtime-based approach
        state(:,c) = [
            bitxor(bitxor(bitxor(xtimes(a(1), 14), xtimes(a(2), 11)), xtimes(a(3), 13)), xtimes(a(4), 9));
            bitxor(bitxor(bitxor(xtimes(a(1), 9), xtimes(a(2), 14)), xtimes(a(3), 11)), xtimes(a(4), 13));
            bitxor(bitxor(bitxor(xtimes(a(1), 13), xtimes(a(2), 9)), xtimes(a(3), 14)), xtimes(a(4), 11));
            bitxor(bitxor(bitxor(xtimes(a(1), 11), xtimes(a(2), 13)), xtimes(a(3), 9)), xtimes(a(4), 14))
        ];
    end
end

% Extended xtime function for inverse mix columns (matches your encryption style)
function out = xtimes(x, mult)
    out = uint8(0);
    x = uint8(x);
    
    % Multiply by repeated xtime operations
    for i = 1:8
        if bitget(mult, i)
            out = bitxor(out, x);
        end
        x = xtime(x);
    end
end

% Your original xtime function (copied exactly)
function out = xtime(x)
    out = bitshift(x,1);
    out(bitget(x,8)==1) = bitxor(out(bitget(x,8)==1), 27); % AES irreducible poly: x^8 + x^4 + x^3 + x + 1
    out = bitand(out, 255); % Ensure 8-bit
end

%% ORIGINAL HELPER FUNCTIONS (copied exactly from your encryption)
function sbox = get_sbox()
    sbox = [... % AES S-box
        99 124 119 123 242 107 111 197 48 1 103 43 254 215 171 118;
        202 130 201 125 250 89 71 240 173 212 162 175 156 164 114 192;
        183 253 147 38 54 63 247 204 52 165 229 241 113 216 49 21;
        4 199 35 195 24 150 5 154 7 18 128 226 235 39 178 117;
        9 131 44 26 27 110 90 160 82 59 214 179 41 227 47 132;
        83 209 0 237 32 252 177 91 106 203 190 57 74 76 88 207;
        208 239 170 251 67 77 51 133 69 249 2 127 80 60 159 168;
        81 163 64 143 146 157 56 245 188 182 218 33 16 255 243 210;
        205 12 19 236 95 151 68 23 196 167 126 61 100 93 25 115;
        96 129 79 220 34 42 144 136 70 238 184 20 222 94 11 219;
        224 50 58 10 73 6 36 92 194 211 172 98 145 149 228 121;
        231 200 55 109 141 213 78 169 108 86 244 234 101 122 174 8;
        186 120 37 46 28 166 180 198 232 221 116 31 75 189 139 138;
        112 62 181 102 72 3 246 14 97 53 87 185 134 193 29 158;
        225 248 152 17 105 217 142 148 155 30 135 233 206 85 40 223;
        140 161 137 13 191 230 66 104 65 153 45 15 176 84 187 22];
    sbox = reshape(uint8(sbox'), 1, []);
end

function round_keys = key_expansion(key, sbox)
    Nk = 4; Nr = 10;
    w = reshape(key, 4, Nk);
    round_keys = zeros(4, 4, Nr+1, 'uint8');
    round_keys(:,:,1) = w;
    rcon = uint8([1 2 4 8 16 32 64 128 27 54]);
    
    for i = Nk+1 : 4*(Nr+1)
        temp = w(:,end);
        if mod(i-1, Nk) == 0
            temp = circshift(temp, -1);
            temp = uint8(arrayfun(@(x) sbox(double(x)+1), temp));
            temp(1) = bitxor(temp(1), rcon((i-1)/Nk));
        end
        new_col = bitxor(w(:,end-Nk+1), temp);
        w = [w new_col];
        if mod(i,4) == 0
            round_keys(:,:,i/4) = w(:,end-3:end);
        end
    end
end

