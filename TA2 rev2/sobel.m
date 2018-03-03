function G = sobel(img)

%     img dalam bentuk grayscale
%     kalau imgnya rgb, ubah ke grayscale
%     Ubah ke grayscale
%     img = rgb2gray(img);

%     Ubah ke double
    img = im2double(img);

%     Konvolusi Sobel gx
    gx = [-1,0,1; -2,0,2; -1,0,1];
    sobel_gx = conv2(img,gx,'same');

%     Konvolusi Sobel gy
    gy = [-1,-2,-1; 0,0,0; 1,2,1];
    sobel_gy = conv2(img,gy,'same');

%     Konvolusi Sobel gabungan gx & gy
    sobel_gab = sqrt(sobel_gx.^2 + sobel_gy.^2);

%     gabungan
    G = sobel_gab;

%     gx
%     G = sobel_gx;
% 
%     gy
%     G = sobel_gy;
end