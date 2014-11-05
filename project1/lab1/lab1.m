%% lab1.m
%
% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
clc

% 1) Open the image friends.jpg and display it.
disp('1) Open the image friends.jpg and display it.');
imgfile = "friends.jpg";
fprintf('reading %s\n', imgfile);
i = imread(imgfile);
imshow(i);
input('Press Enter to continue');

% 2) Find the minimal and maximal gray value of its pixels.
disp('2) Find the minimal and maximal gray value of its pixels.');
maxv = max(max(i));
minv = min(min(i));
fprintf('maximal value %d minimal value %d\n', maxv, minv);
input('Press Enter to continue');

% 3) Manipulate the image so that the minimum value is 0. Display it.
disp('3) Manipulate the image so that the minimum value is 0. Display it.');
i = i - minv;
imshow(i);
input('Press Enter to continue');

% 4) Manipulate the image in order to maximize its contrast (Figure 3 (c)) that is the minimum value to be 0 and the maximum to be 255.
disp('4) Manipulate the image in order to maximize its contrast.');
i = i * ( 255 / (maxv - minv));
maxv = max(max(i));
minv = min(min(i));
fprintf('New maximal value %d minimal value %d\n', maxv, minv);
imshow(i);
