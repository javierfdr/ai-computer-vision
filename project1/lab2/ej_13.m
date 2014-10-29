%Computer Vision (MAI) - Exercises from Practicum 2
%Javier Fernandez (javierfdr@gmail.com)
%Alejandro Hernandez (alejandro.ajhr@gmail.com)

%1.3 Managing different size and filters

function [] = ej_13(image_file)

% a) Read one of the images in the images.rar.
image = imread(image_file);

%b) Show how details of the image disappear when rescale the size of the image (Help: imresize). Does the histogram change of both images (the original and the rescaled one)? Return back the smaller image to the original size. Compare to the original one.

small_image = imresize(image,0.2);
rescaled_image = imresize(small_image,5);

input('Press enter to show original vs small resized image');
figure('name', 'Original vs Small resized Image');
subplot(1,2,1),imshow(image), title('Original Image');
subplot(1,2,2),imshow(small_image), title('Small Resized Image');

input('Press enter to show histograms of small and original image.');

figure('name','Small Image Histogram'), imhist(small_image(:,:,1)),title('Histogram: Small Resized Image');;
figure('name', 'Original Image Histogram'), imhist(image(:,:,1)),title('Histogram: Original Image');;

% The histogram of the downsized image shows a less smooth curve where different
% values along the grayscale appear more than in the original image. It is also
% evidenced that there are less pixels in the image due to the count of occurences for
% each bin. So, downsized image has lost information

input('Press enter to show original vs resized from small image');
figure('name', 'Original vs Resized from Small Image');
subplot(1,2,1),imshow(image), title('Original Image');
subplot(1,2,2),imshow(rescaled_image), title('Resized from Small Image');

input('Press enter to show histograms of original and resized back image');
figure('name','Rescaled Image Histogram'), imhist(rescaled_image(:,:,1)), title('Histogram: Rescaled Image');;
figure('name','Original Image Histogram'), imhist(image(:,:,1)),title('Histogram: Original Image');;

% When rescaling a more continous or smooth curve is obtained. It is also observed
% that intensities are more evenly distributed that in the original image.

% c) As an alternative of removing image details, apply different smoothing 
% filters (by user-defined mask as a vector e.g. [1 1 1] vs. 
% Gaussian filter). 
% Discuss how the size of the filter or mask affect the final outcome.

input('Press enter to show three smoothed images by using square filters of size 5x5, 8x8, 15x15');
h = ones(5,5)/25;
square_image55 = imfilter(image(:,:,1),h);
figure('name','Smoothing with three different box filters')
subplot(2,2,1),imshow(image(:,:,1)), title('Original Image');

subplot(2,2,2),imshow(square_image55), title('Box Filter 5x5');

h = ones(8,8)/64;
square_image88 = imfilter(image(:,:,1),h);
subplot(2,2,3), imshow(square_image88), title('Box Filter 8x8');

h = ones(15,15)/225;
square_image15 = imfilter(image(:,:,1),h);
subplot(2,2,4), imshow(square_image15), title('Box Filter 15x15');

% It can be observed how increasing the size of the mask increases 
% the smoothing of the image. This is achieved by making nearest 
% pixels to become more similar so generating more continuity in 
% the grayscale. By observing the histograms of the original image
% versus the histograms of the smoothed ones is clear that the usage
% of the grayscale is more evenly distributed
% 
% By box smoothing it is observed the appearance of ringing: horizontal
% and vertical lines

input('Press enter to show three smoothed images by using gaussian filters of (sigma, mask) as (3, 5x5), (3, 10x10), (8,5x5), (8, 10x10))')
sigma35 = fspecial('gaussian', 5, 3);
imagesigma35 = imfilter(image(:,:,1),sigma35);
figure('name','Smoothing with four gaussian filters')
subplot(2,2,1), imshow(imagesigma35), title('Gaussian Filter: 5x5 o=3');

sigma310 = fspecial('gaussian', 10, 3);
imagesigma310 = imfilter(image(:,:,1),sigma310);
subplot(2,2,2), imshow(imagesigma310), title('Gaussian Filter: 10x10 o=3');

sigma85 = fspecial('gaussian', 5, 8);
imagesigma85 = imfilter(image(:,:,1),sigma85);
subplot(2,2,3), imshow(imagesigma85),title('Gaussian Filter: 5x5 o=8');

sigma810 = fspecial('gaussian', 10, 8);
imagesigma810 = imfilter(image(:,:,1),sigma810);
subplot(2,2,4), imshow(imagesigma810),title('Gaussian Filter: 10x10 o=8');

input('Press enter to show two histograms of previous gaussian filters')
input('Press enter to see two histograms from gaussian filters: ')
figure('name','Histograms of two gaussian filters (10,3) (10,8)'), imhist(imagesigma310), title('Histogram: Gaussian Filter: 10x10 o=3');
figure('name','Histogram: Gaussian Filter: 10x10 o=8'), imhist(imagesigma810), title('Histogram: Gaussian Filter: 10x10 o=8');

%Applying the gaussian filter it can be seen how a bigger sigma allows
%a more even distribution of gray colors. This is because the bigger the
%sigma the most similar the surrounding pixels will become. Also
%as the filter grows bigger a bigger piece of the distribution is used
%so the image looks increasingly smoother

input('Press enter to show Original vs Matlab Smoothed image vs Manual By-channel smoothing ')
rgbfiltered = imfilter(image,sigma810);
figure('name','Original vs Matlab Smoothed image vs Manual By-channel smoothing'),
subplot(2,2,1),imshow(image), title('Original image image');
subplot(2,2,2),imshow(rgbfiltered), title('Image smoothed by gaussian 10x10 o=8 (Matlab)');

smooth_chr = imfilter(image(:,:,1),sigma810);
smooth_chg = imfilter(image(:,:,2),sigma810);
smooth_chb = imfilter(image(:,:,3),sigma810);
smooth_rgb_manual = cat(3,smooth_chr,smooth_chg,smooth_chb);
subplot(2,2,3),imshow(smooth_rgb_manual), title('Image By-Channel Smoothing');

%Can you apply the filter on the rgb image? 
%What type should be the image before convolving and why?
%Matlab allows to apply the filter to the rgb image. However being a
%tridimensional matrix the filter has to be applied to each channel
%individually and then merged into a single image. 

%What dimensions should be the mask? What is the difference using the 
%following three masks:a) [11111],[1;1;1;1;1] and
%[[11111];[11111];[11111];[1 1 1 1 1]; [1 1 1 1 1]]? 
%Do we need to normalize the mask (divide by the sum of all its numbers)? 
%Apply several times in order to observe effect.

h = [1,1,1,1,1];
horizontal_smooth = imfilter(image(:,:,1),h);
horizontal_smooth2 = imfilter(horizontal_smooth,h);
horizontal_smooth3 = imfilter(horizontal_smooth2,h);
horizontal_smooth_averaged = imfilter(image(:,:,1),h/5);

h = [1;1;1;1;1];
vertical_smooth = imfilter(image(:,:,1),h);
vertical_smooth2 = imfilter(vertical_smooth,h);
vertical_smooth3 = imfilter(vertical_smooth2,h);
vertical_smooth_averaged = imfilter(image(:,:,1),h/5);

h = ones(5,5);
square_smooth_not_averaged = imfilter(image(:,:,1),h);
square_smooth_not_averaged2 = imfilter(square_smooth_not_averaged,h);
square_smooth_not_averaged3 = imfilter(square_smooth_not_averaged2,h);
square_smooth_averaged = imfilter(image(:,:,1),h/25);

input('Press enter to show three averaged smoothings')
figure('name','Horizontal, Vertical and Square Smoothing. Averaged'),
subplot(2,2,1),imshow(horizontal_smooth_averaged), title('Horizontal Smooth');
subplot(2,2,2),imshow(vertical_smooth_averaged), title('Vertical Smooth');
subplot(2,2,3),imshow(square_smooth_averaged), title('5x5 Box Smooth');

input('Press enter to show three not averaged smoothings')
figure('name','Horizontal, Vertical and Square Smoothing. Not averaged'),
subplot(2,2,1),imshow(horizontal_smooth), title('Horizontal Smooth (Not averaged) Once');
subplot(2,2,2),imshow(vertical_smooth), title('Vertical Smooth (Not averaged) Once');
subplot(2,2,3),imshow(square_smooth_not_averaged), title('5x5 Box Smooth (Not averaged) Once');

input('Press enter to show three not averaged smoothings applied several times')
figure('name','Horizontal, Vertical and Square Smoothing. Not averaged. Applied 3 times'),
subplot(2,2,1),imshow(horizontal_smooth3), title('Horizontal Smooth (Not averaged) Thrice');
subplot(2,2,2),imshow(vertical_smooth3), title('Vertical Smooth (Not averaged) Thrice');
subplot(2,2,3),imshow(square_smooth_not_averaged3), title('5x5 Box Smooth (not averaged) Thrice');


% The first filter shows an horizontal smoothing, the second one a 
% vertical smoothing and the last one a uniform box smoothing.
% 
% If the mask is not normalized, pixels start to increase without bound
% causing the image to turn whiter every time (pixels tend to 255) and 
% loosing information. When averaged proportions are maintained and 
% the features can be obtained.

input('Press enter to show two median filters smoothed images')
median_33 = medfilt2(image(:,:,1),[3 3]);
median_88 = medfilt2(image(:,:,1),[8 8]);
median_1212 = medfilt2(image(:,:,1),[12 12]);
figure('name','image smoothed by median filter 3x3, 8x8 and 12x12'),
subplot(2,2,1),imshow(image(:,:,1)), title('Original');
subplot(2,2,2),imshow(median_33), title('Median 3x3');
subplot(2,2,3),imshow(median_88), title('Median 8x8');
subplot(2,2,4),imshow(median_1212), title('Median 12x12');

input('Press enter to show the histograms of a median different median filters applied and the original')
figure('name','image Histogram'), imhist(image(:,:,1))
figure('name','image Filtered with Median 3x3 histogram'), imhist(median_33),title('Histogram: Image Filtered with Median 3x3');
figure('name','image Filtered with Median 8x8 histogram'), imhist(median_88),title('Histogram: Image Filtered with Median 8x8');
figure('name','image Filtered with Median 12x12 histogram'), imhist(median_1212),title('Histogram: Image Filtered with Median 12x12');
% 
% It can be seen that median filter removes spikes in the image reducing
% the sharp differences and obtaining a smoother image. While increasing
% median filter size gray colors start distributing more evenly, and 
% start increasing particularly at the center of the 0-255 scale. This
% corresponds a tendency to group colors toward the mean of the scale.
% An ideal mean filter will be the one that removes spikes without 
% impacting heavily the gray colors distribution or blurring too much 
% specifc features.
% For this example the 3x3 works properly.





