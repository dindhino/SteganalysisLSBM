function [output] = mf_kontras(data)
    output = {'',0;'',0};
    if data<=0
        output(1,1) = {'kecil'};
        output(1,2) = {1};
        output(2,1) = {'kecil'};
        output(2,2) = {1};
    elseif data>0 & data<6
        output(1,1) = {'kecil'};
        output(1,2) = {(6-data)/(6-0)};
        output(2,1) = {'besar'};
        output(2,2) = {(data-0)/(6-0)};
    else
        output(1,1) = {'besar'};
        output(1,2) = {1};
        output(2,1) = {'besar'};
        output(2,2) = {1};
    end
end