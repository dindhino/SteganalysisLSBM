function [output] = graylevel_comat(input)

%     gray level (skala 1-8)
    range = getrangefromclass(input);
    slope = 8 / (range(2)-range(1));
    intercept = 1 - (slope*(range(1)));
    input = floor(imlincomb(slope,input,intercept,'double'));
    input(input > 8) = 8;
    input(input < 1) = 1;
    
%     glcm, analisis secara horizontal
    output = zeros(8,8);
    for i=1:size(input,1)
        for j=1:size(input,2)-1
            output(input(i,j), input(i,j+1)) = output(input(i,j), input(i,j+1))+1;
        end
    end
    
%     normalisasi
    output = output/sum(sum(output));
end