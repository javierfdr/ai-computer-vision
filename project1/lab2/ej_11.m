% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.1 Creating images of 3 channels (color images)
% The RGB images are formed by 3 matrices, commonly called channels.
% Create the 3 images in gray scale as shown in Figure 1.

c1 = [zeros(256,128), ones(256,128)];
c2 = [zeros(128,256); ones(128,256);
c3 = [zeros(64),ones(64); ones(128,256)];

input('Generating 3channels image. Press enter to continue');
cm = cat(s1,s2,s3);
figure, imshow(cm);

imwrite(cm,'3channels.jpg','jpg','Mix of 3 Channels','');

