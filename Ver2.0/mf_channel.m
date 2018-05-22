function [output] = mf_channel(data)
    output = {'',0;'',0};
    if data<=45
        output(1,1) = {'cover'};
        output(1,2) = {1};
        output(2,1) = {'stego'};
        output(2,2) = {0};
    elseif data>45 & data<96
        output(1,1) = {'cover'};
        output(1,2) = {(96-data)/(96-45)};
        output(2,1) = {'stego'};
        output(2,2) = {(data-45)/(96-45)};
    else
        output(1,1) = {'cover'};
        output(1,2) = {0};
        output(2,1) = {'stego'};
        output(2,2) = {1};
    end
end