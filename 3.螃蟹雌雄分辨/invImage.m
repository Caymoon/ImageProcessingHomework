%invImage
%翻转图像颜色, 0变成255，255变成0
%输入:  originalImg => 原二值图像
%输出:  img => 翻转后的图像

function [img] = invImage(originalImg) 
  img = originalImg; 
  [rows, cols] = size(originalImg); 
  for col = 1 : cols 
    for row = 1 : rows 
      img(row, col) = (originalImg(row, col) == 0) .* 255 + (originalImg(row, col) == 255) .* 0; 
      %if img(row, col) == 0 
        %img(row, col) = 255; 
      %else
        %img(row, col) = 0; 
      %end 
    end 
  end 
end 
