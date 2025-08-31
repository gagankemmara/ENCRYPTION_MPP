function ciphertext = AES_MODULE(plane, secrect_key)
    plaintext = uint8(plane);    
    key = uint8(secrect_key);    
    ciphertext = aes128_encrypt(plaintext, key);
    % Reshape to 4x4 matrix row-wise and directly return
    ciphertext = reshape(ciphertext, 4, 4)'; 
    disp('Cipher');disp(ciphertext);
end

function ciphertext = aes128_encrypt(plaintext, key)
    assert(isa(plaintext, 'uint8') && isa(key, 'uint8'), 'Inputs must be uint8');
    assert(length(plaintext) == 16 && length(key) == 16, 'Inputs must be 16 bytes');

    sbox = get_sbox();
    round_keys = key_expansion(key, sbox);

    state = reshape(plaintext, 4, 4);
    state = bitxor(state, round_keys(:,:,1));

    for r = 2:11
        state = sub_bytes(state, sbox);
        state = shift_rows(state);
        if r ~= 11
            state = mix_columns(state);
        end
        state = bitxor(state, round_keys(:,:,r));
    end

    ciphertext = reshape(state, 1, []);
end

%% --- Helper Functions ---
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

function state = sub_bytes(state, sbox)
    state = arrayfun(@(x) sbox(double(x)+1), state);
end

function state = shift_rows(state)
    state(2,:) = circshift(state(2,:), -1);
    state(3,:) = circshift(state(3,:), -2);
    state(4,:) = circshift(state(4,:), -3);
end

function out = xtime(x)
    out = bitshift(x,1);
    out(bitget(x,8)==1) = bitxor(out(bitget(x,8)==1), 27); % AES irreducible poly: x^8 + x^4 + x^3 + x + 1
    out = bitand(out, 255); % Ensure 8-bit
end

function state = mix_columns(s)
    for c = 1:4
        a = s(:,c);
        state(:,c) = [
            bitxor(bitxor(xtime(a(1)), bitxor(xtime(a(2)), a(2))), bitxor(a(3), a(4)));
            bitxor(bitxor(xtime(a(2)), bitxor(xtime(a(3)), a(3))), bitxor(a(4), a(1)));
            bitxor(bitxor(xtime(a(3)), bitxor(xtime(a(4)), a(4))), bitxor(a(1), a(2)));
            bitxor(bitxor(xtime(a(4)), bitxor(xtime(a(1)), a(1))), bitxor(a(2), a(3)));
        ];
    end
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
