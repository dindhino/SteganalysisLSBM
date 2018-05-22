close all;
clear;
clc;

load indeks
dataset = hdf5read('food_c101_n1000_r384x384x3.h5', '/images');
dataset = permute(dataset,[4 3 2 1]);
im = zeros(384,384,3);
for idx=1:size(indeks_pengamatan,2)
    im = zeros(384,384,3);
    for chn=1:3
        im(:,:,chn) = dataset(indeks_pengamatan(idx),:,:,chn);
    end
    im = KompresiImage(uint8(im));
%     imwrite(im, strcat('Dataset/DataPengamatan/Cover/IntentionalAttack/Compression/',num2str(idx),'.jpg'));
end