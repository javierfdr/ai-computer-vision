function [edge_image] = sobel_edge_detector(image)
    h = fspecial('sobel');
    edge_image= imfilter(image,h);
end