function contrast_stretching_color()

    im = imread('saturn.png');
    [sx, sy, sz] = size(im);

    hsvImage = rgb2hsv(im);
    canalV = hsvImage(:,:,3);

    % Parametros
    % a, b   -> parte alongada
    % Va, Vb -> mapeamento
    Va = 0.12;
    Vb = 0.8;
    a = 0.2;
    b = 0.6;

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
    
    hsvImage(:,:,3) = im_out;

    outputImage = hsv2rgb(hsvImage);

    figure,imshow(im), title('original'),
    figure,imshow(outputImage), title('saida'),
    figure, histogram(canalV), title('histograma canal V original'),
    figure, histogram(im_out), title('histograma canal V saida'),

end