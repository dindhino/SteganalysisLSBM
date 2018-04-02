function [output] = mf_korelasi(data)
    output = {'',0;'',0};
    if data<=0.2 | isnan(data)
        output(1,1) = {'konstan'};
        output(1,2) = {1};
        output(2,1) = {'konstan'};
        output(2,2) = {1};
    elseif data>0.2 & data<0.8
        output(1,1) = {'konstan'};
        output(1,2) = {(0.8-data)/(0.8-0.2)};
        output(2,1) = {'biasa'};
        output(2,2) = {(data-0.2)/(0.8-0.2)};
    else
        output(1,1) = {'biasa'};
        output(1,2) = {1};
        output(2,1) = {'biasa'};
        output(2,2) = {1};
    end
end