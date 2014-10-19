% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% thresholding: binarizes an image
% @img: the image to be binarized
% @th: the threshold of the binarization

function [bimg] = thresholding(img, th)
    bimg = zeros(size(img));
    for i = 1:size(img,1)
        for j = 1:size(img,2)
            if img(i,j) >= th
                bimg(i,j) = 1;
            end
        end
    end
end
