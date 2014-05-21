%输入：输入图像句柄, 参考图像句柄
%输出：[输入图像选取点横坐标集合，输入图像选取点纵坐标集合，参考图像选取点横坐标集合，参考图像选取点纵坐标集合]
function [inputPointsX, inputPointsY, referencedPointsX, referencedPointsY] = getPoints(inputImg, referencedImg) 
  %提示用户用鼠标在输入图像上选取像素点
  input('Please fetch points on \"Input-Image\" using mouse, and press \"Enter\" to finish. OK?');
  figure(); set(gcf, 'Name', 'Input-Image'); imshow(inputImg); 
  [inputPointsX, inputPointsY] = ginput(); 
  close(gcf); 
  %提示用户用鼠标在参考图像上选取像素点
  input('Please fetch points on \"Referenced-Image\" using mouse, and press \"Enter\" to finish. OK?');
  figure(); set(gcf, 'Name', 'Referenced-Image'); imshow(referencedImg); 
  [referencedPointsX, referencedPointsY] = ginput(); 
  close(gcf); 
end 

