function contrast_stretching_gray()

    im = imread('kids.tif');
    [sx, sy] = size(im);

    % Parametros
    % a, b   -> parte alongada
    % Va, Vb -> mapeamento
    Va = 30;
    Vb = 150;
    a = 0;
    b = 40;

    % Medidas tiradas do slide 123 (cpi-2-slides 2023.pdf)
    % intensidade da reta
    alpha = (Va - 0)/(a - 0);
    beta = (Vb - Va)/(b - a);
    phi = (sx - Vb)/(sx - b);

    for j = 1:sx
        for i = 1:sy
            if im(j,i) >= 0 && im(j,i) < a
                im_out(j,i) = alpha * im(j,i);
            elseif im(j,i) >= a && im(j,i) < b
                im_out(j,i) = beta * (im(j,i) - a) + Va;
            elseif im(j,i) >= b && im(j,i) < sx
                im_out(j,i) = phi * (im(j,i) - b) + Vb;                
           end
        end
    end
    
    subplot(2,3,1),imshow(uint8(im)), title('original'),
    subplot(2,3,2),imshow(uint8(im_out)), title('stretching'),
    subplot(2,3,4), histogram(im), title(' original'),
    subplot(2,3,5), histogram(im_out), title('stretching'),

    eq = equalizacao_histograma_gray(im_out);

    subplot(2,3,3),imshow(uint8(eq)), title('stretching equalizada'),
    subplot(2,3,6), histogram(eq), title('stretching equalizada'),

end