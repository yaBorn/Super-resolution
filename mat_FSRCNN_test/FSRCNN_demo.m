% ==========================
% Fast Super-Resolution Convolutional Neural Networks (FSRCNN)
% FSRCNN 测试
%       分辨率不变，清晰化
%       将图片缩小1/N
%       用bicubic 和 SRCNN放大N倍比较
% 
% 比SRCNN更快速 加速之前的SRCNN模型
% 重新设计SRCNN结构
%       1. 使用了一个解卷积层 从没有差值的低分辨率图像直接映射到高分辨率图像
%       2. 重新改变输入特征维数
%       3. 使用更小的卷积核与更多的映射层
% 
%
% 性能分析:
%         1. SRCNN 将低分辨率图像送进网络前，先用双三次插值法上采样操作，
%             产生与groundtruth大小一致的低分辨率图像，增加了计算复杂度，
%             因为先插值再输入网络计算，各个卷积层的计算代价会增， 从而限制速度。
%         2. 非线性映射层的计算代价太高。(第二层卷积，控制台信息发现时间多用在第二层)
% FSRCNN性能改进：
%         1. 使用了反卷积层，当没有添加到网络最前端，来对低分图像上采样。
%             相反的，将反卷积层放在网络最末端，生成最终的超分辨图像。
%         2. 反卷积理解：类比为卷积层逆过程。经过卷积层，图像的尺寸会缩小；反卷积则将图像进行放大。
%             而反卷积层和卷积层一样由很多核组成（分别是反卷积核和卷积核）。
%         3. FSRCNN将SRCNN的单映射层分解为了多个3*3固定核大小的映射层，
%             并在其前后分别添加了一个缩放层shrinking和扩张层expanding，以此将映射限制在低维空间。
% ==========================
close all;
clear all;

%% 读取 ground truth
name = 'lenna.bmp';
im  = imread(name);

%% 参数设置
up_scale = 3; % 格式化像为us的倍数 ground truth要缩小1/n得到低分辨率图像
model = 'Model\FSRCNN\FSRCNN\x3.mat';
model = 'Model\FSRCNN\FSRCNN-s\x3.mat'; % 轻量级网络模型 -实时

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
fprintf('PSNR for FSRCNN: %f dB\n', psnr_fsrcnn);

figure, imshow(im_original); title('Ground Truth');
figure, imshow(im_highBic); title('Bicubic Interpolation');
figure, imshow(im_highFsrcnn); title('FSRCNN Reconstruction');
