close all;
clear;
clc;

load indeks
load message
dataset = hdf5read('food_c101_n1000_r384x384x3.h5', '/images');
dataset = permute(dataset,[4 3 2 1]);
im = zeros(384,384,3);
for idx=1:size(indeks_pengamatan,2)
    for chn=1:3
        im(:,:,chn) = dataset(indeks_pengamatan(idx),:,:,chn);
    end
    for payload=1:5
        I = uint8(im);
        if payload==1
            I(:,:,1) = LSBM(I(:,:,1), message, 45);
            I(:,:,2) = LSBM(I(:,:,2), message, 0);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
            I = imresize(I, 0.5);
%             imwrite(I, strcat('Dataset/DataPengamatan/Stego/IntentionalAttack/Scaling/Payload15%/',num2str(idx),'.png'));
        elseif payload==2
            I(:,:,1) = LSBM(I(:,:,1), message, 75);
            I(:,:,2) = LSBM(I(:,:,2), message, 0);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
            I = imresize(I, 0.5);
%             imwrite(I, strcat('Dataset/DataPengamatan/Stego/IntentionalAttack/Scaling/Payload25%/',num2str(idx),'.png'));
        elseif payload==3
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 50);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
            I = imresize(I, 0.5);
%             imwrite(I, strcat('Dataset/DataPengamatan/Stego/IntentionalAttack/Scaling/Payload50%/',num2str(idx),'.png'));
        elseif payload==4
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 100);
            I(:,:,3) = LSBM(I(:,:,3), message, 25);
            I = imresize(I, 0.5);
%             imwrite(I, strcat('Dataset/DataPengamatan/Stego/IntentionalAttack/Scaling/Payload75%/',num2str(idx),'.png'));
        elseif payload==5
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 100);
            I(:,:,3) = LSBM(I(:,:,3), message, 100);
            I = imresize(I, 0.5);
%             imwrite(I, strcat('Dataset/DataPengamatan/Stego/IntentionalAttack/Scaling/Payload100%/',num2str(idx),'.png'));
        end
    end
end