% ==========================
% Fast Super-Resolution Convolutional Neural Networks (FSRCNN)
% FSRCNN 测试
%       分辨率不变，清晰化
%       将图片缩小1/N
%       用bicubic 和 SRCNN放大N倍比较
% ==========================
close all;
clear all;

%% 读取 ground truth
name = 'lenna.bmp';
im  = imread(name);

%% 参数设置
up_scale = 3; % 格式化像为us的倍数 ground truth要缩小1/n得到低分辨率图像
model = 'Model\FSRCNN\FSRCNN\x3.mat';

%% 只计算亮度分量 Y通道
if size(im,3) > 1
    im_ycbcr = rgb2ycbcr(im);
    im = im_ycbcr(:, :, 1);
end
% 变成up_scale倍像素 缩小ground truth直1/n
im_original = modcrop(im, up_scale);
im_original = single(im_original)/255; % 归一化
im_low = imresize(im_original, 1/up_scale, 'bicubic'); % 低分辨率图像

%% FSRCNN
im_highFsrcnn = FSRCNN(model, im_low, up_scale);

%% bicubic插值
im_highBic = imresize(im_low, up_scale, 'bicubic'); % bicubicu放大图像

%% 计算 PSNR
psnr_bic = compute_psnr(im_original,im_highBic);
psnr_fsrcnn = compute_psnr(im_original,im_highFsrcnn);

%% 显示结果
% imwrite(im_highBic, [imname '_bic.bmp']);
% imwrite(im_fsrcnn, [imname '_FSRCNN.bmp']);

fprintf('PSNR for Bicubic: %f dB\n', psnr_bic);
fprintf('PSNR for FSRCNN: %f dB\n', im_highFsrcnn);

figure, imshow(im_original); title('Ground Truth');
figure, imshow(im_highBic); title('Bicubic Interpolation');
figure, imshow(im_highFsrcnn); title('SRCNN Reconstruction');
