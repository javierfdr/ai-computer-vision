function [edge_image] = laplacian_diagonal(image)
    mask=[[1,4,1];[4,-20,4];[1,4,1]]; 
    edge_image=imfilter(image,mask);
end