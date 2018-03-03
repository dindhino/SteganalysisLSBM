close all;
clear;
clc;

% parameter
jumlahdata = 0;
benar = 0;

% loop n data set
for run=100:100
    fprintf('Cek data ke: %i \n', (jumlahdata+1));
%     disp(jumlahdata+1);
    
%     Step 1 : Matriks gambar per channel
    path = strcat('CoverRGB/',int2str(run),'.png');
    It = imread(path); 
%     figure; imshow(It);
    Itred = It(:,:,1);
    Itgreen = It(:,:,2);
    Itblue = It(:,:,3);
        
%     Step 2 : LSB-M
    load message;
    kapasitas = 100;
    Irred = LSBM(Itred, message, kapasitas);
    Irgreen = LSBM(Itgreen, message, kapasitas);
    Irblue = LSBM(Itblue, message, kapasitas);
%     figure;
%     subplot(2,3,1);imshow(Irred);title('Red');
%     subplot(2,3,2);imshow(Irgreen);title('Green');
%     subplot(2,3,3);imshow(Irblue);title('Blue');
    
%     Step 3 : Difference Matrix
    Dtred = DiffMatr(Itred);
    Dtgreen = DiffMatr(Itgreen);
    Dtblue = DiffMatr(Itblue);
    
    Drred = DiffMatr(Irred);
    Drgreen = DiffMatr(Irgreen);
    Drblue = DiffMatr(Irblue);
    
%     Step 4: GLCM
%     glcm_red = glcm(Irred);
%     glcm_green = glcm(Irgreen);
%     glcm_blue = glcm(Irblue);
    
%     Step 5: Edge Detection dengan Operator Sobel
    sobel_red = sobel(Irred);
    sobel_green = sobel(Irgreen);
    sobel_blue = sobel(Irblue);
    
%     Step 6: Daerah Plain
    mp_red = im2bw(sobel_red);
    mp_red(find(mp_red == 0)) = 1;
    mp_red(find(mp_red == 1)) = 0;
    
    mp_green = im2bw(sobel_green);
    mp_green(find(mp_green == 0)) = 1;
    mp_green(find(mp_green == 1)) = 0;
    
    mp_blue = im2bw(sobel_blue);
    mp_blue(find(mp_blue == 0)) = 1;
    mp_blue(find(mp_blue == 1)) = 0;
    
%     Step 7: Pengambilan Daerah Plain
    Dtred(find(mp_red == 0)) = 0;
    Dtgreen(find(mp_green == 0)) = 0;
    Dtblue(find(mp_blue == 0)) = 0;
    
    Drred(find(mp_red == 0)) = 0;
    Drgreen(find(mp_green == 0)) = 0;
    Drblue(find(mp_blue == 0)) = 0;
    
%     subplot(2,3,4);imshow(Drred);title('Plain Red');
%     subplot(2,3,5);imshow(Drgreen);title('Plain Green');
%     subplot(2,3,6);imshow(Drblue);title('Plain Blue');
    
%     Step 8: DHCF-COM
    Hdtred = CenterOfMass(HistogramCharacteristicFunction(Dtred));
    Hdrred = CenterOfMass(HistogramCharacteristicFunction(Drred));
    RCoM_red = Hdrred/Hdtred;

    Hdtgreen = CenterOfMass(HistogramCharacteristicFunction(Dtgreen));
    Hdrgreen = CenterOfMass(HistogramCharacteristicFunction(Drgreen));
    RCoM_green = Hdrgreen/Hdtgreen;
    
    Hdtblue = CenterOfMass(HistogramCharacteristicFunction(Dtblue));
    Hdrblue = CenterOfMass(HistogramCharacteristicFunction(Drblue));
    RCoM_blue = Hdrblue/Hdtblue;
    
%     Step 9: Decision Making
    Th_red = (mean2(Drred) + 1*std2(Drred)) / (mean2(Dtred) + 1*std2(Dtred));
    Th_green = (mean2(Drgreen) + 1*std2(Drgreen)) / (mean2(Dtgreen) + 1*std2(Dtgreen));
    Th_blue = (mean2(Drblue) + 1*std2(Drblue)) / (mean2(Dtblue) + 1*std2(Dtblue));
    
    dm = ones(1,3);
    
    if RCoM_red <= Th_red
        dm(1) = 0; %stego
    else
        dm(1) = 1; %cover
    end
    
    if RCoM_green <= Th_green
        dm(2) = 0; %stego
    else
        dm(2) = 1; %cover
    end
    
    if RCoM_blue <= Th_blue
        dm(3) = 0; %stego
    else
        dm(3) = 1; %cover
    end
    
    if (dm(1)==1) | (dm(2)==1) | (dm(3)==1)
        disp('Hasil => Cover-Image');
        benar=benar+1;
    else
        disp('Hasil => Stego-Image');
    end
    
    jumlahdata = jumlahdata+1;
end

disp('----------------------------------------');
disp(strcat('Benar  : ', num2str(benar)));
disp(strcat('Akurasi: ', num2str(100*benar/jumlahdata), '%'));