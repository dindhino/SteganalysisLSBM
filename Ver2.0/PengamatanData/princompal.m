function [output] = princompal(input, dimensi)
    output = input;
    input = input - repmat(mean(input), [size(input,1) 1]);
    Cx = cov(input);
    Cx(isnan(Cx)) = 0;
    Cx(isinf(Cx)) = 0;
    [eigvector eigvalue] = eig(Cx);
    [eigvalue indeks] = sort(diag(eigvalue), 'descend');
    eigvector = eigvector(:,indeks);
    output = output*eigvector;
    output = output(:,1:dimensi);
end