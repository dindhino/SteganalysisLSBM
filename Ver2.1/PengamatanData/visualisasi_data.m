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
X = princompal(all_data(:,1:5),3);
colors = 'rgb';
markers = 'osd';
view(3)
grid on
hold on
for k = 1:length(labeldata)
      ind = all_data(:,6)==labeldata(k); 
      scatter3(X(ind,1), X(ind,2), X(ind,3),[colors(k) markers(k)]); 
end
legend('cover','stego')
pause(1)
rotate3d on