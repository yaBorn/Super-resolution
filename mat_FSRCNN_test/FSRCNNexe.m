% ====================================
% FSRCNN 部署
%       输入im路径 模型路径 输出路径 -> 输出重建图像
%       生成带参数的exe可执行文件
%               m脚本文件被打包exe后
%               通过python os.system方法调用
% ====================================
% close all;
% clear all;
% input  = 'lenna.bmp';
% output  = 'lenna_out.bmp';
% model = 'Model\FSRCNN\FSRCNN\x3.mat';

function FSRCNNexe(input, output, model)
disp('---------------------------------------- FSRCNN.exe -----------------------------------------')
%% 读取 ground truth
disp( ['读取图像 ', input])
im  = imread(input);
disp('----完成')

%% 只计算亮度分量 Y通道
disp('计算YCbCr')
if size(im,3)>1
    im_YCbCr = rgb2ycbcr(im);
    im_Y = im_YCbCr(:, :, 1);
end
im_Y = single(im_Y)/255; % 归一化
disp('----完成')

%% SRCNN
disp('>>>>> FSRCNN重建')
im_Y_highSrcnn = FSRCNN(model, im_Y, 1); % FSRCNN清晰化图像 分辨率不变
disp('>>>>> FSRCNN重建完成')

%% 输出
disp( ['输出 ', output])
im_YCbCr(:,:,1) = im_Y_highSrcnn.*255;
im_out = ycbcr2rgb(im_YCbCr);

imwrite(im_out, output);
disp('----完成')
% disp('---------------------------------------------------------------------------------------------')
figure, imshow(im); title('输入');
figure, imshow(im_out); title('输出');
