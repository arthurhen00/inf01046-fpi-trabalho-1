function [] = main_tarefa_bicubic()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    I = imread('cameraman.tif');
    figure,imshow(uint8(I)),title('Cameraman Original');
    figure,imshow(uint8(scale_bicubic(I, 2, 0.4))),title('Cameraman Bicubic');
    
    I = imread('autumn.tif');
    figure,imshow(uint8(I)), title('Autumn Original');
    figure,imshow(uint8(scale_bicubic_color(I, 2, 0.4))), title('Autumn Bicubic');    
end

