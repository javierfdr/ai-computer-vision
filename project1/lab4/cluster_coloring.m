function [vimage] = cluster_coloring(k, cluster_vector, vimage)
    % plain size of the Image (nxm)
    nm = size(cluster_vector,1);
    k_sums = zeros(k,3);
    k_counts = zeros(k,1);
    
    for p=1:nm
        c = cluster_vector(p);
        k_sums(c,:) = k_sums(c,:) + double(vimage(p,:));
        k_counts(c) = k_counts(c)+1;
    end
    
    for i=1:k
        k_sums(i,:) = k_sums(i,:)./k_counts(i);
    end
    
    for p=1:nm
        c = cluster_vector(p);
        vimage(p,:) = uint8(k_sums(c,:));
    end
end