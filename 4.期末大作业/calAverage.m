%calAverage: 
%根据总权重计算方格区域中心的加权平均值
%输入：square => 需要计算的方格矩阵; totalWeight => 总权重
%输出：方格区域中心的加权平均值
function [value] = calAverage(square, totalWeight) 
  [rows, cols] = size(square); 
  %对所有小方格的值进行求和
  valueSum = 0; 
  for col = 1 : cols
    for row = 1 : rows 
      valueSum = valueSum + square(row, col); 
    end 
  end 
  value = valueSum ./ totalWeight; 
end 


