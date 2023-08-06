function [output] = scale_bicubic( I, scale, w )
%scale_bicubic Escala uma imagem em tons de cinza com interpolação bicubica
    
    % Limita o w em [0.0, 0.5]
    w = min(max(w, 0.0), 0.5);

    % Inicializa a imagem escalada
    [sx, sy] = size(I);
    newsx = (sx * scale) - 4;
    newsy = (sy * scale) - 4;
    I = double(I);
    
    output = zeros(newsx, newsy);
    
    % Faz a interpolação
    for i = 1:newsx
        for j = 1:newsy
            real_i = min(max(round(i / scale), 1), sx - 4);            
            real_j = min(max(round(j / scale), 1), sy - 4);                       
            % Interpola em blocos 4x4
            output(i,j) = interp_bicubic(I(real_i:real_i+4, real_j:real_j+4), w, w);
        end
    end
end

function [ v ] = interp_bicubic( p, x, y )
% interp_bicub Interpola um bloco 4x4 com pesos x e y
    a = interp_cubic(p(1,1), p(1,2), p(1,3), p(1,4), y);
    b = interp_cubic(p(2,1), p(2,2), p(2,3), p(2,4), y);
    c = interp_cubic(p(3,1), p(3,2), p(3,3), p(3,4), y);
    d = interp_cubic(p(4,1), p(4,2), p(4,3), p(4,4), y);
    v = interp_cubic(a,b,c,d,x);
end

function [ v ] = interp_cubic( a, b, c, d, x)
% interp_cubic Interpola bicucamente entre 4 valores
    v = b + 0.5 * x * (c - a + x * (2.0 * a - 5.0 * b + 4.0 * c - d + x * (3.0 * (b - c) + d - a)));
end
