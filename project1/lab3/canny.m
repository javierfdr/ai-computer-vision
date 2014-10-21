function [edge_image] = canny(image,sigma, min_thres, max_thres)
    thres = [min_thres,max_thres];
    rcanny = uint8(edge(image(:,:,1),'canny',thres,sigma))*255;
    gcanny = uint8(edge(image(:,:,2),'canny',thres,sigma))*255;
    bcanny = uint8(edge(image(:,:,3),'canny',thres,sigma))*255;
    edge_image = cat(3,rcanny,gcanny,bcanny);
end