function [output] = mf_green(data)
    output = {'',0;'',0};
    if data<25
        output(1,1) = {'rendah'};
        output(1,2) = {1};
        output(2,1) = {'rendah'};
        output(2,2) = {1};
    elseif data>=25 & data<61
        output(1,1) = {'rendah'};
        output(1,2) = {(61-data)/(61-25)};
        output(2,1) = {'tinggi'};
        output(2,2) = {(data-25)/(61-25)};
    else
        output(1,1) = {'tinggi'};
        output(1,2) = {1};
        output(2,1) = {'tinggi'};
        output(2,2) = {1};
    end
end