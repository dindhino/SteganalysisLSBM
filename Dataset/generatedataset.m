close all;
clear;
clc;

load indeks;
load message;

% Add Cover
datacover = {};
for run=1:size(icover,2)
    path = strcat('CoverRGB/',int2str(icover(run)),'.png');
    I = imread(path);
    datacover(run,1) = {I};
    datacover(run,2) = {0};
end

% Add Stego (15%, 25%, 50%, 75%, 100%)
dataset1 = {};
dataset2 = {};
dataset3 = {};
dataset4 = {};
dataset5 = {};
for kps=1:5
    datastego = {};
    for run=1:size(istego,2)
        path = strcat('CoverRGB/',int2str(istego(run)),'.png');
        I = imread(path);
        if kps==1
            I(:,:,1) = LSBM(I(:,:,1), message, 45);
            I(:,:,2) = LSBM(I(:,:,2), message, 0);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
        elseif kps==2
            I(:,:,1) = LSBM(I(:,:,1), message, 75);
            I(:,:,2) = LSBM(I(:,:,2), message, 0);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
        elseif kps==3
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 50);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
        elseif kps==4
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 100);
            I(:,:,3) = LSBM(I(:,:,3), message, 25);
        elseif kps==5
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 100);
            I(:,:,3) = LSBM(I(:,:,3), message, 100);
        end
        datastego(run,1) = {I};
        datastego(run,2) = {1};
    end
    if kps==1
        dataset1 = [datacover; datastego];
    elseif kps==2
        dataset2 = [datacover; datastego];
    elseif kps==3
        dataset3 = [datacover; datastego];
    elseif kps==4
        dataset4 = [datacover; datastego];
    elseif kps==5
        dataset5 = [datacover; datastego];
    end
end

% save dataset dataset1 dataset2 dataset3 dataset4 dataset5