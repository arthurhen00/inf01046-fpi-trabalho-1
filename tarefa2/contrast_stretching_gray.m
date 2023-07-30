function im_out = contrast_stretching_gray(im, a, b, param)

    % u = valor do pixel
    % a = limite inferior
    % b = limite superior
    % B = sei la
    % Y = sei la

    im = imread('cameraman.tif');
    a = 50;
    b = 150;
    param = 0.2;
    B = 2;
    Y = 1;
    Va = 30;
    Vb = 200;

    [sx, sy] = size(im);

    for j = 1:sx
        for i = 1:sy
           if im(j,i) >= a && im(j,i) < b
                im_out(j,i) = B*(im(j,i) - a) + Va;
           else 
               if im(j,i) >= b && im(j,i) < 255
                    im_out(j,i) = Y*(im(j,i) - b) + Vb;
               else
                    im_out(j,i) = im(j,i) * param;
               end
           end 
        end
    end
    

    figure,imshow(uint8(im)), title('original'),
    figure,imshow(uint8(im_out)), title('saida'),
    figure, histogram(im), title('histograma original'),
    figure, histogram(im_out), title('histograma saida'),

end