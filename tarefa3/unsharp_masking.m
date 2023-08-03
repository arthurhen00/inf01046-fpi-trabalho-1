function y = unsharp_masking(I,c,sigma)
    M = fspecial('gaussian',c,sigma);
    
    [~,~,D] = size(I);
    
    if D ~= 1
        R = double(I(:,:,1));
        G = double(I(:,:,2));
        B = double(I(:,:,3));

        r1 = conv2(R,M,'same');
        g1 = conv2(G,M,'same');
        b1 = conv2(B,M,'same');

        x = R + (R - r1);
        y = G + (G - g1);
        z = B + (B - b1);
        
        soma = cat(3 , x,y,z);
    else
        r = conv2(double(I),M,'same');
        
        soma = r + (r - double(I));
    end
    
    subplot(2,1,1),imshow(uint8(I)),title('Original');
    label = strcat('tamanho do filtro: ' , num2str(c) , ' - desvio padrão: ' , num2str(sigma));
    subplot(2,1,2),imshow(uint8(soma)),title('C/ unsharp masking'),xlabel(label);
end