% decoup: reformats a 2D image (i.e. always single channel) to a block array
function [blocks] = decoup(img,block_size)
    if ~exist('block_size','var')
        block_size = 8;
    end
    %error
    assert(numel(img)>0 && mod(size(img,1),block_size)==0 && mod(size(img,2),block_size)==0);
    
    blocks = zeros(2);
    line = zeros(1);
    bloc = zeros(2);
    
    n = 0;
    m = 0;
    
    img_s = size(img);
    
    for i = 1:img_s(1)*img_s(2)/power(block_size,2)
        for j = 1+m:block_size+m
            for k = 1+n:block_size+n
                line(k) = img((k-1)*img_s(1)+1);
            end
            bloc(:,j) = line;
        end
        n = n+5;
        if n > img_s(2)
            n = 0;
            m = m+4;
        end
    end

end