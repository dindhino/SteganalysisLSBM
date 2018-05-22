function [output] = gabunginfitur(input)
%     membership function
    out_kontras = mf_kontras(input(1));
    out_korelasi = mf_korelasi(input(2));
    out_energi = mf_energi(input(3));
    out_homogen = mf_homogen(input(4));
    out_hcfcom = mf_hcfcom(input(5));
    out_all = [out_kontras out_korelasi out_energi out_homogen out_hcfcom];
    out_value = out_all(:,[1 3 5 7 9]);
    out_nilai = out_all(:,[2 4 6 8 10]);
%     rule feature
    value = [rule_fe(cell2mat(out_value(1,:))); rule_fe(cell2mat(out_value(2,:)))];
    nilai = min(cell2mat(out_nilai),[],2);
%     model sugeno
    y = 0;
    for i=1:2
        if strcmp(value(i,:),'cover')
            y = y + (nilai(i)*25);
        else
            y = y + (nilai(i)*75);
        end
    end
    output = y/sum(nilai);
end

