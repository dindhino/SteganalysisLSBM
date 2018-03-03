close all;
clear;
clc;

load message;
dhcfcom_cover = [];
dhcfcom_stego = [];
for run=1:1000
    fprintf('Cek data ke: %i \n', (run));
    path = strcat('CoverRGB/',int2str(run),'.png');
    im_cover = imread(path);
    im_stego = zeros(size(im_cover));
    im_stego(:,:,1) = LSBM(im_cover(:,:,1), message, 100);
    im_stego(:,:,2) = LSBM(im_cover(:,:,2), message, 100);
    im_stego(:,:,3) = LSBM(im_cover(:,:,3), message, 100);
    
    dcover = [];
    dstego = [];
    for channel=1:3
        edge_cover = sobel(im_cover(:,:,channel));
        edge_stego = sobel(im_stego(:,:,channel));
        dc_cover = CenterOfMass(HistogramCharacteristicFunction(edge_cover));
        dc_stego = CenterOfMass(HistogramCharacteristicFunction(edge_stego));
        dcover = [dcover, dc_cover];
        dstego = [dstego, dc_stego];
    end
    
    dhcfcom_cover = [dhcfcom_cover; dcover];
    dhcfcom_stego = [dhcfcom_stego; dstego];
end

save hasilhdcf dhcfcom_cover dhcfcom_stego;