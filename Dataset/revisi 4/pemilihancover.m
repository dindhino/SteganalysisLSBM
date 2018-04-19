close all;
clear;
clc;

% info = hdf5info('food_c101_n1000_r384x384x3.h5')
% info.GroupHierarchy
% info.GroupHierarchy.Datasets
% info.GroupHierarchy.Datasets.Name
dataset = hdf5read('food_c101_n1000_r384x384x3.h5', '/images');
dataset = permute(dataset,[4 3 2 1]);
% size(dataset)
im = zeros(384,384,3);
indeks = randperm(1000);
% pilih 200
for idx=1:200
    for chn=1:3
        im(:,:,chn) = dataset(indeks(idx),:,:,chn);
    end
%     imwrite(uint8(im), strcat('CoverRGB/',num2str(idx),'.jpg'));
end