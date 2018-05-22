function stego = LSBM(cover, message, kapasitas)
    panjangpesan = round(size(message, 2)*(kapasitas/100));
    if panjangpesan > size(cover,1)*size(cover,2)
        panjangpesan = size(cover,1)*size(cover,2);
    end
    cover = cover';
    stego = cover;
    cover = bitget(cover,1); %lsb cover
    %embedding pesan
    for i=1:panjangpesan
        if cover(i)==1 & message(i)==0
            stego(i) = stego(i) - 1;
        elseif cover(i)==0 & message(i)==1
            stego(i) = stego(i) + 1;
        else %11 atau 00
            stego(i) = stego(i);
        end
    end
    stego = uint8(stego');
end

