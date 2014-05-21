%主函数

%读入源图像
sample = imread('sample.tif'); 

%使用“标准像素平均值"的方形平滑(均值)滤波器
res0 = linearFilter(sample, 0, [3, 5, 9, 15, 35]); 

%使用“加权平均”的方形平滑(均值)滤波器
res1 = linearFilter(sample, 1, [3, 5, 9, 15, 35]); 

%使用“高斯函数”的方形平滑(均值)滤波器[默认尺寸：5]
res2 = linearFilter(sample, 2, [5]); 
