% ==========================
% 缩小分辨率
% ==========================
close all;
clear all;

cata = 'image';
% cata = 'videoIm';
up_scale = 3; % 缩小1/n得到低分辨率图像

%% 获取文件名
cataF = [cata,'/'];
% File = dir(fullfile(cata,'*.jpg'));  
file = dir( fullfile( cataF)); % 文件夹下所有文件信息
fileNames = { file.name}';            % 提取文件名 转为n行1列
length_Names = size(fileNames,1);    % 文件个数

%% 低分 写入
for i = 3 : length_Names  % 前两位为 '.'和 '..'无效
    % 读文件
    im  = imread( [cataF, fileNames{i} ]);
    
    % 缩小
    im_low = imresize(im, 1/up_scale, 'bicubic'); % 低分辨率图像

    % 写文件
    fileNames{i} = strtok( fileNames{i}, '.');
    imwrite(im_low, [cata, '_low/', fileNames{i}, '_low.png']);
end

%% 显示结果
% figure, imshow(im); title('Ground Truth');
% figure, imshow(im_low); title('LR');

