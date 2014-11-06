%% ej_43.m
%
% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
clc

disp('testing mean shift with animales.jpg');
manim = testMeanShift(animales, true);
imshow(manim);
input('press enter to continue...');

disp('testing mean shift with bigbangfamily.png');
bigbang = imread('docs/images/bigbangfamily.png');
mbig = testMeanShift(bigbang, true);
imshow(mbig);
input('press enter to continue...');

disp('testing mean shift with alwin2.jpg');
alwin = imread('docs/images/alwin2.jpg');
malw = testMeanShift(bigbang, true);
imshow(malw);
input('press enter to continue...');
