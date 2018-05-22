close all;
clear;
clc;

load all_data;
idxsteg = [16801 19200];
idxcov = [1 2400];
i = 1;
while idxsteg(2) <= size(all_data,1)
    data = [all_data(idxcov(1):idxcov(2),:); all_data(idxsteg(1):idxsteg(2),:)];
    labeldata = unique(data(:,6));
    
    % visualisasi 2D
    figure
    X = princompal(data(:,1:5),2);
    gscatter(X(:,1), X(:,2), data(:,6));
    legend('cover','stego');
    
%     % visualisasi 3D
%     figure;
%     X = princompal(data(:,1:5),3);
%     colors = 'rgb';
%     markers = 'osd';
%     view(3)
%     grid on
%     hold on
%     for k = 1:length(labeldata)
%           ind = data(:,6)==labeldata(k); 
%           scatter3(X(ind,1), X(ind,2), X(ind,3),[colors(k) markers(k)]); 
%     end
%     legend('cover','stego')
%     pause(1)
%     rotate3d on 
    
    idxsteg = idxsteg + 2400;
    i = i+1;
    if i==6 | i==11 | i==16 | i==21 | i==26 | i==31
        idxcov = idxcov + 2400;
    end
end