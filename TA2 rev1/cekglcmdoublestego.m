close all;
clear;
clc;

load message;
load message2;
glcm_dstego = [];

for run=1:1000
    fprintf('Cek data ke: %i \n', (run));
    path = strcat('CoverRGB/',int2str(run),'.png');
    im_cover = imread(path);
    im_stego = zeros(size(im_cover));
    im_stego(:,:,1) = LSBM(im_cover(:,:,1), message, 100);
    im_stego(:,:,2) = LSBM(im_cover(:,:,2), message, 100);
    im_stego(:,:,3) = LSBM(im_cover(:,:,3), message, 100);
    
%     double stego
    im_stego(:,:,1) = LSBM(im_stego(:,:,1), message2, 100);
    im_stego(:,:,2) = LSBM(im_stego(:,:,2), message2, 100);
    im_stego(:,:,3) = LSBM(im_stego(:,:,3), message2, 100);
    
    
    
    for channel=1:3
        gcover = graylevel_comat(im_stego(:,:,channel));
        energi = sum(gcover(:).^2);
        [kolom, baris] = meshgrid(1:size(gcover,1), 1:size(gcover,2));
        homogen = sum(sum(gcover./(1+abs(baris-kolom))));
        kontras = sum(sum((abs(baris-kolom).^2).*gcover));
        meanbaris = sum(sum(baris.*gcover));
        meankolom = sum(sum(kolom.*gcover));
        stdbaris = sqrt(sum(sum((baris - meanbaris).^2 .* gcover)));
        stdkolom = sqrt(sum(sum((kolom - meankolom).^2 .* gcover)));
        korelasi = sum(sum((baris - meanbaris) .* (kolom - meankolom) .* gcover)) / (stdbaris * stdkolom);
        glcm_dstego = [glcm_dstego; kontras korelasi energi homogen];
    end
end

save hasilglcm_dstego glcm_dstego;