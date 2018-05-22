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
    im = imresize(uint8(im), 0.5);
%     imwrite(im, strcat('Dataset/DataPengamatan/Cover/IntentionalAttack/Scaling/',num2str(idx),'.png'));
end