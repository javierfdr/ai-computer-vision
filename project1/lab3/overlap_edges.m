function [overlapped] = overlap_edges(edges, image, enhancer)
    edges = uint8(edges)*enhancer;
    overlapped = image-edges;
    
end