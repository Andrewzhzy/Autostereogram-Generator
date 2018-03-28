depth = peaks(200);
depth = padarray(depth, [0,200], 0);

[h, w] = size(depth);
pattern_count = 8;

    whitenoise_1 = abs(wgn(h, floor(w/pattern_count), 0));
    whitenoise_2 = abs(wgn(h, floor(w/pattern_count), 0));
    whitenoise_3 = abs(wgn(h, floor(w/pattern_count), 0));
    whitenoise = cat(3, whitenoise_1, whitenoise_2,whitenoise_3);
[im, map] = rgb2ind(whitenoise, 256, 'nodither');
gif_im = zeros(h, w, 1, 30);
for k = 1:30
    depth_k = cos(2*pi*k/30)*depth;
    imshow(depth_k)
    whitenoise_1 = abs(wgn(h, floor(w/pattern_count), 0));
    whitenoise_2 = abs(wgn(h, floor(w/pattern_count), 0));
    whitenoise_3 = abs(wgn(h, floor(w/pattern_count), 0));
    whitenoise = cat(3, whitenoise_1, whitenoise_2,whitenoise_3);
    new_im = zeros(h, w, 3);
    
    for i = 1:h
        for j = 1:w
            offset_j = floor(j  + depth_k(i,j)/pattern_count);
            if j < w/pattern_count
               new_im(i, j, : ) = whitenoise(i,j, :) ;
            else    
               new_im(i,j,:)=new_im(i, j - ceil(w/pattern_count) + floor(depth_k(i,j) * 20 / pattern_count)+ 1,:);
               %new_im(i,j,:)=new_im(i, mod((j + floor(depth(i,j) / 8)), round(w/8)) + 1,:);
            end
        end
    end
    gif_im(:,:,:,k) = rgb2ind(uint8(new_im*255), map, 'nodither');
end
imshow(new_im)
imwrite(gif_im,map,'peaks.gif','DelayTime',0,'LoopCount',inf)
