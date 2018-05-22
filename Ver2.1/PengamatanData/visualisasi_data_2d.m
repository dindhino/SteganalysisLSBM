close all;
clear;
clc;

load pengamatan_stego
load pengamatan_cover

all_cover = [cover_red; cover_green; cover_blue];
all_stego = [stego_red; stego_green; stego_blue];
all_data = [all_cover zeros(size(all_cover,1),1); all_stego ones(size(all_stego,1),1)];
figure;
labeldata = unique(all_data(:,6));
X = princompal(all_data(:,1:5),2);
gscatter(X(:,1), X(:,2), all_data(:,6));
legend('cover','stego');