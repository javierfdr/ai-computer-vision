% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% exch_img: exchanges sides of an image
% @img: the image to be fliped
% @cc: the flip column

function [eimg] = exch_img(img, cc)
    eimg = [img(:,cc+1:end,:),img(:,1:cc,:)];
end

