function ruido_pseudo_aleatorio()

    I = double(imread('cameraman.tif'));

    % quantizacao simples 3bits
    I_q = floor(I./max(max(I)).*(2^3));

    % quantizacao aleatoria 3bits
    [sx, sy] = size(I);
    A = max(max(I))/5;
    I_noise = rand(sx, sy).*A;
    I_qn = floor((I + I_noise)./max(max(I + I_noise)).*(2^3));

    figure, imshow(uint8(I)), title('imagem original - 8bits/pixel'),
    figure, imshow(uint8(I_q.*40)), title('imagem quantizada simples - 3bits/pixel'),
    figure, imshow(uint8(I_qn.*40)), title('imagem quantizada aleatorio - 3bits/pixel'),

end