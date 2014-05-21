%judgePosition 
%判断盒子是否正放 
%输入:  img => 已经水平校准的图像
%输出:  position => 正放 -- 1; 倒放 -- 0 

function [position] = judgePosition(img) 
  [rows, cols] = size(img); 
  vspace = 20; 
  for row = 1 : rows 
    if sum(img(row, :)) > 0
      topSum = sum(img(row + vspace, :));
      break; 
    end 
  end 

  for row = rows : -1 : 1 
    if sum(img(row, :)) > 0 
      bottomSum = sum(img(row - vspace, :)); 
      break;
    end 
  end 

  position = (bottomSum > topSum); 
end 

