function [inputImg] = createInputImg(referencedImgSrc) 
 
  %读入参考图像
  referencedImg = imread(referencedImgSrc); 
  %计算出参考图像的纵向像素个数和横向像素个数 
  [vertiSize, horizSize] = size(referencedImg); 

  %水平偏移像素、垂直偏移像素
  maxHorizShift = 20; 
  maxVertiShift = 200; 

  %偏移后的水平像素和垂直像素 
  horizSizeShifted = horizSize + maxHorizShift; 
  vertiSizeShifted = vertiSize + maxVertiShift; 

  %单位高度上的水平偏移量、垂直偏移量
  dHorizShiftByHeight = maxHorizShift / (vertiSize - 1); 
  dVertiShiftByWidth = maxVertiShift / (horizSize - 1); 

  %水平偏移变换矩阵
  horizShift = [1, 0, 0; dHorizShiftByHeight, 1, 0; 0, 0, 1]; 
  %垂直偏移变换矩阵
  vertiShift = [1, dVertiShiftByWidth, 0; 0, 1, 0; 0, 0, 1]; 
  %复合偏移变换矩阵
  shift = horizShift * vertiShift;  
  shiftInv = inv(shift); 

  %初始化输出图像 
  inputImg = zeros(vertiSizeShifted, horizSizeShifted); 

  %i = 0; 
  %令[x, y]是参考图像的横纵表示, [u, v]是输入图像的横纵表示
  for v = 1 : vertiSizeShifted 
    for u = 1 : horizSizeShifted 
      %计算出输入图像中点(u, v)在参考图像中的对应点(x, y) 
      res = [u, v, 1] * shiftInv; 
      x = res(1); 
      y = res(2); 
      
      %超出图像区域，continue, 不做处理
      if x < 1 || x > horizSize || y < 1 || y > vertiSize 
        continue; 
      end 
      
      %i = i + 1; 
      if x == fix(x) && y == fix(y) %如果正好是像素点对应像素点
        %直接将参考图像该点的灰度值作为输入图像像素点的灰度值
        %这样做能加快处理速度
        inputImg(v, u) = referencedImg(y, x); 
      else 
        %双线性插值法处理非"整像素点"的灰度值
        lowX = floor(x);  %该点左方最小临近点的横坐标
        lowY = floor(y);  %该点上方最小临近点的纵左边
        highX = ceil(x);  %该点右方最小临近点的横坐标
        highY = ceil(y);  %该点下方最小临近点的纵坐标
        dY = y - lowY;
        dX = x - lowX; 
        valueLow = dY .* (referencedImg(highY, lowX) - referencedImg(lowY, lowX)) + referencedImg(lowY, lowX); 
        valueHigh = dY .* (referencedImg(highY, highX) - referencedImg(lowY, highX)) + referencedImg(lowY, highX); 
        value = dX .* (valueHigh - valueLow) + valueLow; 
        inputImg(v, u) = value; 
      end 
    end 
  end 
end

