%rotateToHoriontal 
%输入图像该旋转多少角度能水平放置，是否应该上下翻转，以及摆正后的盒子中心和盒子宽度
%输入:  img => 输入图像
%输出:  rotateDegree => 应该旋转的角度
%       boxWidth => 盒子的宽度
%       center => 盒子的中心点
%       position => 盒子是否正放(正放 -- 1; 倒放 -- 0)

function [rotateDegree, boxWidth, center, position] = rotateToHoriontal(img) 
  rotateDegree = 0; 
  %翻转图像颜色[0->255; 255->0]
  img = invImage(img); 
  figure: imshow(img); 
  
  [rows, cols] = size(img); 

  [left, right] = getLAndR(img); 
  %当左右端点的高度有明显差异的时候，则绕图像中心旋转
  while(abs(left.y - right.y) > 1) 
    %获取旋转的角度
    theta = atan((right.y - left.y) ./ (right.x - left.x)) .* 180 ./ pi; 
    %旋转
    img = imrotate(img, theta, 'bilinear', 'crop'); 
    %累加总共旋转的角度
    rotateDegree = rotateDegree + theta; 
    figure; imshow(img); 
    [left, right] = getLAndR(img); 
  end 

  %得到盒子的宽度和盒子中心的坐标
  boxWidth = abs(right.x - left.x); 
  center.x = floor((left.x + right.x) ./ 2); 
  center.y = floor((left.y + right.y) ./ 2); 

  %判断盒子是否正放并且调整
  position = judgePosition(img); 
  if position == 0 
    [correctImg] = updownFlip(img); 
    figure; imshow(correctImg); 
    center.x = cols + 1 - center.x; 
    center.y = rows + 1 - center.y; 
  end 
end 


%getLAndR
%得到盒子左右两个端点的坐标
%输入:  img => 输入图像 
%输出:  left => 左端点 => 结构体[left.x left.y] 
%       right => 右端点
function [left, right] = getLAndR(img) 
  [rows, cols] = size(img); 
  
  left.x = 0; 
  left.y = 0; 
  right.x = 0; 
  right.y = 0; 
  
  %寻找左端点
  isFound = 0; 
  for col = 1 : cols 
    if isFound 
      break; 
    end 
    for row = 1 : rows 
      if img(row, col) == 255 
        left.x = col; 
        left.y = row; 
        isFound = 1; 
        break; 
      end 
    end 
  end 

  %寻找右端点
  isFound = 0; 
  for col = cols: -1 : 1 
    if isFound 
      break; 
    end 
    for row = rows : -1 : 1 
      if img(row, col) == 255 
        right.x = col; 
        right.y = row; 
        isFound = 1; 
        break; 
      end 
    end 
  end 

end 
