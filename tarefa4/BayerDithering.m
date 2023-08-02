function BayerDithering(bits_per_pixel)

    bits_per_pixel = 4;

    % Carregar a imagem de 8 bits/pixel
    image = double(imread('cameraman.tif')) / 255; % Normalizar para valores entre 0 e 1
    
    % Definir a matriz Bayer 4x4 para o dithering
    bayerMatrix4x4 = [0,  8,  2, 10; 12,  4, 14,  6; 3, 11,  1,  9; 15,  7, 13,  5];
    
    % Calcula o fator de quantização com base no número de bits por pixel
    quantization_factor = 2^bits_per_pixel - 1;
    
    % Quantização usando dithering Bayer
    image_quantized = floor(image * quantization_factor) / quantization_factor;
    
    % Inicializar a imagem dithered
    [M, N] = size(image);
    image_dithered = zeros(M, N);
    
    % Aplicar o dithering Bayer
    for i = 1:M
        for j = 1:N
            image_dithered(i, j) = image_quantized(i, j) + bayerMatrix4x4(mod(i-1, 4)+1, mod(j-1, 4)+1) / 16;
        end
    end
    
    % Exibir a imagem resultante
    figure, imshow(image), title('imagem 8bits/pixel');
    figure, imshow(image_dithered), title(['imagem ', num2str(bits_per_pixel), 'bits/pixel']);
    
end
