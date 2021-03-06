% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.1 Creating images of 3 channels (color images)
% The RGB images are formed by 3 matrices, commonly called channels.
% Create the 3 images in gray scale as shown in Figure 1.

c1 = [zeros(256,128), ones(256,128)];
c2 = [zeros(128,256); ones(128,256)];
c3 = [ones(128),zeros(128); zeros(128,256)];

input('Generating 3channels image. Press enter to continue');

cm = cat(3,c1,c2,c3);

figure('name','Three channels and a RGB image')
subplot(1,4,1),imshow(c1), title('Red Channel');
subplot(1,4,2),imshow(c2), title('Blue Channel');
subplot(1,4,3),imshow(c3), title('Green Channel');
subplot(1,4,4),imshow(cm), title('RGB');


imwrite(cm,'3channels.jpg','jpg');

