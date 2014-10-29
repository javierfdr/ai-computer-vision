% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.2 Displaying color images

% Read the image sillas.jpg. Display different channels and explain the difference 
% and similarities in pixel values. What would happen if we interchange 
% the channels? What would happen if we multiply one of them by 0?

input('Reading image sillas.jpg. Press enter to continue');
sillas = imread('images/sillas.jpg');
figure('name','sillas.jpg image');
imshow(sillas);

input('Press enter to display the 3 channels separately');
r = sillas(:,:,1);
g = sillas(:,:,2);
b = sillas(:,:,3);

figure('name','Three channels of sillas.jpg')
subplot(3,1,1),imshow(r), title('Red Channel');
subplot(3,1,2),imshow(g), title('Green Channel');
subplot(3,1,3),imshow(b), title('Blue Channel');

% Given the great amount of white in the image it can be seen that the three
% channels contain many pixels with high values. Red channel contains lower-value
% pixels for the chairs, while both blue and green channels show high-value pixels
% If we multiple the one of the channels by 0 the image will be tainted by 
% the color resulting of the mix of the two other channels. For example multiplying
% the red channel by 0 will create a cyan-tainted image (this is particulary evident for
% light pixels - white or near white)


