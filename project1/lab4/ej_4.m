%% ej_4.m
%
% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
clc

disp('testing k means with animales.jpg');
animales = imread('docs/images/animales.jpg');
kanim = testKMeans(animales);
imshow(kanim);
input('press enter to continue...');

disp('testing mean shift with animales.jpg');
manim = testMeanShift(animales);
imshow(manim);
input('press enter to continue...');

disp('testing mean shift with bigbangfamily.jpg');
bigbang = imread('docs/images/bigbangfamily.jpg');
mbig = testMeanShift(bigbang);
imshow(mbig);
input('press enter to continue...');

disp('testing mean shift with alwin2.jpg');
alwin = imread('docs/images/alwin2.jpg');
malw = testMeanShift(bigbang);
imshow(malw);
input('press enter to continue...');

