function [output] = mf_channel(data)
    output = {'',0;'',0};
    if data<=11
        output(1,1) = {'rendah'};
        output(1,2) = {1};
        output(2,1) = {'rendah'};
        output(2,2) = {1};
    elseif data>11 & data<95
        output(1,1) = {'rendah'};
        output(1,2) = {(95-data)/(95-11)};
        output(2,1) = {'tinggi'};
        output(2,2) = {(data-11)/(95-11)};
    else
        output(1,1) = {'tinggi'};
        output(1,2) = {1};
        output(2,1) = {'tinggi'};
        output(2,2) = {1};
    end
end