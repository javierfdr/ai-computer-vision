% Computational Vision
% 2014-2015
% Student name: ...
%
% >> OBJECTIVE:
% 1) Analize the code
% 2) Understand the function of each part of the code
% 3) Code the missing parts
% 4) Execute the code and check the results

% main
function FD_ex3()

clc; close all;

%% Initialization
load MOVIE.mat;
gt = load('GROUND_TRUTH.mat');
auto = load('AUTO_FACES.mat');

real_faces_video = gt.FACES;    % cell array of real faces in the video
AUTO_FACES = auto.AUTO_FACES;   % cell array of detected faces in the video

% initialize the vector for storing the detection rate for each frame
detection_rate = [];

%% Detection over a video sequence (100 frames)

% iterate over the sequence
for f = 1:size(Vmovie,3)
    
    % Face Detection: defines auto_faces
    % THE FOLLOWING CODE CAN BE USED ONLY WITH MATLAB VERSIONS OLDER THAN 2011!
    % auto_faces = FaceDetect('haarcascade_frontalface_alt2.xml',double(imresize(Vmovie(:,:,f),2))); % face detection of resized image
    % auto_faces = auto_faces./2; % go back to original size!
    
    % load coordinates of faces previously detected (in Matlab 2007) by using
    % FaceDetect() of Viola & Jones
    %
    % >> code here <<
    %
    % auto_faces = ...
    
    % real faces taken by the ground truth as content of the cell array
    %
    % >> code here <<
    %
    % real_faces = ...
    
    % visualize the current frame
    figure(1);
    imshow(Vmovie(:,:,f));
    title(['frame ',num2str(f),'/100']);
    
    % add text to the figure
    text(10,7,'real faces','color','c');
    text(80,7,'detected faces','color','g');
    
    % iterate over the number of faces of the automatic detection
    for i = 1:size(auto_faces,1)
        
        % consider the i-th face
        %
        % >> code here <<
        %
        % Face = ...

        % create a rectangle to be visualized in the image...
        Rectangle = [Face(1) Face(2); Face(1)+Face(3) Face(2); Face(1)+Face(3) Face(2)+Face(4); Face(1)  Face(2)+Face(4); Face(1) Face(2)];

        % ...and visualize it
        hold on;
        plot (Rectangle(:,1), Rectangle(:,2), 'g');
        hold off;
    end
          
    % iterate over the number of faces of the ground truth
    for i = 1:size(real_faces,1)
        
        % consider the i-th face
        %
        % >> code here <<
        %
        % Face = ...

        % create a rectangle to be visualized in the image...
        Rectangle = [Face(1) Face(2); Face(1)+Face(3) Face(2); Face(1)+Face(3) Face(2)+Face(4); Face(1)  Face(2)+Face(4); Face(1) Face(2)];

        % ...and visualize it
        hold on;
        plot (Rectangle(:,1), Rectangle(:,2), 'c');
        hold off;
    end
        
%%  CHECK FOR TRUE POSITIVES VALUE
    
    % initialize true positive value
    %
    % >> code here <<
    %
    % TP = ...
    
    % iterate over the number of faces detected autmatically
    for i = 1:size(auto_faces)

        % consider the i-th auto_face
        %
        % >> code here <<
        %
        % auto_face = ...
    
        % initialize the binary value for the face detection
        %
        % >> code here <<
        %
        % face_found = ...
    
        % intialize the counter
        j = 1;
    
        % iterate over the real faces (over the ground truth)
        while((j <= size(real_faces,1))&(face_found==false))
            
            % check the presence of a real face in the ground truth
            %
            % >> code here <<
            %
            % face_found = checkFace(...);

            % if the face is found in the ground truth, it is a TRUE POSITIVE!
            if face_found
                %
                % >> code here <<
                %
            end

            % increase the counter
            j = j + 1;
        end

    end

%%  CHECK FOR FALSE NEGATIVES VALUE
    
    % initialize true positive value
    %
    % >> code here <<
    %
    % FN = ...
    
    for i = 1:size(real_faces)

        % consider the i-th real_face
        %
        % >> code here <<
        %
        % real_face = ...
    
        % initialize the binary value for the face detection
        %
        % >> code here <<
        %
        % face_found = ...
    
        % intialize the counter
        j = 1;
    
        % iterate over the real faces (over the ground truth)
        while((j <= size(auto_faces,1))&(face_found==false))
            
            % check the presence of a real face in the ground truth
            %
            % >> code here <<
            %
            % face_found = checkFace(...);

            % increase the counter
            j = j + 1;
        end
        
         % if the face is not found in the set of the detected, it is a FALSE NEGATIVE!
        if(face_found==false)
            %
            % >> code here <<
            %
        end
    end
    
    % show the values in the current frame
    text(10,50,['TP = ',num2str(TP),''],'color','y');
    text(10,70,['FN = ',num2str(FN),''],'color','y');
    drawnow
    
    % compute the detection rate
    if (TP+FN)>0
        
        %
        % >> code here <<
        %
        % DR = ...
        
    else
        DR = 0;
    end
    
    % cumulate the DR value in the vector
    detection_rate = [detection_rate DR];

    pause(0.1);
    
end
    
% average over all the DR values
%
% >> code here <<
%
% mDR = ...

% SOLUTION
mDR = mean(detection_rate)

% plot the detection_rate
figure(2)
plot(1:100,100*detection_rate);
xlabel('frame');
ylabel('detection rate [%]')
title('Detection Rate trend over the video');


%% checkFace function: YOU DON'T HAVE TO CODE ANYTHING HERE!!!
function y = checkFace(rect1,rect2)
% Check the overlapping of two rectangluar regions (rect1 and rect2)
% If the overlap is more than 50%, y = true, otherwise, y = false
%
% >> rect = [x,y,w,h];
% x = x-coordinate of the top-left corner
% y = y-coordinate of the top-left corner
% w = width of the rectangle
% h = hieght of the rectangle

x1 = rect1(1); y1 = rect1(2); w1 = rect1(3); h1 = rect1(4);
x2 = rect2(1); y2 = rect2(2); w2 = rect2(3); h2 = rect2(4);

% find the coordinates of the extremes of the bounding box
xStart = min(x1,x2);
yStart = min(y1,y2);
xStop = max((x1+w1),(x2+w2));
yStop = max((y1+h1),(y2+h2));

% define bounding box size
bb_width = xStop-xStart+1;
bb_height = yStop-yStart+1;

% update coordinates, translated to the bounding box reference
x1 = x1 - xStart + 1;
y1 = y1 - yStart + 1;
x2 = x2 - xStart + 1;
y2 = y2 - yStart + 1;

% intialize bounding boxes
empty_box1 = zeros(bb_height,bb_width);
empty_box2 = zeros(bb_height,bb_width);

% fill the bounding boxes with 1 values
empty_box1(y1:y1+h1-1,x1:x1+w1-1) = 1;
empty_box2(y2:y2+h2-1,x2:x2+w2-1) = 1;

% area intersection
A = sum(sum(empty_box1 .* empty_box2));
MIN_AREA = min(sum(sum(empty_box1)),sum(sum(empty_box2)));

% check condition
if A >= MIN_AREA/2
    y = true;
else
    y = false;
end















