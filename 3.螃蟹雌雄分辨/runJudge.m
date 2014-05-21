%runJudge: 主函数
%输入:  img => 螃蟹图像
%输出:  gender => 雌雄('Female'/'Male')

function [gender] = runJudge(img) 
  %将rgb图像转换为灰度图像
  [img_gray] = rgb2gray(img); 
  figure; imshow(img_gray); 

  %将灰度图像用迭代法确定阈值，并将其转化为二值图像 
  [img_binaryzationGray, binaryzationValue]= getBinaryzationImage(img_gray); 
  figure; imshow(img_binaryzationGray); 

  %得到该图像的cr层
  [img_cr] = getBinaryzationCr(img); 
  figure; imshow(img_cr); 

  %计算图像该旋转多少角度能水平放置，是否应该上下翻转，以及摆正后的盒子中心和盒子宽度
  [rotateDegree, boxWidth, center, position] = rotateToHoriontal(img_cr); 
  
  %旋转图像
  [img_binaryzationGray] = imrotate(img_binaryzationGray, rotateDegree, 'bilinear', 'crop'); 

  %上下翻转图像
  if position == 0 
    [img_binaryzationGray] = updownFlip(img_binaryzationGray); 
  end 
  figure; imshow(img_binaryzationGray); 

  %得到腹部区域的图片
  [abdomen] = getAbdomen(img_binaryzationGray, boxWidth, center); 
  figure; imshow(abdomen); 

  %abdomen = medfilt2(abdomen, [3, 3]); 
  %figure; imshow(abdomen); 

  %得到腹部区域最长的一条较陡的黑线的长度
  distanceSum = getDistanceSum(abdomen); 
 
  %如果长度小于40，为雌性；否则为雄性
  if distanceSum < 40
    gender = 'Female'; 
  else 
    gender = 'Male'; 
  end 
  close all; 
end 


%getDistanceSum
%输入腹部二值图像，计算出最长的一条较陡的黑线的长度
%输入:  img => 腹部图像
%输出:  distanceSum => 最长的长度，如果大于40，则表明是雄性
function [distanceSum] = getDistanceSum(img) 
  [rows, cols] = size(img); 
  distanceSum = 0; 
  for col = 1 : cols ./ 2 
    for row = 2 : rows - 1
      if img(row, col) ~= 0 
        continue; 
      else
        tempSumV = 0;
        tempSumH = 0; 
        tempRow = row; 
        tempCol = col; 
        while(tempRow < rows && tempCol < cols .* 0.67 && (img(tempRow + 1, tempCol) == 0 || img(tempRow + 1, tempCol + 1) == 0))
          if img(tempRow + 1, tempCol) == 0 
            tempRow = tempRow + 1; 
            tempSumV = tempSumV + 1; 
          else 
            tempRow = tempRow + 1; 
            tempCol = tempCol + 1; 
            tempSumH = tempSumH + 1; 
          end 
        end 
        if tempSumH > tempSumV 
          tempSumV = 0; 
        end 
        if tempSumV > distanceSum 
          distanceSum = tempSumV; 
        end 
      end 
    end 
  end 
end 
