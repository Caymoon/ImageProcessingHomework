%linearFilter:  
%对图像进行线性滤波处理 
%输入：
  %image => 需要滤波处理的原图像
  %arg => 线性滤波所使用的算法, 如 1 [使用“标准像素平均值"的方形平滑(均值)滤波器]、2 [使用“加权平均”的方形平滑(均值)滤波器]、3 [使用“高斯函数”的方形平滑(均值)滤波器]
  %measure => 滤波方格的尺寸向量
%输出：线性滤波处理后的图像
function [result] = linearFilter(image, arg, measures) 
  Gauss = [1, 4, 7, 4, 1; 4, 16, 26, 16, 4; 7, 26, 41, 26, 7; 4, 16, 26, 16, 4; 1, 4, 7, 4, 1] ./ 273; %高斯矩阵[化简后的高斯函数]
  %算出图像的尺寸
  [rows, cols] = size(image); 
  %得到尺寸向量的长度
  sizeOfMeasures = max(size(measures));
  for index = 1 : sizeOfMeasures 
    %取得一个尺寸
    measure = measures(index); 
    %该尺寸的中间值，如尺寸为5，则中间值为3
    len = (measure + 1) ./ 2; 
    %初始化滤波方格
    tempSquare = zeros(measure); 
    %col/row: 先列后行遍历原图像每一个像素点
    for col = 1 : cols 
      for row = 1 : rows 
        %totalWeight: 总权重
        totalWeight = 0; 
        %innerCol/innerRow：先列后行计算每一个滤波小方格的加权值
        for innerCol = 1 : measure 
          for innerRow = 1 : measure 
            %判断当前的滤波小方格是否超出原图像边缘
            if (col - (len - innerCol)) < 1 || (col - (len - innerCol)) > cols || (row - (len - innerRow)) < 1 || (row - (len - innerRow)) > rows 
              continue; 
            end 
            %判断是选用哪一种算法
            switch arg 
            case 0  %“标准像素平均值”法
              %不加权直接求和
              tempSquare(innerRow, innerCol) = image(row - (len - innerRow), col - (len - innerCol)); 
              totalWeight = totalWeight + 1; 
            case 1  %“加权平均”法
              %判断当前的小方格是处于由中心向外第cycleIndex圈
              cycleIndex = max(abs(innerCol - len), abs(innerRow - len)); 
              %当前方格的权重是0.5的cycleIndex次幂
              tempWeight = 0.5 .^ cycleIndex; 
              %求取加权总和
              tempSquare(innerRow, innerCol) = tempWeight .* image(row - (len - innerRow), col - (len - innerCol)); 
              %求取权值总和
              totalWeight = totalWeight + tempWeight; 
            case 2  %“高斯函数”法
              %获取当前的高斯权值
              tempWeight = Gauss(innerRow, innerCol); 
              tempSquare(innerRow, innerCol) = tempWeight .* image(row - (len - innerRow), col - (len - innerCol)); 
              totalWeight = totalWeight + tempWeight; 
            end 
          end 
        end 
        %计算当前像素点滤波处理后的像素值
        resImgs{index}(row, col) = calAverage(tempSquare, totalWeight); 
      end 
    end 
    %将该矩阵转换成图像
    resImgs{index} = mat2gray(resImgs{index}, [0, 255]); 

    %保存该图像到文件
    switch arg 
    case 0 
      imwrite(resImgs{index}, sprintf('res_[%s]_[measure_%d].png', 'Standard_Average', measure)); 
    case 1
      imwrite(resImgs{index}, sprintf('res_[%s]_[measure_%d].png', 'Weighted_Average', measure)); 
    case 2
      imwrite(resImgs{index}, sprintf('res_[%s]_[measure_%d].png', 'Gauss_Average', measure)); 
    end
  end 
  %返回滤波后的图像集合
  result = resImgs; 
end 

