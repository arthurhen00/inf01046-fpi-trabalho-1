function ordem_zero_color()

    % Ordem zero

    input_image = imread('autumn.tif');
    scale_factor = 5;

    redChannel = input_image(:,:,1);
    greenChannel = input_image(:,:,2);
    blueChannel = input_image(:,:,3);

    [sx, sy, sz] = size(input_image);
    newsx = scale_factor * sx;
    newsy = scale_factor * sy;
    
    for x = 1:newsx
        for y = 1:newsy
            % calculo do mapeamento
            real_y = min(max(round(y / scale_factor), 1), sy);
            real_x = min(max(round(x / scale_factor), 1), sx);

            output_imageR(x, y) = redChannel(real_x, real_y);
            output_imageG(x, y) = greenChannel(real_x, real_y);
            output_imageB(x, y) = blueChannel(real_x, real_y);
        end
    end

    saidaRGB = cat(3, output_imageR, output_imageG, output_imageB);

    figure, imshow(input_image), title('imagem original');
    figure, imshow(saidaRGB), title('output image');

end
