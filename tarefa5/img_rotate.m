function [ output ] = img_rotate( img, angle, alg )
% img_rotate Rotaciona a imagem am angle radianos

% Grid original
[sx, sy] = size(img);
[x,y] = meshgrid(1:sx,1:sy);

% Grid da imagem nova
[x1, y1] = meshgrid(1:sx,1:sy);
[sx, sy] = size(x1);

cosT = cos(angle);
sinT = sin(angle);
 
% Calcula posição do ponto na imagem original a partir do grid novo
 for i = 1:sx;
     for j = 1:sy;
         % Move para a origem
         x1(i,j) = x1(i,j) - sx/2;
         y1(i,j) = y1(i,j) - sy/2;
         
         % Rotaciona
         x1s = x1(i,j);
         y1s = y1(i,j);
         
         x1(i,j)= (x1s *  cosT) + (y1s * sinT);
         y1(i,j)= (x1s * -sinT) + (y1s * cosT);
         
         % Move de volta
         x1(i,j) = x1(i,j) + sx/2;
         y1(i,j) = y1(i,j) + sy/2;         
     end;
 end;
 
output = interp2(double(x), double(y), double(img), double(x1), double(y1), alg);

end

