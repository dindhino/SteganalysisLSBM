close all;
clear;
clc;

p_red = [];
p_green = [];
p_blue = [];

for filemat=1:7
%     filemat
    if filemat==1
        load('../SaveMatDataset/dataset_pengamatan_noattack');
    elseif filemat==2
        load('../SaveMatDataset/dataset_pengamatan_incidental_saltandpepper');
    elseif filemat==3
        load('../SaveMatDataset/dataset_pengamatan_incidental_gaussian');
    elseif filemat==4
        load('../SaveMatDataset/dataset_pengamatan_incidental_poisson');
    elseif filemat==5
        load('../SaveMatDataset/dataset_pengamatan_intentional_scaling');
    elseif filemat==6
        load('../SaveMatDataset/dataset_pengamatan_intentional_rotateandcrop');
    elseif filemat==7
        load('../SaveMatDataset/dataset_pengamatan_intentional_compression');
    end
    for set=1:5
        data = strcat('dataset',int2str(set));
        data = eval(data);
        for run=(size(data,1)/2)+1:size(data,1)
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
end
% save pengamatan_stego p_red p_green p_blue