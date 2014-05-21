%getBinaryzationCr 
%得到原图像的二值化cr层
%输入:  originalImage => rgb图像
%输出:  binaryzationCr => 二值化cr层 
%       binaryzationValue => 二值化对应的阈值

function [binaryzationCr] = getBinaryzationCr(originalImage) 
  [ycbcr] = rgb2ycbcr(originalImage); 
  cr = ycbcr(:, :, 3); %cr层
  [binaryzationCr, binaryzationValue] = getBinaryzationImage(cr); %二值化
end 
