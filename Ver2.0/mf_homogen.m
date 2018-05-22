function [output] = mf_homogen(data)
    output = {'',0;'',0};
    if data<=0.87
        output(1,1) = {'stego'};
        output(1,2) = {1};
        output(2,1) = {'cover'};
        output(2,2) = {0};
    elseif data>0.87 & data<1
        output(1,1) = {'stego'};
        output(1,2) = {(1-data)/(1-0.87)};
        output(2,1) = {'cover'};
        output(2,2) = {(data-0.87)/(1-0.87)};
    else
        output(1,1) = {'stego'};
        output(1,2) = {0};
        output(2,1) = {'cover'};
        output(2,2) = {1};
    end
end