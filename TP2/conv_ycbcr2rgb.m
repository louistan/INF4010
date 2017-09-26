% conv_ycbcr2rgb: converts an 8-bit-depth YCbCr image to RGB format considering optional 4:2:0 subsampling
function [RGB] = conv_ycbcr2rgb(Y, Cb, Cr, subsample)
    assert(numel(Y)>0 && size(Y,3)==1 && numel(Cb)>0 && size(Cb,3)==1  && numel(Cr)>0 && size(Cr,3)==1);
    assert(~subsample || (size(Y,1)/2==size(Cb,1) && size(Y,1)/2==size(Cr,1) && size(Y,2)/2==size(Cb,2) && size(Y,2)/2==size(Cr,2)));
    assert(subsample || (isequal(size(Y),size(Cb)) && isequal(size(Y),size(Cr))));
    %RGB = zeros([size(Y,1) size(Y,2) 3],'uint8');
    
    YCbCr = [Y Cb Cr];
    img_s = size(YCbCr);
    
    RGB_420 = [];
    RGB_444 = [];
    
    %4:4:4
    if subsample
        RGB_444(1) = Y + 1.402*(Cr - 128);
        RGB_444(2) = Y - 0.714*(Cr - 128) - 0.344*(Cb - 128);
        RGB_444(3) = Y + 1.773*(Cb - 128);
    
        %disp(RGB_444);
        %disp(R);
        %disp(G);
        %disp(B);
    %4:2:0   
    else
        p = 1:img_s(3);
        n = 1:2:img_s(1);
        m = 1:2:img_s(2);

        z = 1;
        for k = p
            y = 1;
            for j = m
                x = 1;
                for i = n
                    RGB_420(x,y,z) = YCbCr(i,j,k);
                    x = x + 1;
                end
            y = y + 1;    
            end
        z = z + 1;
        end
        
        RGB_420(1) = Y + 1.402*(Cr - 128);
        RGB_420(2) = Y - 0.714*(Cr - 128) - 0.344*(Cb - 128);
        RGB_420(3) = Y + 1.773*(Cb - 128);
        
        %disp(RGB_420);
        %disp(R);
        %disp(G);
        %disp(B);
    end

end