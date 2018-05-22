close all;
clear;
clc;

dataset = {};
% Add Cover
fprintf('Cover\n');
for run=1:1000
    path = strcat('CoverRGB/',int2str(run),'.png');
    I = imread(path);
    dataset(run,1) = {I};
    dataset(run,2) = {1};
end
% Add Stego
fprintf('Stego\n');
for run=1:1000
    path = strcat('StegoRGB/',int2str(run),'.png');
    I = imread(path);
    dataset(1000+run,1) = {I};
    dataset(1000+run,2) = {0};
end