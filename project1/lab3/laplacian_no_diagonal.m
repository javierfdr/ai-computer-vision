function [edge_image] = laplacian_no_diagonal(image)
    mask=[[0,1,0];[1,-4,1];[0,1,0]]; 
    edge_image=imfilter(image,mask);
end