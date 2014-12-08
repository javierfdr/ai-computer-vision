% Computational Vision
% 2014-2015
%
% Javier Fern?ndez, Alejandro Hern?ndez
%
% >> OBJECTIVE:
% 1) Analize the code
% 2) Understand the function of each part of the code
% 3) Code the missing parts
% 4) Execute the code and check the results
% 5) Comment the experiments and results in a report

% main function
function FD_ex1()

clc; close all; clear;

%% Initialization
% Define Viola & Jones parameters for the first two feature masks
% SEE THE ATTACHED IMAGE FOR DETAILS!!!
L = 110;                         % mask size [px]
d1 = 20; d2 = 20; d3 = 30; d4 = 10; % distances from the border
w1 = 70; w2 = 30; w3 = 30;        % width of the rectangles
h1 = 15; h2 = 30;                 % height of the rectangles


%% Draw the 2 feature masks (just for visualization purpose)
input('Press enter to visualize the two defined rectangular masks');
m1 = zeros(L,L);
m2 = zeros(L,L);

m1(d1+1:d1+h1,d2+1:d2+w1) = 1;
m1(d1+1+h1:d1+2*h1,d2+1:d2+w1) = 2;
figure('name','First rectangular mask');
imagesc(m1);
title('Rectangluar mask for feature 1');
axis square;
colormap([128 128 128; 0 0 0; 255 255 255]/255);

m2(d3+1:d3+h2,d4+1:d4+w2) = 1;
m2(d3+1:d3+h2,d4+w2+1:d4+w2+w3) = 2;
m2(d3+1:d3+h2,d4+w2+w3+1:d4+2*w2+w3) = 1;
figure('name','Second rectangular mask');
imagesc(m2);
title('Rectangluar mask for feature 2');
axis square;
colormap([128 128 128; 0 0 0; 255 255 255]/255);


%% Load image, compute Integral Image and visualize it

% Load image 'barcelona.jpg' and convert image from rgb to grayscale
I = imread('barcelona.jpg');

input('Press enter to see the integral image for barcelona.jpg');

% Compute the Integral Image
S = cumsum(cumsum(double(I),2));
figure('name','Integral Image for barcelona.jpg');

% computing integral image between 0 and 1
S01 = (S-min(S(:)))/(max(S(:))+min(S(:)));
imagesc(S01);
title('barcelona.jpg integral image');

%% Compute features for regions with faces

input('Press enter to compute the two features values for face regions');

% (X,Y) coordinates of the top-left corner of windows with face
XY_FACE = [242 129; 439 135; 673 102; 879 172; 1123 151; 1279 130; 161 300; 349 526; 659 523; 943 535; 1252 562]; % [x1 y1; x2 y2 .....]

% Initialize the feature matrix for faces
FEAT_FACE = [];

for i = 1:size(XY_FACE,1)
    
    % current top-left corner coordinates
    x = XY_FACE(i,1);
    y = XY_FACE(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));
    
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    
    % cumulate the computed values
    FEAT_FACE = [FEAT_FACE; [F1 F2]];
end

disp('Feature face vector');
disp(FEAT_FACE);

%% Compute features for regions with non-faces
input('Press enter to compute the two features values for non-face regions');

% (X,Y) coordinates of the top-left corner of windows with non-face
XY_NON_FACE = [29 30; 454 409; 685 366; 988 27; 1445 30; 1123 436; 1033 1081; 842 1091; 347 1075; 116 582];

% Initialize the feature matrix for non-faces
FEAT_NON_FACE = [];

for i = 1:size(XY_NON_FACE,1)
    
    % current top-left corner coordinates
    x = XY_NON_FACE(i,1); y = XY_NON_FACE(i,2);
    
    % compute area of regions A and B for the first feature
    % HERE WE USE INTEGRAL IMAGE!
    area_A = S(y+d1+h1,x+d2+w1) - S(y+d1+1,x+d2+w1) - (S(y+d1+h1,x+d2+1) - S(y+d1+1,x+d2+1));
    area_B = S(y+2*h1+d1,x+w1+d2) - S(y+d1+h1+1,x+d2+w1) - (S(y+d1+2*h1,x+d2+1)-S(y+d1+h1+1,x+d2+1));
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    area_C = S(y+d3+h2,x+d4+w2) - S(y+d3+1,x+d4+w2) - (S(y+d3+h2,x+d4+1) - S(y+d3+1,x+d4+1));
    area_D = S(y+d3+h2,x+d4+w2+w3) - S(y+d3+1,x+d4+w2+w3) - (S(y+d3+h2,x+d4+w2+1) - S(y+d3+1,x+d4+w2+1));
    area_E = S(y+d3+h2,x+d4+2*w2+w3) - S(y+d3+1,x+d4+2*w2+w3) - (S(y+d3+h2,x+d4+w2+w3+1) - S(y+d3+1,x+d4+w2+w3+1));
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    
    % cumulate the computed values
    FEAT_NON_FACE = [FEAT_NON_FACE; [F1 F2]];
end
disp('Non-face features');
disp(FEAT_NON_FACE);

% %% Visualize samples in the feature space
input('Press enter to visualize face and non-face features in the feature space');
figure('name','Face and non-face feature space for the different samples')
hold on
scatter(FEAT_FACE(:,1),FEAT_FACE(:,2),'g');
scatter(FEAT_NON_FACE(:,1),FEAT_NON_FACE(:,2),'r');
xlabel('Feature 1');
ylabel('Feature 2');
title('Feature space');


%% Visualize image with used regions
input('Press enter to visualize face and non-face features over the image');
figure('name','Face and non-face for the different samples over the image')
imshow(I);

% patches with faces
for i = 1:size(XY_FACE,1)
    PATCH = [XY_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'g');
    hold off;
end

% patches without faces
for i = 1:size(XY_NON_FACE,1)
    PATCH = [XY_NON_FACE(i,:) L L];
    Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
    hold on;
    plot (Rectangle(:,1), Rectangle(:,2), 'r');
    hold off;
end


%% Part 2:
% Testing madrid.jpg as test image

input('Press enter to test madrid image on classifier');
I = imread('madrid.jpg');

% Madrid manually obtained mask points
x1 = [201;389;695;1015;1190;1218;1032;807;603;431;207;63;59;519;857;1007;1274;1492;1446;371;49;859;]
y1 = [171;231;231;313;209;71;67;83;105;91;63;31;479;716;514;447;493;227;610;894;850;403;]

maskInfo = [L,d1,d2,d3,d4,w1,w2,w3,h1,h2];
trainAndClassify(FEAT_FACE,FEAT_NON_FACE,I,x1,y1,maskInfo);


end





