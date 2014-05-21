%getBinaryzationImage 
%运用迭代法得到图像的二值化图像
%输入:  img => 原图像
%输出:  binaryzationImage => 阈值分割后的二值化的图像
%       binaryzationValue => 分割阈值

function [binaryzationImage, binaryzationValue] = getBinaryzationImage(img) 
  [rows, cols] = size(img); 
  binaryzationValue = 255 / 2; 
  last = 0; 

  %迭代求阈值
  while(abs(binaryzationValue - last) > 0.1) 
    last = binaryzationValue; 
    sum1 = 0; 
    n = 0; 
    sum2 = 0; 
    m = 0; 

    for col = 1 : cols 
      for row = 1 : rows 
        if img(row, col) < binaryzationValue 
          sum1 = sum1 + double(img(row, col));
          n = n + 1; 
        else 
          sum2 = sum2 + double(img(row, col));
          m = m + 1; 
        end 
      end 
    end 

    binaryzationValue = (sum1 / n + sum2 / m) / 2;
  end 

  %阈值分割
  binaryzationImage = img; 
  for col = 1 : cols  
    for row = 1 : rows  
      if img(row, col) < binaryzationValue
        binaryzationImage(row, col) = 0; 
      else 
        binaryzationImage(row, col) = 255; 
      end 
    end 
  end 

