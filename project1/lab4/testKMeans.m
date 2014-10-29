function [imres] = testKMeans(im)
% this is the classical kmeans algorithm
 
im1d=reshape(im, size(im,1)*size(im,2),3);

% Add here the spatial coordinates ?.
n = size(im,1);
m = size(im,2);

xs = zeros(n*m);
ys = zeros(n*m);
for j=1:m
    for i=1:n
        xs(i*j) = i;
        ys(i*j) = j;
    end
end

% adding spatial coordinates
im1d = [im1d,xs,ys];

k=4; % cluster in 4 clusters

idx=kmeans(double(im1d),k);

% removing spatial coordinates
im1d = im1d(:,1:3);
% applying cluster coloring by means
im1d = cluster_coloring(k,idx,im1d);

%im2d=reshape(idx, size(im,1),size(im,2));

%im2d=((double(im2d)-min(min(im2d)))/(max(max(im2d))-min(min(im2d)))*255.0);

im3d = reshape(im1d,size(im,1),size(im,2),3);
imres=cat(2,im,im3d);
 
end
