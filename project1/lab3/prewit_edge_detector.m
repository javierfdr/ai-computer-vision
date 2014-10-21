function [edge_image] = prewit_edge_detector(image)
    h = fspecial('prewit');
    edge_image= imfilter(image,h);
end