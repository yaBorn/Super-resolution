function im_h = SRCNN(model, im)
% SRCNN 超分辨图像

%% 加载 CNN 模型
disp( ['----加载模型 ', model])
[high, wide] = size(im); % 图片大小
load(model); % 加载网络模型

[conv1_patchsize2, conv1_filters] = size(weights_conv1);
conv1_patchsize = sqrt(conv1_patchsize2);

[conv2_channels, conv2_patchsize2,conv2_filters] = size(weights_conv2);
conv2_patchsize = sqrt(conv2_patchsize2);

[conv3_channels, conv3_patchsize2] = size(weights_conv3);
conv3_patchsize = sqrt(conv3_patchsize2);
disp( '--------完成 ')

%% conv1 卷积层 实现数据读入
disp( '----卷积层conv1_数据录入 ')
% 卷积核 
weights_conv1 = reshape(weights_conv1, conv1_patchsize, conv1_patchsize, conv1_filters);
conv1_data = zeros(high, wide, conv1_filters);
% 卷积1
disp( '----卷积层conv1_开始卷积 ')
for i = 1 : conv1_filters
    conv1_data(:,:,i) = imfilter(im, weights_conv1(:,:,i), 'same', 'replicate');
    conv1_data(:,:,i) = max(conv1_data(:,:,i) + biases_conv1(i), 0);
end
disp( '--------完成 ')

%% conv2 卷积层 实现非线性映射
disp( '----卷积层conv2_非线性映射 ')
conv2_data = zeros(high, wide, conv2_filters);
disp( '----卷积层conv2_开始卷积 ')
for i = 1 : conv2_filters
    for j = 1 : conv2_channels
        conv2_subfilter = reshape(weights_conv2(j,:,i), conv2_patchsize, conv2_patchsize);
        conv2_data(:,:,i) = conv2_data(:,:,i) + imfilter(conv1_data(:,:,j), conv2_subfilter, 'same', 'replicate');
    end
    conv2_data(:,:,i) = max(conv2_data(:,:,i) + biases_conv2(i), 0);
end
disp( '--------完成 ')

%% conv3 卷积层 实现重建
disp( '----卷积层conv3_实现重建 ')
conv3_data = zeros(high, wide);
disp( '----卷积层conv3_开始卷积 ')
for i = 1 : conv3_channels
    conv3_subfilter = reshape(weights_conv3(i,:), conv3_patchsize, conv3_patchsize);
    conv3_data(:,:) = conv3_data(:,:) + imfilter(conv2_data(:,:,i), conv3_subfilter, 'same', 'replicate');
end
disp( '--------完成 ')

%% SRCNN 重建
disp( '----模型 重建 ')
im_h = conv3_data(:,:) + biases_conv3;
disp( '--------完成 ')