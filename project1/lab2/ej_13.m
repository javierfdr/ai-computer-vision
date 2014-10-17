% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.3 Managing different size and filters

% a) Read one of the images in the images.rar.
corals = imread('images/corals.jpg');

%b) Show how details of the image disappear when rescale the size of the image (Help: imresize). Does the histogram change of both images (the original and the rescaled one)? Return back the smaller image to the original size. Compare to the original one.

small_corals = imresize(corals,0.2);
rescaled_corals = imresize(small_corals,5);

input('Press enter to show histograms of small and original corals image.');

figure, imhist(small_corals(:,:,1));
figure, imhist(corals(:,:,1));

% The histogram of the downsized image shows a less smooth curve where different
% values along the grayscale appear more than in the original image. It is also
% evidenced that there are less pixels in the image due to the count of occurences for
% each bin. So, downsized image has lost information

input('Press enter to show histograms of original and resized back image of corals');
figure, imhist(rescaled_corals(:,:,1));
figure, imhist(corals(:,:,1));

% When rescaling a more continous or smooth curve is obtained. It is also observed
% that intensities are more evenly distributed that in the original image.

% c) As an alternative of removing image details, apply different smoothing 
% filters (by user-defined mask as a vector e.g. [1 1 1] vs. 
% Gaussian filter). 
% Discuss how the size of the filter or mask affect the final outcome.

input('Press enter to show three smoothed images by using square filters of size 3x3, 5x5, 8x8');
h = ones(3,3)/9;
square_corals33 = imfilter(corals(:,:,1),h);
figure, imshow(square_corals33);

h = ones(5,5)/25;
square_corals55 = imfilter(corals(:,:,1),h);
figure, imshow(square_corals55);

h = ones(8,8)/64;
square_corals88 = imfilter(corals(:,:,1),h);
figure, imshow(square_corals88);

input('Press enter to show three smoothed images by using gaussian filters of (sigma, mask) as (3, 3x3), (3, 5x5), (3, 8x8)')




