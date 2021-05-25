% ==========================
% SRCNN 测试
%       分辨率不变，清晰化
%       将图片缩小1/N
%       用bicubic 和 SRCNN放大N倍比较
% ==========================
close all;
clear all;

%% 读取 ground truth
im  = imread('cat.jpg');

%% 参数设置
up_scale = 3; % 格式化像为us的倍数 ground truth要缩小1/n得到低分辨率图像
model = 'Model\SRCNN\9-5-5(ImageNet)\x3.mat';
% up_scale = 3;
% model = 'Model\SRCNN\9-3-5(ImageNet)\x3.mat';
% up_scale = 3;
% model = 'Model\SRCNN\9-1-5(91 images)\x3.mat';
% up_scale = 2;
% model = 'Model\SRCNN\9-5-5(ImageNet)\x2.mat'; 
% up_scale = 4;
% model = 'Model\SRCNN\9-5-5(ImageNet)\x4.mat';

%% 只计算亮度分量 Y通道
if size(im,3)>1
    im = rgb2ycbcr(im);
    im = im(:, :, 1);
end
% 变成up_scale倍像素 缩小ground truth直1/n
im_original = modcrop(im, up_scale);
im_original = single(im_original)/255; % 归一化

%% bicubic插值
im_low = imresize(im_original, 1/up_scale, 'bicubic'); % 低分辨率图像
im_highBic = imresize(im_low, up_scale, 'bicubic'); % bicubicu放大图像

%% SRCNN
im_highSrcnn = SRCNN(model, im_highBic); % SRCNN清晰化bicu
% im_highSrcnn = SRCNN(model, im_original); % SRCNN清晰化源

%% 计算 PSNR
psnr_bic = compute_psnr(im_original,im_highBic);
psnr_srcnn = compute_psnr(im_original,im_highSrcnn);

%% 显示结果
fprintf('PSNR for Bicubic Interpolation: %f dB\n', psnr_bic);
fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);

figure, imshow(im_original); title('Ground Truth');
figure, imshow(im_highBic); title('Bicubic Interpolation');
figure, imshow(im_highSrcnn); title('SRCNN Reconstruction');

%imwrite(im_b, ['Bicubic Interpolation' '.bmp']);
%imwrite(im_h, ['SRCNN Reconstruction' '.bmp']);
