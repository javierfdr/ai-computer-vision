% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.6 Treating color images

% a) Open hand.jpg and convert it in gray scale image.
hand = imread('images/hand.jpg');
mapfre = imread('images/mapfre.jpg');

hand_gray = hand(:,:,1) .+ hand(:,:,2) .+ hand(:,:,3);
figure('name','Gray Scale hand'), imshow(hand_gray);

% b) Perform a binarization to obtain a binary image of 2 regions: 
% the hand (called (foreground) and the rest (called background).
% Create the inverse binary image changing the areas of foreground and background.
hand_gray_bi = thresholding(hand_gray,50);
figure('name','Gray Scale hand binarized'),imshow(hand_gray_bi);
hand_gray_inv_bi = inv_thresholding(hand_gray,50);
figure('name','Gray Scale hand inv binarized'), imshow(hand_gray_inv_bi);

hand_gray_bi = uint8(hand_gray_bi);
hand_gray_inv_bi = uint8(hand_gray_inv_bi);

% c) Use binary matrices created in b) to merge the images hand and mapfre
hand_gray_foreground = cat(3,hand(:,:,1) .* hand_gray_bi, hand(:,:,2) .* hand_gray_bi, hand(:,:,3) .* hand_gray_bi);

mapfre_background = cat(3,mapfre(:,:,1) .* hand_gray_inv_bi, mapfre(:,:,2) .* hand_gray_inv_bi, mapfre(:,:,3) .* hand_gray_inv_bi);

merged_img = hand_gray_foreground .+ mapfre_background;
figure('name','Merged img'), imshow(merged_img);

% d) Save the image as hand_mapfre_3C.jpg.
imwrite(merged_img,'images/hand_mapfre_3C.jpg');
