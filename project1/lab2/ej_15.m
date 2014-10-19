% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.5 Image binarization
% a) Create the binary version of the original image by a threshold value of 20.
% What does it happen if we use different thershold values (30, 150, 255)? Why? 

car_gray = imread('images/car_gray.jpg');

bi_car = thresholding(car_gray,20);

figure('name','binarized'), imshow(bi_car);
