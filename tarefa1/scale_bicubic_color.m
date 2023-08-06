function [ output ] = scale_bicubic_color( I, scale, w )
    output_r = scale_bicubic(I(:,:,1), scale, w);
    output_g = scale_bicubic(I(:,:,2), scale, w);
    output_b = scale_bicubic(I(:,:,3), scale, w);
    output = cat(3, output_r, output_g, output_b);
end

