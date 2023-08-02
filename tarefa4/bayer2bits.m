function bayer2bits()

    % Carregar a imagem de 8 bits/pixel
    I = imread('cameraman.tif');
    
    % Definir a matriz Bayer 2x2 para o dithering
    bayerMatrix2x2 = [0, 2;
                      3, 1];
    
    % Quantização usando dithering Bayer
    % 8bits -> 2bits ( [0:255] / [0:3] ) = 
    I_quantized = floor(double(I) / (255/3) );
    
    % Adicionar a matriz Bayer à imagem quantizada (lidando com os valores fora dos limites)
    [row, col] = size(I);
    for i = 1:row
        for j = 1:col
            I_2bits(i, j) = min(max(I_quantized(i, j) + bayerMatrix2x2(mod(i-1, 2)+1, mod(j-1, 2)+1), 0), 3);
        end
    end
    
    % Exibir a imagem resultante
    figure, imshow(uint8(I)), title('imagem com 8 bits/pixel');
    %figure, imshow(uint8(I_quantized * (255/3)), []), title('imagem com 2 bits/pixel');
    figure, imshow(uint8(I_2bits * (255/3)), []), title('bayer com 2 bits/pixel');

end