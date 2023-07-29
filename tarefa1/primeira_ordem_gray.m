function primeira_ordem_gray()

    input_image = imread('cameraman.tif');
    %****************************
    % FUNCIONA APENAS PARA 2X
    %****************************
    scale_factor = 2;

    [sx, sy] = size(input_image);
    newsx = scale_factor * sx;
    newsy = scale_factor * sy;
    
    for x = 1:newsx - 1
        for y = 1:newsy -1
            % SÓ FUNCIONA PARA SCALE = 2
            real_y = min(max(round(y / scale_factor), 1), sy);
            real_x = min(max(round(x / scale_factor), 1), sx);

            % linha impar -> valor do pixel
                % coluna impar -> valor do pixel
                % coluna par -> (pixel + pixel_posterior)/2
            % linha par
                % coluna impar -> (pixel + pixel_abaixo)/2
                % coluna par -> (pixel + pixel_posterior + pixel_abaixo +
                % pixel diagonal inferior esq)/4

            % linha par    
            if mod(x, 2) == 0
                %coluna par
                if mod(y,2) == 0
                    output_image(x, y) = ( double(input_image(real_x, real_y)) + ...
                        double(input_image(real_x, real_y + 1)) + ...
                        double(input_image(real_x + 1, real_y)) + ...
                        double(input_image(real_x + 1, real_y + 1)) )/4;
                % coluna impar
                else
                    output_image(x, y) = ( double(input_image(real_x, real_y)) + ...
                        double(input_image(real_x + 1, real_y)) )/2;
                end
            % linha impar
            else
                %coluna par
                if mod(y,2) == 0
                    output_image(x, y) = ( double(input_image(real_x, real_y)) ... 
                        + double(input_image(real_x, real_y + 1)) )/2;
                % coluna impar
                else
                    output_image(x, y) = double(input_image(real_x, real_y));
                end
            end
        end
    end

    figure, imshow(uint8(input_image)), title('imagem original');
    figure, imshow(uint8(output_image)), title('output image');


end