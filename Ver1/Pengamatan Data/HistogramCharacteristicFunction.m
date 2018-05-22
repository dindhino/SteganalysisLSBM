function HCF = HistogramCharacteristicFunction(image)
%     Perhitungan horizontal adjacency histogram
    h = image*256 + circshift(image,[0 -1]);
    h = histc(h(:)',[0:256*256-1]);
    h = reshape(h,[256,256])';

%     Transformasi Fourier 2D
    DFT = fft2(h);
    
%     Norm kuadran 1
    HCF = abs(DFT(1:size(DFT,1)/2,1:ceil((size(DFT,2)-1)/2)+1));
end