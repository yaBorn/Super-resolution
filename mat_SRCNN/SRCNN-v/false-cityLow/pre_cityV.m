% ==========================
% 合并视频 
% pre_video合成的city_low播放失败 0xc00d36b4 error
% 单独仍失败
% ==========================
cata = 'city_low/';

%% 获取文件名
catas = dir( fullfile( cata)); % 文件夹下所有文件信息
cataNames = { catas.name}';            % 提取文件名 转为n行1列
length_catas = size(cataNames,1);    % 文件个数

video = VideoWriter('test.avi'); % 创建视频
open(video);
%% 读取每个文件夹
for i = 3 : length_catas  % 前两位为 '.'和 '..'无效
        im  = imread( [cata, cataNames{i} ]); % 读取对应位置图像帧
        writeVideo( video, im); % 添加视频帧
end
close(video);

% TODO: 其他视频都可以 但city_low不行，未知原因