function [COM] = hcfcom(image)
%     ubah tipenya ke double
    image = double(image);
    
%     kalibrasi: downsample
%     [r c] = size(image);
%     cal = image(1:2:r,1:2:c) + ...
%           image(1:2:r,2:2:c) + ...
%           image(2:2:r,1:2:c) + ...
%           image(2:2:r,2:2:c);
%     cal = floor(cal/4);
    cal = imresize(image, 0.5);
    
%     itung horizontal adjacency histogram
    h = cal*256 + circshift(cal,[0 -1]);
    h = histc(h(:)',[0:256*256-1]);
    h = reshape(h,[256,256])';

%     2D Fourier transform
    DFT = fft2(h);
    
%     Ambil norm kuadran 1 jadi HCF
    HCF = abs(DFT(1:size(DFT,1)/2,1:ceil((size(DFT,2)-1)/2)+1));
    
    [baris kolom] = size(HCF);
    ij = ones(baris,1)*[1:kolom] + (ones(kolom,1)*[1:baris])' - 2;
    COM = sum(sum(ij.*HCF)) / sum(sum(HCF));
end