%getAbdomen 
%得到腹部区域
%输入:  img => 已经正放好的二值化图像
%       boxWidth => 盒子宽度
%       center => 盒子中心
%输出:  abdomen => 腹部图像

function [abdomen] = getAbdomen(img, boxWidth, center) 
  scale = boxWidth ./ 126; 
  topSpace = 24; 
  bottomSpace = 0; 
  leftSpace = 18; 
  rightSpace = 18; 
  left = floor(center.x - leftSpace .* scale); 
  right = floor(center.x + rightSpace .* scale); 
  top = floor(center.y - topSpace .* scale); 
  bottom = floor(center.y + bottomSpace .* scale); 

  width = right - left + 1; 
  height = bottom - top + 1; 
  
  abdomen = uint8(zeros(height, width)); 

  for col = 1 : width 
    for row = 1 : height 
      abdomen(row, col) = img(top + row - 1, left + col - 1); 
    end 
  end 

end 
