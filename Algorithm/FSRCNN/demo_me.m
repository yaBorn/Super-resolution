% =========================================================================
% Test code for Fast Super-Resolution Convolutional Neural Networks (FSRCNN)
%
% Reference
%   Chao Dong, Chen Change Loy, Xiaoou Tang. Accelerating the Super-Resolution Convolutional Neural Networks, 
%   in Proceedings of European Conference on Computer Vision (ECCV), 2016
%
% Chao Dong
% SenseTime Group
% For any question, send email to chaodong@sensetime.com
% =========================================================================
close all;
clear all;

%% set parameters
testfolder = 'test\Set5\';
up_scale = 3;
model = 'model\FSRCNN\x3.mat';

filepaths = dir(fullfile(testfolder,'*.bmp'));
psnr_bic = zeros(length(filepaths),1);
psnr_fsrcnn = zeros(length(filepaths),1);

for i = 1 : length(filepaths)
   
    % read ground truth image
    [add,imname,type] = fileparts(filepaths(i).name);
    im = imread([testfolder imname type]);

    % work on illuminance only
    if size(im,3) > 1
        im_ycbcr = rgb2ycbcr(im);
        im = im_ycbcr(:, :, 1);
    end
    im_gnd = modcrop(im, up_scale);
    im_gnd = single(im_gnd)/255;
    im_l = imresize(im_gnd, 1/up_scale, 'bicubic');

    % FSRCNN
    im_h = FSRCNN(model, im_l, up_scale);

    % bicubic interpolation
    im_b = imresize(im_l, up_scale, 'bicubic');

    % remove border
    if up_scale==3
        im_h = shave_x3(uint8(im_h * 255), [up_scale, up_scale]);
    else 
        im_h = shave(uint8(im_h * 255), [up_scale, up_scale]);
    end
    im_gnd = shave(uint8(im_gnd * 255), [up_scale, up_scale]);
    im_b = shave(uint8(im_b * 255), [up_scale, up_scale]);

    % compute PSNR
    psnr_bic(i) = compute_psnr(im_gnd,im_b);
    psnr_fsrcnn(i) = compute_psnr(im_gnd,im_h);

    % save results
    imwrite(im_b, [imname '_bic.bmp']);
    imwrite(im_h, [imname '_FSRCNN.bmp']);

end

fprintf('Mean PSNR for Bicubic: %f dB\n', mean(psnr_bic));
fprintf('Mean PSNR for FSRCNN: %f dB\n', mean(psnr_fsrcnn));
