function COM = CenterOfMass(matrix)
    [baris kolom] = size(matrix);
    ij = ones(baris,1)*[1:kolom] + (ones(kolom,1)*[1:baris])' - 2;
    COM = sum(sum(ij.*matrix)) / double(sum(sum(matrix)));
%     fprintf('\t Center Of Mass :');
%     disp(COM);
end