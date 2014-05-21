%updownFlip 
%将图像上下翻转
%输入:  img => 原图像
%输出:  correctedImg => 上下翻转后的图像

function [correctedImg] = updownFlip(img) 
  [rows, cols] = size(img); 
  correctedImg = img; 
  for col = 1 : cols 
    for row = 1 : rows 
      correctedImg(row, col) = img(rows + 1 - row, col); 
    end 
  end 
end 
