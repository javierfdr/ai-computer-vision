%% ej_42.m
%
% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
clc

disp('testing k means with animales.jpg');
animales = imread('docs/images/animales.jpg');
kanim = testKMeans(animales, true);
imshow(kanim);
input('press enter to continue...');
