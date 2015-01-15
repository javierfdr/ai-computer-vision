% @authors: Alejandro Hernandez, Javier Fernandez
% @subject: Computer Vision
% @studies: Master in Artificial Intelligence
% Project 3, Part 1: Digit Classification with Support Vector Machines
close all; clear all; clc;
addpath('svmdemo-1.4/svmdemo/');

%% 100 Examples
Cs = [0.01, 0.1, 1, 2, 4]; % asked ones
%Cs = [1e-4, 1e-5, 1e-6, 1e-7, 1e-8]; % good range if not standarized.
% Training SVMs
[models,Xtrain] = trainSvms('linear',100,Cs);

% Saving Models
% save('SVMXtrain_100.mat','Xtrain');
% save('SVMmodels_100.mat','models');

% Loading Models
% load('SVMXtrain_100.mat');
% load('SVMmodels_100.mat');

% Testing SVMs
[accMatrix,confMatrix,confTable] = testSvms('linear',100,models,Xtrain,Cs);

[~, bestcidx] = max(sum(accMatrix),[],2)
bestC = Cs(bestcidx);
bestAccs = accMatrix(:,bestcidx)
bestConfMatrix = confMatrix(:,:,bestcidx)
bestConfTable = confTable(:,:,bestcidx)

%% 500 Examples
% Training SVMs
[models,Xtrain] = trainSvms('linear',500,Cs);

% Saving Models
% save('SVMXtrain_500.mat','Xtrain');
% save('SVMmodels_500.mat','models');

% Loading Models
% load('SVMXtrain_500.mat');
% load('SVMmodels_500.mat');

% Testing SVMs
[accMatrix,confMatrix,confTable] = testSvms('linear',500,models,Xtrain,Cs);
%%
[~, bestcidx] = max(sum(accMatrix),[],2)
bestC = Cs(bestcidx)
bestAccs = accMatrix(:,bestcidx)
bestConfMatrix = confMatrix(:,:,bestcidx)
bestConfTable = confTable(:,:,bestcidx)

%% 100 Examples and RBF
%Cs = [1, 2, 4, 8, 16]; % good range if not standarized.
%Gammas = [1e-6, 1e-7, 1e-8]; % good range if not standarized.
Cs = [0.01, 0.1, 1, 2, 4];
Gammas = [1e-2, 1e-3, 1e-4];

% Training SVMs
[models,Xtrain] = trainSvms('rbf',100,Cs,Gammas);

% Saving Models
% save('SVMXtrain_100_rbf.mat','Xtrain');
% save('SVMmodels_100_rbf.mat','models');

% Loading Models
% load('SVMXtrain_100_rbf.mat');
% load('SVMmodels_100_rbf.mat');

% Testing SVMs
[accMatrix,confMatrix,confTable] = testSvms('rbf',100,models,Xtrain,Cs,Gammas);

[accsbyc, bestcidx] = max(sum(accMatrix),[],2);
[~, bestgidx] = max(accsbyc,[],3)
bestcidx = bestcidx(:,:,bestgidx)
bestC = Cs(bestcidx)
bestGamma = Gammas(bestgidx)
bestAccs = accMatrix(:,bestcidx,bestgidx)
bestConfMatrix = confMatrix(:,:,bestcidx,bestgidx)
bestConfTable = confTable(:,:,bestcidx,bestgidx)
