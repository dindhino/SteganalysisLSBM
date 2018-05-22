function [hasilanalisis] = analisistekstur(glcm)
    energi = sum(glcm(:).^2);
    [kolom, baris] = meshgrid(1:size(glcm,1), 1:size(glcm,2));
    homogen = sum(sum(glcm./(1+abs(baris-kolom))));
    kontras = sum(sum((abs(baris-kolom).^2).*glcm));
    meanbaris = sum(sum(baris.*glcm));
    meankolom = sum(sum(kolom.*glcm));
    stdbaris = sqrt(sum(sum((baris - meanbaris).^2 .* glcm)));
    stdkolom = sqrt(sum(sum((kolom - meankolom).^2 .* glcm)));
    korelasi = sum(sum((baris - meanbaris) .* (kolom - meankolom) .* glcm)) / (stdbaris * stdkolom);
    hasilanalisis = [kontras korelasi energi homogen];
end

