% ==========================
% FSRCNN 部署 func测试
%       输入im路径 模型路径 输出路径 -> 输出重建图像
%       生成带参数的exe可执行文件
%               m脚本文件被打包exe后
%               通过python os.system方法调用
% 此代码测试 FSRCNN_exe 功能
% mcc -m FSRCNNexe.m 生成 exe 文件
% ==========================
close all;
clear all;

%% 相对路径测试
% 测试成功
% input  = '02.jpg';
input  = 'cat.jpg';
output  = 'cat_out.jpg';
model = 'Model\FSRCNN\FSRCNN-s\x3.mat';
%% TODO 输入图片01.jpg 报错
%       错误使用 imread>get_format_info (line 542) 无法确定文件格式。
% 

%% 绝对路径测试
% % 测试成功
% root = 'G:\program\0-大创\软件\Super-resolution\FSRCNN_test';      % 此处添加绝对路径
% input  = [root, '\', input];
% output  = [root, '\', output];
% model  = [root, '\', model];

FSRCNNexe(input, output, model)
figure, imshow( imread(input) ); title('输入');
figure, imshow( imread(output)); title('FSRCNN输出');