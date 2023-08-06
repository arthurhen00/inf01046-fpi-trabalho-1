function I_out = equalizacao_histograma_gray(I_in)

    %I_in = imread('moon.tif');

    for i = 1:256
        h(i) = sum(sum(I_in == i-1));
    end

    I_out = I_in;

    s = sum(h);

    for i = 1:256
        posicoes = find(I_in == i-1);
        I_out(posicoes) = sum(h(1:i))/s*255;
    end

    %figure,imshow(uint8(I_in)), title('original'),
    %figure,imshow(uint8(I_out)), title('saida'),
    %figure, histogram(I_in), title('histograma original'),
    %figure, histogram(I_out), title('histograma saida'),
end