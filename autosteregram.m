depth = imread('cubic.png');
depth = int32(rgb2gray(depth));
[h, w] = size(depth);
pattern_count = 8
whitenoise_1 = abs(wgn(h, floor(w/pattern_count), 0));
whitenoise_2 = abs(wgn(h, floor(w/pattern_count), 0));
whitenoise_3 = abs(wgn(h, floor(w/pattern_count), 0));
whitenoise = cat(3, whitenoise_1, whitenoise_2,whitenoise_3);
new_im = zeros(h, w, 3);
for i = 1:h
    for j = 1:w
        offset_j = floor(j  + depth(i,j)/pattern_count);
        if j < w/pattern_count
           new_im(i, j, : ) = whitenoise(i,j, :) ;
        else    
           new_im(i,j,:)=new_im(i, j - ceil(w/pattern_count) + floor(depth(i,j) / pattern_count)+ 1,:);
           %new_im(i,j,:)=new_im(i, mod((j + floor(depth(i,j) / 8)), round(w/8)) + 1,:);
        end
    end
end
imshow(new_im)
imwrite(new_im, 'm_cubic.png')