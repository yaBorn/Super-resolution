% ====================================
% SRCNN-v 部署
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
% model = 'Model\SRCNN\9-1-5(ImageNet)\x3.mat';

function SRCNNexe(input, output, model)
disp('--------------------------------------- SRCNN-v.exe -----------------------------------------')
%% 读取视频  
disp( ['读取图像 ', input])
obj_in = VideoReader(input);
num = obj_in.NumFrames; %获取视频帧数
disp('----完成')

%% 帧处理
disp('>>>>> SRCNNv重建帧')
obj_out = VideoWriter( output);  %创建视频文件
open(obj_out);
for i = 1:num %读取第i帧
%     disp(['计算第 ',int2str(i),' / ', int2str(num),' 帧']);
    im  = read(obj_in,i);
    
    % 计算亮度分量 Y通道
%     disp('----计算YCbCr')
    if size(im,3)>1
        im_YCbCr = rgb2ycbcr(im);
        im_Y = im_YCbCr(:, :, 1);
    end
    im_Y = single(im_Y)/255; % 归一化
%     disp('----完成')
    
    % SRCNN
    im_Y_highSrcnn = SRCNN(model, im_Y, i, num); % SRCNN清晰化图像
    
    % 输出帧
    im_YCbCr(:,:,1) = im_Y_highSrcnn.*255;
    im_out = ycbcr2rgb(im_YCbCr); % 转入rgb
    
%     imshow(im_out); %显示帧
    writeVideo(obj_out,im_out);     %添加视频帧
end
disp('>>>>> SRCNNv重建完成')
close(obj_out);
clear obj_in; % 否则一直被打开
disp('---------------------------------------------------------------------------------------------')






