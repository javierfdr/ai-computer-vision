function [edge_image] = laplacian_gaussian(image,n,sigma)
    h = fspecial('log',[n n],sigma);
    edge_image= imfilter(image,h);
end