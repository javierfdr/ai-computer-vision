function [imres] = testMeanShift(im, spatial)
% this is the classical kmeans algorithm
 
im1d=reshape(im, size(im,1)*size(im,2),3);

% Add here the spatial coordinates ?.
n = size(im,1);
m = size(im,2);

zerouint = uint16(0);

xs(n*m,1) = zerouint;
ys(n*m,1) = zerouint;

for j=1:m
    for i=1:n
        xs(i+((j-1)*n)) = i;
        ys(i+((j-1)*n)) = j;
    end
end

if spatial == true
    % adding spatial coordinates
    im1d = [im1d,xs,ys];
end

tic
[clustCent,point2cluster,clustMembsCell] = MeanShiftCluster(double(im1d'),50);
toc

numClust = length(clustMembsCell);

% removing spatial coordinates
im1d = im1d(:,1:3);
% applying cluster coloring by means
im1d = cluster_coloring(numClust,point2cluster',im1d);
numClust

im3d = reshape(im1d,size(im,1),size(im,2),3);
imres=cat(2,im,im3d);
 
end
