clear;
clc;

load message;

for run=1:1000
    run
    path = strcat('CoverRGB/',int2str(run),'.png');
    I = imread(path);
    I(:,:,1) = LSBM(I(:,:,1), message, 100);
    I(:,:,2) = LSBM(I(:,:,2), message, 100);
    I(:,:,3) = LSBM(I(:,:,3), message, 100);
%     pathsave = 'StegoRGB/';
%     name = strcat(int2str(run),'.png');
%     imwrite(I,fullfile(pathsave,name));
end