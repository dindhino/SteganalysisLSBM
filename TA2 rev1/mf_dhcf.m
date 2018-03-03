function [output] = mf_dhcf(data)
    output = {'',0;'',0};
    if data<=105
        output(1,1) = {'kecil'};
        output(1,2) = {1};
        output(2,1) = {'kecil'};
        output(2,2) = {1};
    elseif data>105 & data<128
        output(1,1) = {'kecil'};
        output(1,2) = {(128-data)/(128-105)};
        output(2,1) = {'besar'};
        output(2,2) = {(data-105)/(128-105)};
    else
        output(1,1) = {'besar'};
        output(1,2) = {1};
        output(2,1) = {'besar'};
        output(2,2) = {1};
    end
end