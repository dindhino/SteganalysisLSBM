function [output] = mf_kontras(data)
    output = {'',0;'',0};
    if data<=0
        output(1,1) = {'cover'};
        output(1,2) = {1};
        output(2,1) = {'stego'};
        output(2,2) = {0};
    elseif data>0 & data<0.6
        output(1,1) = {'cover'};
        output(1,2) = {(0.6-data)/(0.6-0)};
        output(2,1) = {'stego'};
        output(2,2) = {(data-0)/(0.6-0)};
    else
        output(1,1) = {'cover'};
        output(1,2) = {0};
        output(2,1) = {'stego'};
        output(2,2) = {1};
    end
end