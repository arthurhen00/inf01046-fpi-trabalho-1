function [] = img_rotate( img , angle )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

close all;

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
 
% Imagem sem alteração
figure,title('original'),imshow(img);
 
% Interpolação Nearest Neighbour
z1=interp2(double(x), double(y), double(img), double(x1), double(y1), 'nearest');
figure,title('nearest'),imshow(uint8(z1));

% Interpolação Cúbica
z1=interp2(double(x), double(y), double(img), double(x1), double(y1), 'cubic');
figure,title('cubic'),imshow(uint8(z1));

end

