function filtered_image = alpha_trimmed_mean_filter(original_image, alpha, window_size)
    original_image = im2double(original_image); % Convert original image to double

    % Adiciona o ruido na imagem original
    image_noisy = apply_noise(original_image, 0.01, 0.01);

    % Aplica o filtro
    filtered_image = alphatrimmedmeanfilter_rgb(image_noisy, alpha, window_size);
    
    
    [SNR_noisy, PSNR_noisy] = calcula_SNR_PSNR(original_image, image_noisy);
    [SNR_filtered, PSNR_filtered] = calcula_SNR_PSNR(original_image, filtered_image);
    
    noisy_label = strcat('SNR: ', num2str(SNR_noisy), ' - PSNR: ', num2str(PSNR_noisy));
    filtered_label = strcat('SNR: ', num2str(SNR_filtered), ' - PSNR: ', num2str(PSNR_filtered));
    
    subplot(2, 4, [2, 3]), imshow(original_image), title('Original');
    subplot(2, 4, [5, 6]), imshow(image_noisy), title('Ruidosa'), xlabel(noisy_label);
    subplot(2, 4, [7, 8]), imshow(filtered_image), title('Filtrada'), xlabel(filtered_label);

end

function result = alphatrimmedmeanfilter_rgb(image, alpha, window_size)
    [M, N, D] = size(image); 
    
    % Calcula o inicio e o final do vetor a ser considerado para o calculo da media
    start =  floor((window_size^2 - window_size) * alpha);
    window_side = floor(window_size / 2);
    end_val =  ceil(window_size^2-(window_size^2 - window_size) * alpha);
    
    % Copia a matriz
    result = image; 
    
    % Itera sobre todos elementos exceto os da borda
    for m = window_side+1:M-window_side
        for n = window_side+1:N-window_side
            for i = 1:D
                % Pega a janela para filtragem
                window = image(m-window_side:m+window_side, n-window_side:n+window_side, i);

                % Ordena os elementos
                window_r_sorted = sort(window(:));

                % Remove os cantos do vetor de elementos
                window_trimmed = window_r_sorted(start+1:end_val);

                % Calcula o valor do pixel (m,n) - média dos valores no vetor
                result(m, n, i) = mean(window_trimmed);
            end
        end
    end
end

function [SNR, PSNR] = calcula_SNR_PSNR(I, I_noisy)
    % Ensure both images are of type double
    I = im2double(I);
    I_noisy = im2double(I_noisy);
    
    % Calculate SNR and PSNR for each color channel independently
    channels = size(I, 3);
    SNR = zeros(1, channels);
    PSNR = zeros(1, channels);
    for c = 1:channels
        % Extract the individual color channel
        I_channel = I(:,:,c);
        I_noisy_channel = I_noisy(:,:,c);

        % Calculate SNR for the channel
        SNR(c) = 10*log10(double(std2(I_channel)^2 / std2(I_channel - I_noisy_channel)^2));
        
        % Calculate PSNR for the channel
        I_max = double(max(max(I_channel)));
        I_min = double(min(min(I_channel)));
        A = (I_max - I_min);
        PSNR(c) = 10*log10(double((A^2) / (std2(I_channel - I_noisy_channel)^2 + 0.00001)));
    end

    % Combine SNR and PSNR for all color channels
    SNR = mean(SNR);
    PSNR = mean(PSNR);
end

function image_noisy = apply_noise(image,sp,ga)
    image_noisy = imnoise(image,'salt & pepper',sp);
    image_noisy = imnoise(image_noisy,'gaussian',ga);
end
