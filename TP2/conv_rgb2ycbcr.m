% conv_rgb2ycbcr: converts an 8-bit-depth RGB image to Y'CbCr format using optional 4:2:0 subsampling
function [Y, Cb, Cr] = conv_rgb2ycbcr(RGB, subsample)
    assert(numel(RGB)>0 && size(RGB,3)==3);
    %Y = zeros(size(RGB,1),size(RGB,2),'uint8');
   
    img_s = size(RGB);
    
    YCbCr = zeros(3);
    
    R = RGB(:,:,1);
    G = RGB(:,:,2);
    B = RGB(:,:,3);
    
    %4:4:2
    if subsample
        p = 1:img_s(3);
        n = 1:img_s(1);
        m = 1:img_s(2);
    %4:4:4  
    else
        p = 1:img_s(3);
        n = 1:2:img_s(1);
        m = 1:2:img_s(2);
    end
    
    z = 1;
    for k = p
        y = 1;
        for j = m
            x = 1;
            for i = n
                YCbCr(x,y,z) = RGB(i,j,k);
                x = x + 1;
            end
        y = y + 1;    
        end
    z = z + 1;
    end
    Y = 0.299*R + 0.587*G + 0.114*B;
    Cb = 128 + 0.564*(B - Y);
    Cr = 128 + 0.713*(R - Y);

    %disp(YCbCr);
    
    compr_rate = 1.0 - (numel(YCbCr)./(numel(RGB)));
    fprintf('\t... compression rate = %f\n',compr_rate);
    
end