%输入：输入图像句柄, 参考图像句柄
%输出：dh[水平单位偏移量]、dv[垂直单位偏移量] 
function [dh, dv] = getShiftDegrees(inputImg, referencedImg) 
  [ix, iy, rx, ry] = getPoints(inputImg, referencedImg); 
  dix = ix(2) - ix(1); 
  diy = iy(2) - iy(1); 
  drx = rx(2) - rx(1); 
  dry = ry(2) - ry(1); 
  dv = (diy - dry) ./ dix; 
  dh = (dix - drx) ./ dry; 
end 
