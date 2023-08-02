function floyd_steinberg_1bit()

    x = double(imread('cameraman.tif'));
    p = x;
    k = 1;
    
    [M,N] = size(x);
    y=zeros(M,N);
    x = [zeros(M,1) x /255 zeros(M,1);zeros(1,N+2)];
    x_save = x;
    
    T = 0.5; % limiar
    
    for i=1 : M
        for j = 2: N + 1
            q=((k-1)*x_save(i,j)+x(i,j))>=T;
            e(i,j) = x(i,j) - q;
            x(i,j+1) = x(i, j +1) + e(i,j)*7/16;
            x(i+1,j-1) = x(i + 1, j - 1) + e(i,j)*3/16;
            x(i+1,j) = x(i+1,j)+e(i,j)*5/16;
            x(i+1,j+1) = x(i + 1, j + 1) + e(i,j)*1/16;
            y(i,j-1) = q;
        end
    
    end
    
    figure, imshow(uint8(p)), title('imagem original 8bit/pixel'),
    figure, imshow(y), title('imagem floyd steinberg 1bit/pixel'),

end