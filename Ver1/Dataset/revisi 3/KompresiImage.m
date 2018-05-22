function [img_out] = KompresiImage(img_in)
    dct_matrix = dctmtx(8);
    mask = [1   1   1   1   0   0   0   0
            1   1   1   0   0   0   0   0
            1   1   0   0   0   0   0   0
            1   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0
            0   0   0   0   0   0   0   0];
        
    for channel=1:3
        img_ori = img_in(:,:,channel);
        img_ori = im2double(img_ori);
        blok_dct = blkproc(img_ori,[8 8],'P1*x*P2',dct_matrix,dct_matrix');
        blok_mask = blkproc(blok_dct,[8 8],'P1.*x',mask);
        img_kompres = blkproc(blok_mask,[8 8],'P1*x*P2',dct_matrix',dct_matrix);
        img_out(:,:,channel)=img_kompres;
    end
end

