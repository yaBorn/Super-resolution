function imgs = modcrop(imgs, modulo)
% 图像的长和宽 变为modulo的倍数
if size(imgs,3)==1 % 单通道
    sz = size(imgs);
    sz = sz - mod(sz, modulo);
    imgs = imgs(1:sz(1), 1:sz(2));
else % YCbCr
    tmpsz = size(imgs);
    sz = tmpsz(1:2);
    sz = sz - mod(sz, modulo);
    imgs = imgs(1:sz(1), 1:sz(2),:);
end

