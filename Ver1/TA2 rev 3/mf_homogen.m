function [output] = mf_homogen(data)
    output = {'',0;'',0};
    if data<=0.66
        output(1,1) = {'kecil'};
        output(1,2) = {1};
        output(2,1) = {'kecil'};
        output(2,2) = {1};
    elseif data>0.66 & data<0.77
        output(1,1) = {'kecil'};
        output(1,2) = {(0.77-data)/(0.77-0.66)};
        output(2,1) = {'besar'};
        output(2,2) = {(data-0.66)/(0.77-0.66)};
    else
        output(1,1) = {'besar'};
        output(1,2) = {1};
        output(2,1) = {'besar'};
        output(2,2) = {1};
    end
end