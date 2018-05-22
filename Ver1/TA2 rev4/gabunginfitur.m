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
%     kemungkinan rule
    rule_in_value = [];
    rule_in_nilai = [];
    for kon=1:2
        for kor=1:2
            for en=1:2
                for hom=1:2
                    for hcf=1:2
                        rule_in_value = [rule_in_value; out_value(kon,1) out_value(kor,2) out_value(en,3) out_value(hom,4) out_value(hcf,5)];
                        rule_in_nilai = [rule_in_nilai; out_nilai(kon,1) out_nilai(kor,2) out_nilai(en,3) out_nilai(hom,4) out_nilai(hcf,5)];
                    end
                end
            end
        end
    end
%     rule feature
%     conjuction (and), untuk tiap fitur
    rule_out_value = [];
    for i=1:size(rule_in_value,1)
        rule_out_value = [rule_out_value; rule_fe(cell2mat(rule_in_value(i,:)))];
    end
    rule_out_nilai = min(cell2mat(rule_in_nilai),[],2);
%     disjunction (or), untuk tiap output dari rule
    value = ['stego'; 'cover'];
    maxstego = 0; maxcover = 0;
    for i=1:size(rule_out_value,1)
        if strcmp(rule_out_value(i,:), value(1,:))
            if rule_out_nilai(i,1) > maxstego
                maxstego = rule_out_nilai(i,1);
            end
        end
        if strcmp(rule_out_value(i,:), value(2,:))
            if rule_out_nilai(i,1) > maxcover
                maxcover = rule_out_nilai(i,1);
            end
        end
    end
    nilai = [maxstego; maxcover];
%     model sugeno
    y = 0;
    for i=1:size(nilai,1)
        if strcmp(value(i,:),'cover')
            y = y + (nilai(i)*0);
        else
            y = y + (nilai(i)*100);
        end
    end
    output = y/sum(nilai);
end

