% ==========================
% 合并视频
% ==========================
cata = 'videoIm/';
mkdir 'video'; 

%% 获取文件名
% File = dir(fullfile(cata,'*.jpg'));  
catas = dir( fullfile( cata)); % 文件夹下所有文件信息
cataNames = { catas.name}';            % 提取文件名 转为n行1列
length_catas = size(cataNames,1);    % 文件个数

%% 读取每个文件夹
for i = 3 : length_catas  % 前两位为 '.'和 '..'无效
    cata2 = [cata, cataNames{i}]; % 文件夹地址
    
    % 图像数据
    file = dir( fullfile( cata2));
    fileNames = { file.name}';            % 提取文件名 转为n行1列
    length_Names = size(fileNames,1);    % 文件个数
    
    video = VideoWriter(['video/', cataNames{i}]); % 创建视频
    open(video);
    for j = 3 : length_Names
        im  = imread( [cata2, '/', fileNames{j} ]); % 读取对应位置图像帧
        writeVideo( video, im); % 添加视频帧
    end
    close(video);
end
