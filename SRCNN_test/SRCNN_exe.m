% ====================================
% SRCNN 部署
%       输入im路径 模型路径 输出路径 -> 输出重建图像
%       生成带参数的exe可执行文件
%               m脚本文件被打包exe后
%               通过python os.system方法调用
% ====================================
% close all;
% clear all;
% input  = 'cat.jpg';
% output  = 'cat_out.jpg';
% model = 'Model\SRCNN\9-1-5(ImageNet)\x3.mat';

function SRCNN_exe(input, output, model)
%% 读取 ground truth
im  = imread(input);

%% 只计算亮度分量 Y通道
if size(im,3)>1
    im_YCbCr = rgb2ycbcr(im);
    im_Y = im_YCbCr(:, :, 1);
end
im_Y = single(im_Y)/255; % 归一化

%% SRCNN
im_Y_highSrcnn = SRCNN(model, im_Y); % SRCNN清晰化图像

%% 输出
im_YCbCr(:,:,1) = im_Y_highSrcnn.*255;
im_out = ycbcr2rgb(im_YCbCr);

imwrite(im_out, output);
% figure, imshow(im); title('输入');
% figure, imshow(im_out); title('输出');
