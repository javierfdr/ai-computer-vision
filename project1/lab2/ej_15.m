% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.5 Image binarization
% a) Create the binary version of the original image by a threshold value of 20.
car_gray = imread('images/car_gray.jpg');

bi_car = thresholding(car_gray,20);
figure('name','binarized 20'), imshow(bi_car);

% What does it happen if we use different thershold values (30, 150, 255)? Why? 
bi_car = thresholding(car_gray,30);
figure('name','binarized 30'), imshow(bi_car);

bi_car = thresholding(car_gray,150);
figure('name','binarized 150'), imshow(bi_car);

bi_car = thresholding(car_gray,255);
figure('name','binarized 255'), imshow(bi_car);

% The binarization tends to go darker as the threshold goes up, because pixel
% values are converted to zero when they get below the threshold.

% b) Visualize and save the image of threshold 150 as hand_binary.jpg. car_binary???
bi_car = thresholding(car_gray,150);
figure('name','binarized 150'), imshow(bi_car);

imwrite(bi_car,'images/car_binary.jpg');

% c) What will happen if you multiply the original image by the binary image?
car_mult = car_gray .* uint8(bi_car);
figure('name','multiplied by binary img'), imshow(car_mult);

% The binarized image multiplies by zero the values below the threshold, converting
% such pixels to zero, and multiplies by 1 the values above the threshold,
% allowing the brighter values to remain in the image

% d) What will happen if you multiply the original image with the inverted binary image?
bi_car = inv_thresholding(car_gray,150);
car_mult = car_gray .* uint8(bi_car);
figure('name','multiplied by invert binarized img'), imshow(car_mult);

% The values brighter in the original image are removed, and the darker values remain
% that result is the exact opposite effect of the previous experiment
