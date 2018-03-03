function [output] = prediksi(data)
    output = '';
    if data<44
        output = 'cover';
    else
        output = 'stego';
    end
end