close all;
clear;
clc;

% load data
load dataset;

figure(2);
xlabel('False Positive Rate');
ylabel('True Positive Rate');
title('Receiver Operating Characteristic (ROC) Curve');

% loop n data set
for set=1:5
    % variabel
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    pred = [];
    TPR = [];
    FPR = [];
    AUC = 0;
    data = strcat('dataset',int2str(set));
    data = eval(data);
    for run=1:size(data,1)
%         fprintf('Cek data ke: %i \n', run);

    %     Step 1 : Matriks gambar per channel
        It = cell2mat(data(run,1)); 
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

    %     Step 4: HCF-COM
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
        pred = [pred; y cell2mat(data(run,2))];
        hasilprediksi = prediksi(y);

    %     Confussion Matrix
        if hasilprediksi=='stego' & cell2mat(data(run,2))==1
            TP = TP+1;
        elseif hasilprediksi=='stego' & cell2mat(data(run,2))==0
            FP = FP+1;
        elseif hasilprediksi=='cover' & cell2mat(data(run,2))==1
            FN = FN+1;
        else
            TN = TN+1;
        end
    end
    % Confussion Matrix
    if set==1
        fprintf('Payload: 15%%\n');
    elseif set==2
        fprintf('Payload: 25%%\n');
    elseif set==3
        fprintf('Payload: 50%%\n');
    elseif set==4
        fprintf('Payload: 75%%\n');
    elseif set==5
        fprintf('Payload: 100%%\n');
    end
    
    fprintf('\t\t\t\tActual Class\n');
    fprintf('Output Class\tStego\tCover\n');
    fprintf('Stego\t\t\t%i\t\t%i\n', TP,FP);
    fprintf('Cover\t\t\t%i\t\t%i\n', FN,TN);
    fprintf('\n');

    fprintf('True Positive Rate\t\t\t: %f\n', TP/(TP+FN));
    fprintf('True Negative Rate\t\t\t: %f\n', TN/(TN+FP));
    fprintf('False Positive Rate\t\t\t: %f\n', FP/(FP+TN));
    fprintf('False Negative Rate\t\t\t: %f\n', FN/(FN+TP));
    fprintf('Positive Predictive Value\t: %f\n', TP/(TP+FP));
    fprintf('Negative Predictive Value\t: %f\n', TN/(TN+FN));
    fprintf('False Discovery Rate\t\t: %f\n', FP/(FP+TP));
    fprintf('False Omission Rate\t\t\t: %f\n', FN/(FN+TN));
    
    % ROC Curve
    th_vals = sort(pred(:,1));
    for i = 1:length(th_vals)
        b_pred = (pred(:,1)>=th_vals(i));
        TP = sum(b_pred == 1 & pred(:,2) == 1);
        FP = sum(b_pred == 1 & pred(:,2) == 0);
        TN = sum(b_pred == 0 & pred(:,2) == 0);
        FN = sum(b_pred == 0 & pred(:,2) == 1);
        TPR(i) = TP/(TP+FN);
        FPR(i) = FP/(TN+FP);
    end
    hold on;
    if set==1
        plot(FPR,TPR,'r');
    elseif set==2
        plot(FPR,TPR,'g');
    elseif set==3
        plot(FPR,TPR,'b');
    elseif set==4
        plot(FPR,TPR,'m');
    elseif set==5
        plot(FPR,TPR,'k');
    end
    hold off;
    FPR = FPR(end:-1:1);
    TPR = TPR(end:-1:1);
    AUC = sum(0.5*(TPR(2:end)+TPR(1:end-1)).*(FPR(2:end)-FPR(1:end-1)));
    fprintf('Area Under the Curve\t\t: %g \n\n\n',AUC);
end
c = linspace(0,1);
hold on;
plot(c,c,'--');
hold off;
legend('Payload 15%','Payload 25%','Payload 50%','Payload 75%','Payload 100%');