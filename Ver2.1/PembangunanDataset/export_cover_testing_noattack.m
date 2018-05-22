close all;
clear;
clc;

load indeks
dataset = hdf5read('food_c101_n1000_r384x384x3.h5', '/images');
dataset = permute(dataset,[4 3 2 1]);
im = zeros(384,384,3);
for idx=1:size(indeks_test,2)
    for chn=1:3
        im(:,:,chn) = dataset(indeks_test(idx),:,:,chn);
    end
%     imwrite(uint8(im), strcat('Dataset/DataTesting/Cover/NoAttack/',num2str(idx),'.png'));
end