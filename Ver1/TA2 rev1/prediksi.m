function [output] = prediksi(data)
    output = '';
    if data<25
        output = 'cover';
    elseif data>=25 & data<75
        cekcover = (75-data)/(75-25);
        cekstego = (data-25)/(75-25);
        if cekcover > cekstego
            output='cover';
        else
            output='stego';
        end
    else
        output = 'stego';
    end
end