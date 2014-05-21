sample = imread('sample.tif'); 

imwrite(sample, 'resolution_300dpi.tif', 'compression', 'none', 'resolution', [300 300]); 
imwrite(sample, 'resolution_150dpi.tif', 'compression', 'none', 'resolution', [150 150]); 
imwrite(sample, 'resolution_72dpi.tif', 'compression', 'none', 'resolution', [72 27]); 
