function [] = trainAndClassifyMultiFeatures(FEAT_FACE,FEAT_NON_FACE, I, x1, y1, maskInfo)
 %% Define the new regions of the test image 

    %Load mask info
    L = maskInfo(1);
    d1 = maskInfo(2);
    d2 = maskInfo(3);
    d3 = maskInfo(4);
    d4 = maskInfo(5);
    d5 = maskInfo(6);
    d6 = maskInfo(7);
    d7 = maskInfo(8);
    d8 = maskInfo(9);
    d9 = maskInfo(10);
    w1 = maskInfo(11);
    w2 = maskInfo(12);
    w3 = maskInfo(13);
    w4 = maskInfo(14);
    w5 = maskInfo(15);
    w6 = maskInfo(16);
    w7 = maskInfo(17);
    h1 = maskInfo(18);
    h2 = maskInfo(19);
    h3 = maskInfo(20);
    h4 = maskInfo(21);
    h5 = maskInfo(22);
    h6 = maskInfo(23);
    h7 = maskInfo(24);
    h8 = maskInfo(25);
   
    
    % Compute the Integral Image
    S = cumsum(cumsum(double(I),2));
    imshow(I);

    % Select regions with FACES and NON-FACES
    %[x1, y1] = ginput()
    

    %(X,Y) coordinates of the top-left corner of windows with face
    XY_TEST = [x1 y1];

    %% Compute features for these new regions

    % Initialize the feature matrix for faces
    FEAT_TEST = [];

    for i = 1:size(XY_TEST,1)

        % current top-left corner coordinates
        x = XY_TEST(i,1);
        y = XY_TEST(i,2);

    area_A = getRectangleArea(S,y,x,d1,d2,h1,w1);
    area_B = getRectangleArea(S,y+h1,x,d1,d2,h1,w1);
    
    % compute area of regions C, D and E for the second feature
    % HERE WE USE INTEGRAL IMAGE!
    
    area_C = getRectangleArea(S,y,x,d3,d4,h2,w2);
    area_D = getRectangleArea(S,y,x+w2,d3,d4,h2,w3);
    area_E = getRectangleArea(S,y,x+w2+w3,d3,d4,h2,w2);
     
    % compute area of regions F, G and H for the third feature
    area_F = getRectangleArea(S,y,x,d5,d5,h3,w4);
    area_G = getRectangleArea(S,y+h3,x,d5,d5,h4,w4);
    area_H = getRectangleArea(S,y+h3+h4,x,d5,d5,h3,w4);
    
    % compute area of regions H, J, K, L for the fourth feature
    area_I = getRectangleArea(S,y,x,d6,d6,h5,w5);
    area_J = getRectangleArea(S,y,x+w5,d6,d6,h5,w5);
    area_K = getRectangleArea(S,y+h5,x,d6,d6,h5,w5);
    area_L = getRectangleArea(S,y+h5,x+w5,d6,d6,h5,w5);
   
    % compute area of regions M, N, O for the fifth feature
    area_M = getRectangleArea(S,y,x,d7,d8,h6,w6);
    area_N = getRectangleArea(S,y+h6,x,d7,d8,h7,w6);
    area_O = getRectangleArea(S,y+h6+h7,x,d7,d8,h6,w6);  
    
    % compute area of regions P, Q for the sixth feature
    area_P = getRectangleArea(S,y,x,d9,d9,h8,w7);
    area_Q = getRectangleArea(S,y,x+w7,d9,d9,h8,w7); 
        
    
    % compute features value
    F1 = area_B - area_A;
    F2 = area_D - (area_C + area_E);
    F3 = area_G - (area_F + area_H);
    F4 = (area_J + area_K) - (area_I + area_L); 
    F5 = area_N - (area_M + area_O);
    F6 = area_Q - area_P;
    
    % cumulate the computed values
    FEAT_TEST = [FEAT_TEST; [F1 F2 F3 F4 F5 F6]];
    end

    FEAT_TRAIN = [FEAT_FACE; FEAT_NON_FACE]% features from barcelona
    group = [repmat(1, length(FEAT_FACE), 1); repmat(0, length(FEAT_NON_FACE), 1)];

    
    %% Visualize samples in the feature space by using two-first principal components;
    
    
    input('Press enter to visualize face and non-face features principal components');

    pca_feat_face = FEAT_TEST(1:12,:)*pca(FEAT_TEST);
    pca_feat_non_face = FEAT_TEST(12:size(FEAT_TEST,1),:)*pca(FEAT_TEST);
    
    figure('name','Face and non-face PCA-feature space for the test')
    hold on
    scatter(pca_feat_face(:,1),pca_feat_face(:,2),'b');
    scatter(pca_feat_non_face(:,1),pca_feat_non_face(:,2),'m');
    xlabel('Feature 1 PCA');
    ylabel('Feature 2 PCA');
    title('Feature space');

    pca_feat_face = FEAT_TRAIN(1:12,:)*pca(FEAT_TRAIN);
    pca_feat_non_face = FEAT_TRAIN(12:size(FEAT_TRAIN,1),:)*pca(FEAT_TRAIN);

    scatter(pca_feat_face(:,1),pca_feat_face(:,2),'g');
    scatter(pca_feat_non_face(:,1),pca_feat_non_face(:,2),'r');

    %% Train a k-nn classifier and test the new windows
    input('Press enter to train a classifier on barcelona.jpg windows');
    % This code is using ClassificationKNN from matlab 2012b. For a newest
    % version fitcknn must be used instead.
    % Call the function knnclassify
    
    % testing the best k possible
    best_class = realmax;   
    model = ClassificationKNN.fit(FEAT_TRAIN,group,'NumNeighbors',4);
    class = model.predict(FEAT_TEST)

    disp('KNN-classifier succesfully trained');
    disp(model);


    %% Visualize classification results in the test image
    % patches with faces
    input('Press enter to visualize classification windows over test image');
    figure('name','madrid.jpg image with overlapping classified results');
    imshow(I);

    % Visualize image 'madrid.jpg' with used regions
    XY_TEST_FACE = XY_TEST(class==1,:);
    XY_TEST_NON_FACE = XY_TEST(class==0,:);

    for i = 1:size(XY_TEST_FACE,1)
        PATCH = [XY_TEST_FACE(i,:) L L];
        Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
        hold on;
        plot (Rectangle(:,1), Rectangle(:,2), 'g');
    end

    for i = 1:size(XY_TEST_NON_FACE,1)
        PATCH = [XY_TEST_NON_FACE(i,:) L L];
        Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
        hold on;
        plot (Rectangle(:,1), Rectangle(:,2), 'r');
    end
end