function main() 
  %读入参考图像
  referencedImg = imread('sample.tif'); 
  %生成输入图像
  inputImg = createInputImg('sample.tif'); 
  %将出入图像存到文件
  imwrite(inputImg, 'inputImg.png'); 
  %计算出水平单位偏移量和垂直单位偏移量
  [dh, dv] = getShiftDegrees(inputImg, referencedImg); 
  %打印出原始的水平偏移量和垂直偏移量
  res = sprintf('\nHoriztal Shift Size: %d dp\nVertical Shift Size: %d dp\n', dh * 688, dv * 688)
end 
