% ====================================
% FSRCNN-v 部署
%       输入im路径 模型路径 输出路径 -> 输出重建图像
%       生成带参数的exe可执行文件
%               m脚本文件被打包exe后
%               通过python os.system方法调用
% ====================================
% close all;
% clear all;
% input  = 'video/walk_low.avi';
% % input  = 'video/city.avi';
% output  = 'test.avi';
% up_scale = 3; % 放大倍数 2 3 4 使用不同的训练模型 
% model = ['Model\FSRCNN\FSRCNN-s_x',int2str(up_scale),'.mat'];

function FSRCNNv(input, output, model)
disp('-------------------------------------- FSRCNN-v.exe -----------------------------------------')
%% 分割model，获取model放大倍率
up_scale = strtok(model, '.mat');
up_scale = str2double( up_scale(end));
disp( ['放大分辨率_倍率：', int2str(up_scale)]);

%% 读取视频  
disp( ['读取图像 ', input])
obj_in = VideoReader(input);
num = obj_in.NumFrames; %获取视频帧数
disp('----完成')

%% 帧处理
disp('>>>>> FSRCNNv重建帧')
obj_out = VideoWriter( output);  %创建视频文件
open(obj_out);
for i = 1:num %读取第i帧
    im  = read(obj_in,i);
    
    % 计算亮度分量 Y通道
    if size(im,3)>1
        im_YCbCr = rgb2ycbcr(im);
        im_Y = im_YCbCr(:, :, 1);
    end
    im_Y = single(im_Y)/255; % 归一化
    
    % FSRCNN
    im_Y_highFsrcnn = FSRCNN(model, im_Y, up_scale, i, num); % FSRCNN清晰化图像
    
    % 输出帧
    % CbCr 通道放大up_scale倍数
    cb_bic = imresize(im_YCbCr(:,:,2), up_scale, 'bicubic'); % bicubicu放大图像
    cr_bic = imresize(im_YCbCr(:,:,3), up_scale, 'bicubic');

    im_out(:,:,1) = uint8(im_Y_highFsrcnn.*255);
    im_out(:,:,2) = cb_bic;
    im_out(:,:,3) = cr_bic;
    im_out = ycbcr2rgb(im_out);
    
%     imshow(im_out); %显示帧
    writeVideo(obj_out,im_out);     %添加视频帧
end
disp('>>>>> FSRCNNv重建完成')
close(obj_out);
clear obj_in; % 否则一直被打开
disp('---------------------------------------------------------------------------------------------')






