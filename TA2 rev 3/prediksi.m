function [output] = prediksi(data)
    output = '';
    if data<45
        output = 'cover';
    else
        output = 'stego';
    end
end