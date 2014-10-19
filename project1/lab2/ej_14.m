% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.4 Simple geometric operations
% Read the image clooney.jpg and change the place of 
% both figures so that George Clooney stands on the left.

clooney = imread('images/clooney.jpg');

eclooney = exch_img(clooney,213);

figure('name','Exchanged Sides'), imshow(eclooney);
