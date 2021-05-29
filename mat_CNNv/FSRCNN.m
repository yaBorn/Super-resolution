function im_h = FSRCNN(model, im, up_scale, id, num)
% FSRCNN 超分辨图像

%% 加载 CNN 模型
load(model); % 加载网络模型
[high,wide] = size(im); % 图片大小

outhei = high * up_scale;
outwid = wide * up_scale;

layer_num = length(weights_conv);
conv_data = cell(layer_num,1);

%% conv1 卷积层 实现数据读入
weight = weights_conv{1};
biases_conv1 = biases_conv{1};
[channel, filtersize, filters] = size(weight);
patchsize = sqrt(filtersize);
% 卷积核
weight = reshape(weight, patchsize, patchsize, filters);
data_tmp = zeros(high, wide, filters);
% 卷积
for i = 1 : filters 
    data_tmp(:,:,i) = imfilter(im, weight(:,:,i), 'same','replicate');
    data_tmp(:,:,i) = max(data_tmp(:,:,i) + biases_conv1(i), 0) + prelu_conv{1} * min(data_tmp(:,:,i) + biases_conv1(i),0);
end
conv_data{1} = data_tmp;

%% conv2+ 多层3*3核卷积
for idx = 2 : layer_num-1
    weight = weights_conv{idx};
    bias = biases_conv{idx};
    [channel, filtersize, filters] = size(weight);
    patchsize = sqrt(filtersize);
    data_tmp = zeros(high, wide, filters);
    data_pre = conv_data{idx-1};
    for i = 1 : filters
        for j = 1 : channel
            subfilter = reshape(weight(j,:,i), patchsize, patchsize);
            data_tmp(:,:,i) = data_tmp(:,:,i) + imfilter(data_pre(:,:,j), subfilter, 'same', 'replicate');
        end
        data_tmp(:,:,i) = max(data_tmp(:,:,i) + bias(i),0) + prelu_conv{idx} * min(data_tmp(:,:,i) + bias(i),0);
    end
    conv_data{idx} = data_tmp;
end

%% conv3
weight = weights_conv{layer_num};
bias = biases_conv{layer_num};
[filters, filtersize,channel] = size(weight);
temp = zeros(channel,filtersize);
for i = 1 : channel
        temp(i,:) = weight(1,:,i);
end
weight = temp;
[channel, filtersize, filters] = size(weight);
patchsize = sqrt(filtersize);

conv3_data = zeros(outhei,outwid);
conv2_data = conv_data{layer_num-1};
for j = 1 : channel
    disp( ['--------进度：第 ',int2str(id),' / ', int2str(num),' 帧', int2str(j*100/channel),'%'])
    subfilter = reshape(weight(j,:), patchsize, patchsize);
    conv3_data(:,:)=conv3_data(:,:) + deconv(conv2_data(:,:,j), subfilter, up_scale);
end

%% FSRCNN 重建
im_h = conv3_data(:,:) + bias(1);

