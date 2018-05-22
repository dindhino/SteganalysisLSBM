function [output] = mf_hcfcom(data)
    output = {'',0;'',0};
    if data<=127.4
        output(1,1) = {'stego'};
        output(1,2) = {1};
        output(2,1) = {'cover'};
        output(2,2) = {0};
    elseif data>127.4 & data<127.5
        output(1,1) = {'stego'};
        output(1,2) = {(127.5-data)/(127.5-127.4)};
        output(2,1) = {'cover'};
        output(2,2) = {(data-127.4)/(127.5-127.4)};
    else
        output(1,1) = {'stego'};
        output(1,2) = {0};
        output(2,1) = {'cover'};
        output(2,2) = {1};
    end
end