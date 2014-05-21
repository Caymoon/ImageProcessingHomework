sample = imread('sample2.tif'); 

%bitdepths_using_imwrite = [128, 64, 32, 16, 8, 4, 2]; 
bitdepths_using_imwrite = [16, 8, 4, 2]; %因为imwrite()对输出灰度的处理只有这四个值
bitdepths_using_histeq = [128, 64, 32, 16, 8, 4, 2]; 

length = max(size(bitdepths_using_imwrite)); 

%用imwrite更改灰度分辨率
for i = 1 : length 
  imwrite(sample, sprintf('bitdepth_using_imwrite%d.png', bitdepths_using_imwrite(i)), 'bitdepth', bitdepths_using_imwrite(i)); 
end

length = max(size(bitdepths_using_histeq)); 

%用histeq更改灰度分辨率
for i = 1 : length 
  imwrite(histeq(sample, bitdepths_using_histeq(i)), sprintf('bitdepths_using_histeq%d.png', bitdepths_using_histeq(i))); 
end 

