function [output] = mf_blue(data)
    output = {'',0;'',0};
    if data<25
        output(1,1) = {'rendah'};
        output(1,2) = {1};
        output(2,1) = {'rendah'};
        output(2,2) = {1};
    elseif data>=25 & data<52
        output(1,1) = {'rendah'};
        output(1,2) = {(52-data)/(52-25)};
        output(2,1) = {'tinggi'};
        output(2,2) = {(data-25)/(52-25)};
    else
        output(1,1) = {'tinggi'};
        output(1,2) = {1};
        output(2,1) = {'tinggi'};
        output(2,2) = {1};
    end
end