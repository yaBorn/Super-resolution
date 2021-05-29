% ====================================
% FSRCNN 部署
%       输入im路径 模型路径 输出路径 -> 输出重建图像
%       生成带参数的exe可执行文件
%               m脚本文件被打包exe后
%               通过python os.system方法调用
% ====================================
close all;
clear all;
input  = 'Frame 001.png';
output  = 'Frame 001.png';
up_scale = 3; % 放大倍数 2 3 4 使用不同的训练模型 
model = ['Model\FSRCNN\FSRCNN-s\x',int2str(up_scale),'.mat'];

% function FSRCNNexe(input, output, model)
disp('---------------------------------------- FSRCNN.exe -----------------------------------------')
%% 分割model，获取model放大倍率
up_scale = strtok(model, '.mat');
up_scale = str2double( up_scale(end));
disp( ['放大分辨率_倍率：', int2str(up_scale)]);

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
im_Y_highFsrcnn = FSRCNN(model, im_Y, up_scale); % FSRCNN清晰化图像 分辨率放大up_scale
disp('>>>>> FSRCNN重建完成')

%% 输出
% CbCr 通道放大up_scale倍数
disp( ['----放大分辨率_Cb 通道 倍数:',int2str(up_scale)])
cb_bic = imresize(im_YCbCr(:,:,2), up_scale, 'bicubic'); % bicubicu放大图像
disp( ['----放大分辨率_Cr 通道 倍数:',int2str(up_scale)])
cr_bic = imresize(im_YCbCr(:,:,3), up_scale, 'bicubic');

disp( '----合并通道')
im_out(:,:,1) = uint8(im_Y_highFsrcnn.*255);
im_out(:,:,2) = cb_bic;
im_out(:,:,3) = cr_bic;
im_out = ycbcr2rgb(im_out);

disp( ['输出 ', output])
imwrite(im_out, output);
disp('----完成')
% disp('---------------------------------------------------------------------------------------------')
% figure, imshow(im); title('输入');
figure, imshow(im_out); title('输出');
