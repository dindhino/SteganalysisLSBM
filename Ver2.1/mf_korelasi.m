function [output] = mf_korelasi(data)
    output = {'',0;'',0};
    data(isnan(data)) = 0;
    if data<=0.16
        output(1,1) = {'stego'};
        output(1,2) = {1};
        output(2,1) = {'cover'};
        output(2,2) = {0};
    elseif data>0.16 & data<0.89
        output(1,1) = {'stego'};
        output(1,2) = {(0.89-data)/(0.89-0.16)};
        output(2,1) = {'cover'};
        output(2,2) = {(data-0.16)/(0.89-0.16)};
    else
        output(1,1) = {'stego'};
        output(1,2) = {0};
        output(2,1) = {'cover'};
        output(2,2) = {1};
    end
end