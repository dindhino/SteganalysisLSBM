close all;
clear;
clc;

load message;

% Add Cover
datacover = {};
for run=1:200
    path = strcat('CoverRGB/',int2str(run),'.jpg');
    I = imread(path);
% %     add noise (incidental attack)
%     I = imnoise(I,'salt & pepper', 0.01);

%     scaling (intentional attack)
    I = imresize(I, 0.5);
    
    datacover(run,1) = {I};
    datacover(run,2) = {0};
end

% Add Stego (payload: 15%, 25%, 50%, 75%, 100%)
dataset1 = {};
dataset2 = {};
dataset3 = {};
dataset4 = {};
dataset5 = {};
for payload=1:5
    datastego = {};
    for run=1:200
        path = strcat('CoverRGB/',int2str(run),'.jpg');
        I = imread(path);
        if payload==1
            I(:,:,1) = LSBM(I(:,:,1), message, 45);
            I(:,:,2) = LSBM(I(:,:,2), message, 0);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
        elseif payload==2
            I(:,:,1) = LSBM(I(:,:,1), message, 75);
            I(:,:,2) = LSBM(I(:,:,2), message, 0);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
        elseif payload==3
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 50);
            I(:,:,3) = LSBM(I(:,:,3), message, 0);
        elseif payload==4
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 100);
            I(:,:,3) = LSBM(I(:,:,3), message, 25);
        elseif payload==5
            I(:,:,1) = LSBM(I(:,:,1), message, 100);
            I(:,:,2) = LSBM(I(:,:,2), message, 100);
            I(:,:,3) = LSBM(I(:,:,3), message, 100);
        end
% %         add noise (incidental attack)
%         I = imnoise(I,'salt & pepper', 0.01);

%         scaling (intentional attack)
        I = imresize(I, 0.5);
        
        datastego(run,1) = {I};
        datastego(run,2) = {1};
    end
    if payload==1
        dataset1 = [datacover; datastego];
    elseif payload==2
        dataset2 = [datacover; datastego];
    elseif payload==3
        dataset3 = [datacover; datastego];
    elseif payload==4
        dataset4 = [datacover; datastego];
    elseif payload==5
        dataset5 = [datacover; datastego];
    end
end

% save dataset_payload dataset1 dataset2 dataset3 dataset4 dataset5
% save dataset_incidental dataset1 dataset2 dataset3 dataset4 dataset5
% save dataset_intentional dataset1 dataset2 dataset3 dataset4 dataset5