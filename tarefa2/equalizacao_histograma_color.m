function I_out = equalizacao_histograma_color(I_in)

    %I_in = imread('autumn.tif');

    hsvImage = rgb2hsv(I_in);
    hsvImageUINT8 = im2uint8(hsvImage);

    canalH = hsvImageUINT8(:,:,1);
    canalS = hsvImageUINT8(:,:,2);
    canalV = hsvImageUINT8(:,:,3);

    I_in = canalV;

    for i = 1:256
        h(i) = sum(sum(I_in == i-1));
    end

    I_out = I_in;

    s = sum(h);

    for i = 1:256
        posicoes = find(I_in == i-1);
        I_out(posicoes) = sum(h(1:i))/s*255;
    end

    finalHSV = cat(3, canalH, canalS, I_out);
    finalRGB = hsv2rgb(im2double(finalHSV));

    I_out = finalRGB;

    %figure,imshow(I_in), title('original'),
    %figure,imshow(I_out), title('saida'),
    %figure, histogram(I_in), title('histograma original'),
    %figure, histogram(I_out), title('histograma saida'),
end