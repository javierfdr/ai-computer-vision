%% ej_43.m
%
% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
clc

disp('testing mean shift with animales.jpg');
manim = testMeanShift(animales, false);
imshow(manim);
input('press enter to continue...');
