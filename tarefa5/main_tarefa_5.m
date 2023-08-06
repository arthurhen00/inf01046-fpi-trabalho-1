function [] = main_tarefa_5(s)
    I = imread('Lenna.jpg'); 
    run_test(I, s);
end

function [] = run_test(I, s)
    [nn, cb] = show_scale(I, s);
    
    cap = sprintf('Escala %d nearest; Rot 45 graus', s);
    show_rotate(nn, 0.785, cap);
    cap = sprintf('Escala %d cubic; Rot 45 graus', s);
    show_rotate(cb, 0.785, cap);
    
    cap = sprintf('Escala %d nearest; Rot 5 graus', s);
    show_rotate(nn, 0.0872, cap);
    cap = sprintf('Escala %d cubic; Rot 5 graus', s);
    show_rotate(cb, 0.0872, cap);  
end

function [s2, s3] = show_scale(I, s)
    % Imagem sem alteração
    figure,imshow(I),title('Original');     
    
    % Interpolação Nearest Neighbour
    s2 = img_zoom_color(I, s, 'nearest');    
    c = sprintf('Escala %d nearest', s);
    figure,imshow(uint8(s2)),title(c);

    % Interpolação Cúbica
    s3 = img_zoom_color(I, s, 'cubic');
    c = sprintf('Escala %d cubic', s);
    figure,imshow(uint8(s3)),title(c);
end

function [ output ] = img_zoom_color(I, s, alg)
    output_r = img_zoom(I(:,:,1), s, alg);
    output_g = img_zoom(I(:,:,2), s, alg);
    output_b = img_zoom(I(:,:,3), s, alg);
    output = cat(3, output_r, output_g, output_b);
end

function [] = show_rotate(I, angle, cap)
    nn = img_rotate_color(I, angle, 'nearest');
    cb = img_rotate_color(I, angle, 'cubic');
    
    c = sprintf('%s nearest', cap);
    figure,imshow(uint8(nn)), title(c);
    c = sprintf('%s cubic', cap);
    figure,imshow(uint8(cb)), title(c);
end

function [ output ] = img_rotate_color(I, angle, alg)
    output_r = img_rotate(I(:,:,1), angle, alg);
    output_g = img_rotate(I(:,:,2), angle, alg);
    output_b = img_rotate(I(:,:,3), angle, alg);
    output = cat(3, output_r, output_g, output_b);
end
