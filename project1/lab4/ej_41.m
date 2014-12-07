%% ej_41.m
%
% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
clc

disp('testing k means with animales.jpg');
animales = imread('docs/images/animales.jpg');
kanim = testKMeans(animales, false);
imshow(kanim);
input('press enter to continue...');
