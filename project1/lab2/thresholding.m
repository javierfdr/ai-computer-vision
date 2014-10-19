% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% thresholding: binarizes an image
% @img: the image to be binarized
% @th: the threshold of the binarization

function [bimg] = thresholding(img, th)
    
    function nelem = applyth(elem)
        nelem = 0
        if elem > th:
            nelem = 1
        end
    end
    
    bimg = arrayfun(applyth, img);
end
