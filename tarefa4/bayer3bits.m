function bayer3bits()

    % Carregar a imagem de 8 bits/pixel
    I = imread('cameraman.tif');
    
    % Definir a matriz Bayer 4x4 para o dithering
    bayerMatrix4x4 = [ 0,  8,  2, 10; 
                       12,  4, 14,  6; 
                       3, 11,  1,  9; 
                       15, 7, 13,  5];
    
    % Quantização usando dithering Bayer
    % 8bits -> 2bits ( [0:255] / [0:7] ) = 
    I_quantized = floor(double(I) / (255/7) );
    
    % Adicionar a matriz Bayer à imagem quantizada e limitar aos níveis corretos
    [row, col] = size(I);
    for i = 1:row
        for j = 1:col
            I_3bits(i, j) = min(max(I_quantized(i, j) + bayerMatrix4x4(mod(i-1, 4)+1, mod(j-1, 4)+1), 0), 7);
        end
    end

    % Exibir a imagem resultante
    figure, imshow(uint8(I)), title('imagem com 8 bits/pixel');
    %figure, imshow(uint8(I_quantized * (255/7)), []), title('imagem com 3 bits/pixel');
    figure, imshow(uint8(I_3bits * (255/7)), []), title('bayer com 3 bits/pixel');

end