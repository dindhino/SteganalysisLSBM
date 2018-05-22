close all;
clear;
clc;

for filemat=1:7
    figure;
    xlabel('False Positive Rate');
    ylabel('True Positive Rate');
    
    if filemat==1
        load('SaveMatDataset/dataset_testing_noattack');
        title('ROC Curve - No Attack');
        fprintf('---------- No Attack ----------\n');
    elseif filemat==2
        load('SaveMatDataset/dataset_testing_incidental_saltandpepper');
        title('ROC Curve - Incidental Attack - Noise Salt & Pepper');
        fprintf('---------- Noise Salt & Pepper ----------\n');
    elseif filemat==3
        load('SaveMatDataset/dataset_testing_incidental_gaussian');
        title('ROC Curve - Incidental Attack - Gaussian');
        fprintf('---------- Noise Gaussian ----------\n');
    elseif filemat==4
        load('SaveMatDataset/dataset_testing_incidental_poisson');
        title('ROC Curve - Incidental Attack - Poisson');
        fprintf('---------- Noise Poisson ----------\n');
    elseif filemat==5
        load('SaveMatDataset/dataset_testing_intentional_scaling');
        title('ROC Curve - Intentional Attack - Scaling');
        fprintf('---------- Scaling ----------\n');
    elseif filemat==6
        load('SaveMatDataset/dataset_testing_intentional_rotateandcrop');
        title('ROC Curve - Intentional Attack - Rotate & Crop');
        fprintf('---------- Rotate & Crop ----------\n');
    elseif filemat==7
        load('SaveMatDataset/dataset_testing_intentional_compression');
        title('ROC Curve - Intentional Attack - Compression');
        fprintf('---------- Compression ----------\n');
    end

    % loop n data set
    for set=1:5
        % variabel
        pred = [];
        TP = 0;
        TN = 0;
        FP = 0;
        FN = 0;
        data = strcat('dataset',int2str(set));
        data = eval(data);
        for run=1:size(data,1)
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
            Hred = hcfcom(Itred);
            Hgreen = hcfcom(Itgreen);
            Hblue = hcfcom(Itblue);

        %     Membership Function (Feature Extraction)
            set_red = [at_red Hred];
            set_green = [at_green Hgreen];
            set_blue = [at_blue Hblue];
            set_channel = [gabunginfitur(set_red) gabunginfitur(set_green) gabunginfitur(set_blue)];

        %     Membership Function (Channel)
            out_red = mf_channel(set_channel(1));
            out_green = mf_channel(set_channel(2));
            out_blue = mf_channel(set_channel(3));
            out_all = [out_red out_green out_blue];
            out_value = out_all(:,[1 3 5]);
            out_nilai = out_all(:,[2 4 6]);
        %     kemungkinan rule
            rule_in_value = [];
            rule_in_nilai = [];
            for r=1:2
                for g=1:2
                    for b=1:2
                        rule_in_value = [rule_in_value; out_value(r,1) out_value(g,2) out_value(b,3)];
                        rule_in_nilai = [rule_in_nilai; out_nilai(r,1) out_nilai(g,2) out_nilai(b,3)];
                    end
                end
            end
        %     rule channel
        %     conjuction (and), untuk tiap channel
            rule_out_value = [];
            for i=1:size(rule_in_value,1)
                rule_out_value = [rule_out_value; rule_cn(cell2mat(rule_in_value(i,:)))];
            end
            rule_out_nilai = min(cell2mat(rule_in_nilai),[],2);
        %     disjunction (or), untuk tiap output dari rule
            value = ['stego'; 'cover'];
            maxstego = 0; maxcover = 0;
            for i=1:size(rule_out_value,1)
                if strcmp(rule_out_value(i,:), value(1,:))
                    if rule_out_nilai(i,1) > maxstego
                        maxstego = rule_out_nilai(i,1);
                    end
                end
                if strcmp(rule_out_value(i,:), value(2,:))
                    if rule_out_nilai(i,1) > maxcover
                        maxcover = rule_out_nilai(i,1);
                    end
                end
            end
            nilai = [maxstego; maxcover];
        %     model sugeno
            y = 0;
            for i=1:2
                if strcmp(value(i,:),'cover')
                    y = y + (nilai(i)*0);
                else
                    y = y + (nilai(i)*1);
                end
            end
            y = y/sum(nilai);
            pred = [pred; y cell2mat(data(run,2))];
        end

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

        % ROC Curve
        [FPR,TPR,T,AUC] = perfcurve(pred(:,2),pred(:,1),1);
        fprintf('Area Under the Curve\t: %f\n', AUC);
        th = 0.7;
        b_pred = (pred(:,1)>=th);
        TP = sum(b_pred == 1 & pred(:,2) == 1);
        FP = sum(b_pred == 1 & pred(:,2) == 0);
        TN = sum(b_pred == 0 & pred(:,2) == 0);
        FN = sum(b_pred == 0 & pred(:,2) == 1);
        fprintf('Threshold\t\t\t\t: %f\n', th);

        % Confussion Matrix     
        fprintf('\t\t\t\tActual Class\n');
        fprintf('Output Class\tStego\tCover\n');
        fprintf('Stego\t\t\t%i\t\t%i\n', TP,FP);
        fprintf('Cover\t\t\t%i\t\t%i\n', FN,TN);
        fprintf('\n');
        fprintf('Accuracy\t\t\t\t\t: %f%%\n', 100*(TP+TN)/(TP+TN+FP+FN));
        fprintf('True Positive Rate\t\t\t: %f%%\n', 100*TP/(TP+FN));
        fprintf('True Negative Rate\t\t\t: %f%%\n', 100*TN/(TN+FP));
        fprintf('False Positive Rate\t\t\t: %f%%\n', 100*FP/(FP+TN));
        fprintf('False Negative Rate\t\t\t: %f%%\n', 100*FN/(FN+TP));
        fprintf('Positive Predictive Value\t: %f%%\n', 100*TP/(TP+FP));
        fprintf('Negative Predictive Value\t: %f%%\n', 100*TN/(TN+FN));
        fprintf('False Discovery Rate\t\t: %f%%\n', 100*FP/(FP+TP));
        fprintf('False Omission Rate\t\t\t: %f%%\n\n\n', 100*FN/(FN+TN));

        hold on;
        if set==1
            plot(FPR,TPR,'k','LineWidth',2);
        elseif set==2
            plot(FPR,TPR,'m','LineWidth',2);
        elseif set==3
            plot(FPR,TPR,'b','LineWidth',2);
        elseif set==4
            plot(FPR,TPR,'g','LineWidth',2);
        elseif set==5
            plot(FPR,TPR,'r','LineWidth',2);
        end
        hold off;

    end
    c = linspace(0,1);
    hold on;
    plot(c,c,'--');
    hold off;
    legend('Payload 15%','Payload 25%','Payload 50%','Payload 75%','Payload 100%');
end