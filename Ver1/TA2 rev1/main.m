close all;
clear;
clc;

% variabel
TP = 0;
TN = 0;
FP = 0;
FN = 0;

% load data
load dataset2;

% loop n data set
for run=1:size(dataset,1)
% for run=1001:2000
    fprintf('Cek data ke: %i \n', run);
    
%     Step 1 : Matriks gambar per channel
    It = cell2mat(dataset(run,1)); 
%     figure; imshow(It);
    Itred = It(:,:,1);
    Itgreen = It(:,:,2);
    Itblue = It(:,:,3);
    
%     Step 2: Analisis Tekstur dengan GLCM
    glcm_red = graylevel_comat(Itred);
    glcm_green = graylevel_comat(Itgreen);
    glcm_blue = graylevel_comat(Itblue);
    at_red = analisistekstur(glcm_red);
    at_green = analisistekstur(glcm_green);
    at_blue = analisistekstur(glcm_blue);
    
%     Step 3: Edge Detection dengan Operator Sobel
    sobel_red = sobel(Itred);
    sobel_green = sobel(Itgreen);
    sobel_blue = sobel(Itblue);
    
%     figure; imshow(sobel_red);
%     figure; imshow(sobel_green);
%     figure; imshow(sobel_blue);
    
%     Step 4: DHCF-COM
    Hred = CenterOfMass(HistogramCharacteristicFunction(sobel_red));
    Hgreen = CenterOfMass(HistogramCharacteristicFunction(sobel_green));
    Hblue = CenterOfMass(HistogramCharacteristicFunction(sobel_blue));
    
%     Step 5 : Membership Function (Feature Exraction)
    set_red = [at_red Hred];
    set_green = [at_green Hgreen];
    set_blue = [at_blue Hblue];
    set_channel = [gabunginfitur(set_red) gabunginfitur(set_green) gabunginfitur(set_blue)];
    
%     Step 6 : Membership Function (Channel)
    out_red = mf_red(set_channel(1));
    out_green = mf_green(set_channel(2));
    out_blue = mf_blue(set_channel(3));
    out_all = [out_red out_green out_blue];
    out_value = out_all(:,[1 3 5]);
    out_nilai = out_all(:,[2 4 6]);
%     rule channel
    value = [rule_cn(cell2mat(out_value(1,:))); rule_cn(cell2mat(out_value(2,:)))];
    nilai = min(cell2mat(out_nilai),[],2);
%     model sugeno
    y = 0;
    for i=1:2
        if strcmp(value(i,:),'cover')
            y = y + (nilai(i)*25);
        else
            y = y + (nilai(i)*75);
        end
    end
    y = y/sum(nilai);
    hasilprediksi = prediksi(y);
    
%     Confussion Matrix
    if hasilprediksi=='cover' & cell2mat(dataset(run,2))==1
        TP = TP+1;
    elseif hasilprediksi=='cover' & cell2mat(dataset(run,2))==0
        FP = FP+1;
    elseif hasilprediksi=='stego' & cell2mat(dataset(run,2))==1
        FN = FN+1;
    else
        TN = TN+1;
    end
end

% Hitung Akurasi
akurasi = (TP+TN)/(TP+TN+FP+FN);
precision = TP/(TP+FP);
recall = TP/(TP+FN);
f1score = (2*precision*recall)/(precision+recall);

fprintf('\n\n');
% fprintf('True Positive\t: %i\n', TP);
% fprintf('True Negative\t: %i\n', TN);
% fprintf('False Positive\t: %i\n', FP);
% fprintf('False Negative\t: %i\n', FN);
fprintf('\t\t\t\tActual Class\n');
fprintf('Output Class\tCover\tStego\n');
fprintf('Cover\t\t\t%i\t\t%i\n', TP,FP);
fprintf('Stego\t\t\t%i\t\t%i\n', FN,TN);
fprintf('\n\n');
fprintf('Akurasi\t\t\t: %f%%\n', akurasi*100);
fprintf('Precision\t\t: %f%%\n', precision*100);
fprintf('Recall\t\t\t: %f%%\n', recall*100);
fprintf('F1 Score\t\t: %f%%\n', f1score*100);