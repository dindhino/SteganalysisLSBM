close all;
clear;
clc;

load pengamatan_stego
load pengamatan_cover

% variable
nf = 5;
selisih = [];

for chn=1:3
    if chn==1
        data_stego = stego_red;
        data_cover = cover_red;
    elseif chn==2
        data_stego = stego_green;
        data_cover = cover_green;
    elseif chn==3
        data_stego = stego_blue;
        data_cover = cover_blue;
    end
    
    for si=1:size(data_stego,1)
        ci = ceil(si/nf);
        selisih = [selisih; data_stego(si,:)-data_cover(ci,:)];
    end
end

% Hasil untuk rule
fprintf('Contrast\n');
fprintf('\tStego < Cover = %g\n', length(selisih(selisih(:,1)<0)));
fprintf('\tStego > Cover = %g\n', length(selisih(selisih(:,1)>0)));
fprintf('\tStego = Cover = %g\n', length(selisih(selisih(:,1)==0)));
fprintf('Correlation\n');
fprintf('\tStego < Cover = %g\n', length(selisih(selisih(:,2)<0)));
fprintf('\tStego > Cover = %g\n', length(selisih(selisih(:,2)>0)));
fprintf('\tStego = Cover = %g\n', length(selisih(selisih(:,2)==0)));
fprintf('Energy\n');
fprintf('\tStego < Cover = %g\n', length(selisih(selisih(:,3)<0)));
fprintf('\tStego > Cover = %g\n', length(selisih(selisih(:,3)>0)));
fprintf('\tStego = Cover = %g\n', length(selisih(selisih(:,3)==0)));
fprintf('Homogeneity\n');
fprintf('\tStego < Cover = %g\n', length(selisih(selisih(:,4)<0)));
fprintf('\tStego > Cover = %g\n', length(selisih(selisih(:,4)>0)));
fprintf('\tStego = Cover = %g\n', length(selisih(selisih(:,4)==0)));
fprintf('HCF-COM\n');
fprintf('\tStego < Cover = %g\n', length(selisih(selisih(:,5)<0)));
fprintf('\tStego > Cover = %g\n', length(selisih(selisih(:,5)>0)));
fprintf('\tStego = Cover = %g\n\n', length(selisih(selisih(:,5)==0)));

all_cover = [cover_red; cover_green; cover_blue];
all_stego = [stego_red; stego_green; stego_blue];

fprintf('Selisihnya (Stego-Cover): min mean max\n');
min(selisih)
mean(selisih)
max(selisih)
fprintf('Cover : min, mean, max\n');
min(all_cover)
mean(all_cover)
max(all_cover)
fprintf('Stego : min, mean, max\n');
min(all_stego)
mean(all_stego)
max(all_stego)