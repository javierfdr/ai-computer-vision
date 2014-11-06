function [imres] = testKMeans(im)
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

% adding spatial coordinates
im1d = [im1d,xs,ys];

k=7; % cluster in 7 clusters

idx=kmeans(double(im1d),k);

% removing spatial coordinates
im1d = im1d(:,1:3);
% applying cluster coloring by means
im1d = cluster_coloring(k,idx,im1d);
im3d = reshape(im1d,size(im,1),size(im,2),3);

%im2d=reshape(idx, size(im,1),size(im,2));
%im2d=((double(im2d)-min(min(im2d)))/(max(max(im2d))-min(min(im2d)))*255.0);
%im3d=cat(3,im2d,im2d,im2d);

imres=cat(2,im,im3d);
 
end
