function [output] = mf_korelasi(data)
    output = {'',0;'',0};
    if data<=0 | isnan(data)
        output(1,1) = {'konstan'};
        output(1,2) = {1};
        output(2,1) = {'konstan'};
        output(2,2) = {1};
    elseif data>0 & data<1
        output(1,1) = {'konstan'};
        output(1,2) = {(1-data)/(1-0)};
        output(2,1) = {'biasa'};
        output(2,2) = {(data-0)/(1-0)};
    else
        output(1,1) = {'biasa'};
        output(1,2) = {1};
        output(2,1) = {'biasa'};
        output(2,2) = {1};
    end
end