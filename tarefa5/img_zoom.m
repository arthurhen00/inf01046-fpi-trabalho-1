function [ output ] = img_zoom( img, zoom, alg )
% IMG_ZOOM Mostra versão escalada da imagem

% Grid original
[sx, sy] = size(img);
[x,y] = meshgrid(1:sx,1:sy);

% Grid da imagem nova
[x1, y1] = meshgrid(1:sx*zoom,1:sy*zoom);

% Calcula posição do ponto na imagem original a partir do grid novo
 for i = 1:sx*zoom;
     for j = 1:sy*zoom;
         x1(i,j)=x1(i,j)/zoom;
         y1(i,j)=y1(i,j)/zoom;
     end;
 end;

output = interp2(double(x), double(y), double(img), double(x1), double(y1), alg);

end

