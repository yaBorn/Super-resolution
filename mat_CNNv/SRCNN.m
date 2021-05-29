function im_h = SRCNN(model, im, id, num)
% SRCNN 超分辨图像
% 第id帧 共num帧
%% 加载 CNN 模型
[high, wide] = size(im); % 图片大小
load(model); % 加载网络模型

%% conv1 卷积层 实现数据读入
% 卷积核 
[conv1_patchsize2, conv1_filters] = size(weights_conv1);
conv1_patchsize = sqrt(conv1_patchsize2);
weights_conv1 = reshape(weights_conv1, conv1_patchsize, conv1_patchsize, conv1_filters);
conv1_data = zeros(high, wide, conv1_filters);
% 卷积1
for i = 1 : conv1_filters
    conv1_data(:,:,i) = imfilter(im, weights_conv1(:,:,i), 'same', 'replicate');
    conv1_data(:,:,i) = max(conv1_data(:,:,i) + biases_conv1(i), 0);
end

%% conv2 卷积层 实现非线性映射
[conv2_channels, conv2_patchsize2,conv2_filters] = size(weights_conv2);
conv2_patchsize = sqrt(conv2_patchsize2);
conv2_data = zeros(high, wide, conv2_filters);
% disp([int2str(conv2_filters),'  ',int2str(conv2_channels)])
% alltime = conv2_filters*conv2_channels; % 总进度
for i = 1 : conv2_filters
    disp( ['--------进度：第 ', int2str(id), ' / ', int2str(num),' 帧 ', int2str( i*100/conv2_filters),'%'])
    for j = 1 : conv2_channels
%         disp( ['--------映射进度：', int2str( (j+ (i*conv2_channels))*100/alltime),'%'])
        conv2_subfilter = reshape(weights_conv2(j,:,i), conv2_patchsize, conv2_patchsize);
        conv2_data(:,:,i) = conv2_data(:,:,i) + imfilter(conv1_data(:,:,j), conv2_subfilter, 'same', 'replicate');
    end
    conv2_data(:,:,i) = max(conv2_data(:,:,i) + biases_conv2(i), 0);
end

%% conv3 卷积层 实现重建
[conv3_channels, conv3_patchsize2] = size(weights_conv3);
conv3_patchsize = sqrt(conv3_patchsize2);
conv3_data = zeros(high, wide);
for i = 1 : conv3_channels
    conv3_subfilter = reshape(weights_conv3(i,:), conv3_patchsize, conv3_patchsize);
    conv3_data(:,:) = conv3_data(:,:) + imfilter(conv2_data(:,:,i), conv3_subfilter, 'same', 'replicate');
end

%% SRCNN 重建
im_h = conv3_data(:,:) + biases_conv3;
