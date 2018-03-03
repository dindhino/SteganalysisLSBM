function [D] = DiffMatr(im)
    [baris kolom] = size(im);
    D = zeros(baris, kolom);
    x = 1;
    y = 1;
    for i=1:baris
        for j=1:kolom
            if (i+x > baris) | (j+y > kolom)
                D(i,j) = im(i,j);
            else
                D(i,j) = im(i,j) - im(i+x,j+y);
            end
        end
    end
%     D = uint8(D);
end

