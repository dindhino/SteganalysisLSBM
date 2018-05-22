close all;
clear;
clc;

% load dataset_payload
% load dataset_incidental
load dataset_intentional

% p_red = [];
% p_green = [];
% p_blue = [];
load pengamatan_stego

for set=1:5
    data = strcat('dataset',int2str(set));
    data = eval(data);
    for run=201:size(data,1)
    %     Pisahin gambar per channel
        It = cell2mat(data(run,1)); 
        Itred = It(:,:,1);
        Itgreen = It(:,:,2);
        Itblue = It(:,:,3);

    %     Analisis Tekstur dengan GLCM
        glcm_red = graylevel_comat(Itred);
        glcm_green = graylevel_comat(Itgreen);
        glcm_blue = graylevel_comat(Itblue);
        at_red = analisistekstur(glcm_red);
        at_green = analisistekstur(glcm_green);
        at_blue = analisistekstur(glcm_blue);

    %     HCF-COM
        Hred = CenterOfMass(HistogramCharacteristicFunction(Itred));
        Hgreen = CenterOfMass(HistogramCharacteristicFunction(Itgreen));
        Hblue = CenterOfMass(HistogramCharacteristicFunction(Itblue));
        
        p_red = [p_red; at_red Hred];
        p_green = [p_green; at_green Hgreen];
        p_blue = [p_blue; at_blue Hblue];
    end
end
% save pengamatan_cover p_red p_green p_blue
% save pengamatan_stego p_red p_green p_blue