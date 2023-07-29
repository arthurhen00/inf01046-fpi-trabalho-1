function ordem_zero_gray()

    % Ordem zero

    input_image = imread('cameraman.tif');
    scale_factor = 2;

    [sx, sy] = size(input_image);
    newsx = scale_factor * sx;
    newsy = scale_factor * sy;
    
    for x = 1:newsx
        for y = 1:newsy
            % calculo do mapeamento
            real_y = min(max(round(y / scale_factor), 1), sy);
            real_x = min(max(round(x / scale_factor), 1), sx);

            output_image(x, y) = input_image(real_x, real_y);
        end
    end

    figure, imshow(input_image), title('imagem original');
    figure, imshow(output_image), title('output image');

end
