close all;
clear;
clc;

% Add Cover
datacover = {};
for run=1:800
    path = strcat('../PembangunanDataset/Dataset/DataPengamatan/Cover/IncidentalAttack/Noise_Poisson/',int2str(run),'.png');
    I = imread(path);    
    datacover(run,1) = {I};
    datacover(run,2) = {0};
end

% Add Stego
dataset1 = {}; % Payload: 15%
dataset2 = {}; % Payload: 25%
dataset3 = {}; % Payload: 50%
dataset4 = {}; % Payload: 75%
dataset5 = {}; % Payload: 100%
for payload=1:5
    datastego = {};
    for run=1:800
        if payload==1
            path = strcat('../PembangunanDataset/Dataset/DataPengamatan/Stego/IncidentalAttack/Noise_Poisson/Payload15%/',int2str(run),'.png');
            I = imread(path);
        elseif payload==2
            path = strcat('../PembangunanDataset/Dataset/DataPengamatan/Stego/IncidentalAttack/Noise_Poisson/Payload25%/',int2str(run),'.png');
            I = imread(path);
        elseif payload==3
            path = strcat('../PembangunanDataset/Dataset/DataPengamatan/Stego/IncidentalAttack/Noise_Poisson/Payload50%/',int2str(run),'.png');
            I = imread(path);
        elseif payload==4
            path = strcat('../PembangunanDataset/Dataset/DataPengamatan/Stego/IncidentalAttack/Noise_Poisson/Payload75%/',int2str(run),'.png');
            I = imread(path);
        elseif payload==5
            path = strcat('../PembangunanDataset/Dataset/DataPengamatan/Stego/IncidentalAttack/Noise_Poisson/Payload100%/',int2str(run),'.png');
            I = imread(path);
        end     
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
% save dataset_pengamatan_incidental_poisson dataset1 dataset2 dataset3 dataset4 dataset5