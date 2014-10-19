% Computer Vision (MAI) - Exercises from Practicum 2
% Javier Fernandez (javierfdr@gmail.com)
% Alejandro Hernandez (alejandro.ajhr@gmail.com)

% 1.3 Managing different size and filters

% a) Read one of the images in the images.rar.
corals = imread('images/corals.jpg');

%b) Show how details of the image disappear when rescale the size of the image (Help: imresize). Does the histogram change of both images (the original and the rescaled one)? Return back the smaller image to the original size. Compare to the original one.

%small_corals = imresize(corals,0.2);
%rescaled_corals = imresize(small_corals,5);

%input('Press enter to show histograms of small and original corals image.');

%figure, imhist(small_corals(:,:,1));
%figure, imhist(corals(:,:,1));

% The histogram of the downsized image shows a less smooth curve where different
% values along the grayscale appear more than in the original image. It is also
% evidenced that there are less pixels in the image due to the count of occurences for
% each bin. So, downsized image has lost information

%input('Press enter to show histograms of original and resized back image of corals');
%figure, imhist(rescaled_corals(:,:,1));
%figure, imhist(corals(:,:,1));

% When rescaling a more continous or smooth curve is obtained. It is also observed
% that intensities are more evenly distributed that in the original image.

% c) As an alternative of removing image details, apply different smoothing 
% filters (by user-defined mask as a vector e.g. [1 1 1] vs. 
% Gaussian filter). 
% Discuss how the size of the filter or mask affect the final outcome.

%input('Press enter to show three smoothed images by using square filters of size 5x5, 8x8, 15x15');
h = ones(5,5)/25;
square_corals55 = imfilter(corals(:,:,1),h);
%figure('name','Smoothing with three different box filters')
%subplot(2,2,1),imshow(square_corals55), title('Box Filter 5x5');

h = ones(8,8)/64;
square_corals88 = imfilter(corals(:,:,1),h);
%subplot(2,2,2), imshow(square_corals88), title('Box Filter 8x8');

h = ones(15,15)/225;
square_corals15 = imfilter(corals(:,:,1),h);
%subplot(2,2,3), imshow(square_corals15), title('Box Filter 15x15');
%figure, 

%figure, imhist(corals(:,:,1));
%figure, imhist(square_corals88(:,:,1));
%figure, imhist(square_corals15(:,:,1));

% It can be observed how increasing the size of the mask increases 
% the smoothing of the image. This is achieved by making nearest 
% pixels to become more similar so generating more continuity in 
% the grayscale. By observing the histograms of the original image
% versus the histograms of the smoothed ones is clear that the usage
% of the grayscale is more evenly distributed

% By box smoothing it is observed the appearance of ringing: horizontal
% and vertical lines

%input('Press enter to show three smoothed images by using gaussian filters of (sigma, mask) as (3, 5x5), (3, 10x10), (8,5x5), (8, 10x10))')
sigma35 = fspecial('gaussian', 5, 3);
coralssigma35 = imfilter(corals(:,:,1),sigma35);
%figure('name','Smoothing with four gaussian filters')
%subplot(2,2,1), imshow(coralssigma35), title('Gaussian Filter: 5x5 o=3');

sigma310 = fspecial('gaussian', 10, 3);
coralssigma310 = imfilter(corals(:,:,1),sigma310);
%subplot(2,2,2), imshow(coralssigma310), title('Gaussian Filter: 10x10 o=3');

sigma85 = fspecial('gaussian', 5, 8);
coralssigma85 = imfilter(corals(:,:,1),sigma85);
%subplot(2,2,3), imshow(coralssigma85),title('Gaussian Filter: 5x5 o=8');

sigma810 = fspecial('gaussian', 10, 8);
coralssigma810 = imfilter(corals(:,:,1),sigma810);
%subplot(2,2,4), imshow(coralssigma810),title('Gaussian Filter: 10x10 o=8');

%input('Press enter to show two histograms of previous gaussian filters')
%input('Press enter to see two histograms from gaussian filters: ')
%figure('name','Histograms of two gaussian filters (10,3) (10,8)'), imhist(coralssigma310), title('Histogram: Gaussian Filter: 10x10 o=3');
%figure('name','Histogram: Gaussian Filter: 10x10 o=8'), imhist(coralssigma810);

% Applying the gaussian filter it can be seen how a bigger sigma allows
% a more even distribution of gray colors. This is because the bigger the
% sigma the most similar the surrounding pixels will become. Also
% as the filter grows bigger a bigger piece of the distribution is used
% so the image looks increasingly smoother

rgbfiltered = imfilter(corals,sigma810);
%figure('name','Original vs Matlab Smoothed Corals image vs Manual By-channel smoothing'),
%subplot(2,2,1),imshow(corals), title('Original corals image');
%subplot(2,2,2),imshow(rgbfiltered), title('Corals smoothed by gaussian 10x10 o=8');

smooth_chr = imfilter(corals(:,:,1),sigma810);
smooth_chg = imfilter(corals(:,:,2),sigma810);
smooth_chb = imfilter(corals(:,:,3),sigma810);
smooth_rgb_manual = cat(3,smooth_chr,smooth_chg,smooth_chb);
%subplot(2,2,3),imshow(smooth_rgb_manual), title('Corals By-Channel Smoothing');

%Can you apply the filter on the rgb image? 
%What type should be the image before convolving and why?
% Matlab allows to apply the filter to the rgb image. However being a
% tridimensional matrix the filter has to be applied to each channel
% individually and then merged into a single image. 

%What dimensions should be the mask? What is the difference using the 
% following three masks:a) [11111],[1;1;1;1;1] and
%[[11111];[11111];[11111];[1 1 1 1 1]; [1 1 1 1 1]]? 
%Do we need to normalize the mask (divide by the sum of all its numbers)? 
%Apply several times in order to observe effect.
h = [11111];
horizontal_smooth = imfilter(corals(:,:,1),h);
h = [1;1;1;1;1];
vertical_smooth = imfilter(corals(:,:,1),h);
h = [[11111];[11111];[11111]];
square_smooth_not_averaged = imfilter(corals(:,:,1),h);






