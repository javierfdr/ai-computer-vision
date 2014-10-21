function [] = ej_21(image_file)

    %a) Read one of the images in the images.rar.
    %Sobel edge detector
    input('Press enter to show Sobel, Prewit and Two Laplacian edge filters applied');
     image = imread(image_file);
    
    figure('name','Four Different Filters');  
    simple_sobel = sobel_edge_detector(image);
    subplot(4,4,1), imshow(simple_sobel,[]), title('Sobel Filter');
    
    overlapped = overlap_edges(simple_sobel,image,10);
    subplot(4,4,2), imshow(overlapped), title('Original over Edge)');    
    
    % Prewit edge detector
    simple_prewit = prewit_edge_detector(image);
    subplot(4,4,3), imshow(simple_prewit,[]), title('Prewit Filter');
    
    overlapped = overlap_edges(simple_prewit,image,10);
    subplot(4,4,4), imshow(overlapped), title('Original over Edges');        
    
    % Laplacian no diagonal
    simple_laplacian = laplacian_no_diagonal(image);
    subplot(4,4,5), imshow(simple_laplacian,[]), title('Laplacian No Diag.');
    
    overlapped = overlap_edges(simple_laplacian,image,10);
    subplot(4,4,6), imshow(overlapped), title('Original over Edges');        
    
    % Laplacian diagonal
    simple_laplacian_diagonal = laplacian_diagonal(image);
    subplot(4,4,7), imshow(simple_laplacian_diagonal,[]), title('Laplacian Diag.');

    overlapped = overlap_edges(simple_laplacian_diagonal,image,10);
    subplot(4,4,8), imshow(overlapped), title('Original over Edges');        
    
    
    input('Press enter to see three different laplacian filters');
    figure('name','Three Different Laplacian Filters')
    ns = [0.5,0.8,1];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 1:3
        h = fspecial('laplacian',ns(n));
        laplacian_matlab = imfilter(image,h);
        subplot(2,2,n+1),imshow(laplacian_matlab), title(strcat('Alpha=',num2str(ns(n))));    
    end
    
    % Laplacian of a gaussian
    input('Press enter to show Laplacian of Gaussian mask=3x3 sigma=3 Edge Detector over the image');  
    figure('name','Four different Laplacian of Gaussian edge detectors')
    ns = [[3,0.5];[3,0.8];[5,1];[8,1.3]];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 2:4
        log = laplacian_gaussian(image, ns(n,1),ns(n,2));
        subplot(2,2,n),imshow(log), title(strcat('Filt=',num2str(ns(n,1)),' Sigma=',num2str(ns(n,2))));    
    end
    

    input('Press enter to see the best  Laplacian of a gaussian sigma=0.8 filter:3x3 over the image');
    log = laplacian_gaussian(image, 3,0.8);
    overlapped = overlap_edges(log,image,10);
    figure('name','');
    subplot(1,2,1), imshow(image),title('Original');
    subplot(1,2,2), imshow(overlapped), title('Original over Edges (Laplacian)');    
    
    
    %Canny Edge Detector
    input('Press enter to Canny Edge Detector');  
    figure('name','Four different for Canny edge detectors results')
   
    st = [[0.5,0.2,0.4];[0.5,0.2,0.8];[0.8,0.2,0.4];[0.8,0.2,0.8]];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 2:4
        canny_image = canny(image, st(n,1),st(n,2),st(n,3));
        subplot(2,2,n),imshow(canny_image), title(strcat('Sigma=',num2str(st(n,1)),'Thres=',num2str(st(n,2)),',',num2str(st(n,3))));   
    end
    
    % Canny Edge Detector
    input('Press enter to Canny Edge Detector');  
    figure('name','Four different for Canny edge detectors results')
   
    st = [[1,0.2,0.4];[1,0.2,0.8];[1.3,0.2,0.4];[1.3,0.2,0.8]];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 2:4
        canny_image = canny(image, st(n,1),st(n,2),st(n,3));
        subplot(2,2,n),imshow(canny_image), title(strcat('Sigma=',num2str(st(n,1)),'Thres=',num2str(st(n,2)),',',num2str(st(n,3))));   
    end
        

    input('Press enter to Canny Edge Detector');  
    figure('name','Four different for Canny edge detectors results')
   
    st = [[0.5,0.05,0.95];[0.5,0.05,0.95];[0.8,0.1,0.9];[0.8,0.1,0.9]];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 2:4
        canny_image = canny(image, st(n,1),st(n,2),st(n,3));
        subplot(2,2,n),imshow(canny_image), title(strcat('Sigma=',num2str(st(n,1)),'Thres=',num2str(st(n,2)),',',num2str(st(n,3))));    
    end    

    input('Press enter to see the best Canny (0.8,[0.2,0.4])) over the image');
    edges = canny(image, 0.8,0.2,0.4);
    overlapped_canny = overlap_edges(edges,image,1);
    figure('name','');
    subplot(1,2,1), imshow(image),title('Original');
    subplot(1,2,2), imshow(overlapped_canny), title('Original over Edges (GB) - Canny');
    
end