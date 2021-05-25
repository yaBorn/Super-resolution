% ==========================
% SRCNN 部署 func测试
%       输入im路径 模型路径 输出路径 -> 输出重建图像
%       生成带参数的exe可执行文件
%               m脚本文件被打包exe后
%               通过python os.system方法调用
% 此代码测试 SRCNN_exe 功能
% ==========================
close all;
clear all;

%% 相对路径测试
% 测试成功
input  = 'cat.jpg';
output  = 'cat_out.jpg';
model = 'Model\SRCNN\9-1-5(ImageNet)\x3.mat';

%% 绝对路径测试
% 测试成功
root = 'G:\program\0-大创\软件\SRCNN_test';      % 此处添加绝对路径
input  = [root, '\', input];
output  = [root, '\', output];
model  = [root, '\', model];

SRCNN_exe(input, output, model)
a = '完成'