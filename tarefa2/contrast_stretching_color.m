function contrast_stretching_color()

    im = imread('lowlight_1.jpg');
    [sx, sy, sz] = size(im);

    hsvImage = rgb2hsv(im);
    hsvImageUINT8 = im2uint8(hsvImage);

    canalH = hsvImageUINT8(:,:,1);
    canalS = hsvImageUINT8(:,:,2);
    canalV = hsvImageUINT8(:,:,3);

    % Parametros
    % a, b   -> parte alongada
    % Va, Vb -> mapeamento
    Va = 10;
    Vb = 200;
    a = 20;
    b = 70;

    % Medidas tiradas do slide 123 (cpi-2-slides 2023.pdf)
    % intensidade da reta
    alpha = (Va - 0)/(a - 0);
    beta = (Vb - Va)/(b - a);
    phi = (sx - Vb)/(sx - b);

    for j = 1:sx
        for i = 1:sy
            if canalV(j,i) >= 0 && canalV(j,i) < a
                im_out(j,i) = alpha * canalV(j,i);
            elseif canalV(j,i) >= a && canalV(j,i) < b
                im_out(j,i) = beta * (canalV(j,i) - a) + Va;
            elseif canalV(j,i) >= b && canalV(j,i) < sx
                im_out(j,i) = phi * (canalV(j,i) - b) + Vb;                
           end
        end
    end
    
    finalHSV = cat(3, canalH, canalS, im_out);
    finalRGB = hsv2rgb(im2double(finalHSV));
    
    subplot(2,3,1),imshow(im), title('original'),
    subplot(2,3,2),imshow(finalRGB), title('strecthing'),
    subplot(2,3,4), histogram(canalV), title('canal V original'),
    subplot(2,3,5), histogram(im_out), title('canal V strecthing'),

    eq = equalizacao_histograma_color(finalRGB);

    subplot(2,3,3),imshow(eq), title('stretching equalizado'),
    t = im2uint8(rgb2hsv(eq));
    tV = t(:,:,3);
    subplot(2,3,6), histogram(tV), title('canal V strecthing equalizado'),

end