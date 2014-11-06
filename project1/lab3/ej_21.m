 function [] = ej_21(image_file)

    % This script applies a set of edge detection filters to the given image
    % in order to show the effect of each different technique.
    % Specifically filters being tested are Sobel Mask, Prewitt mask,
    % Laplacian mask (not including diagonals), Laplacian mask including
    % diagonals, Laplacian of a Gaussian smoother and Canny edge detector.

    %a) Read one of the images in the images.rar.
    %Sobel edge detector
    input('Press enter to show Sobel and Prewit filter applied');
     image = imread(image_file);
    
    figure('name','Sobel and Prewit Different Filters');  
    simple_sobel = sobel_edge_detector(image);
    subplot(2,2,1), imshow(simple_sobel,[]), title('Sobel Filter');
    
    overlapped = overlap_edges(simple_sobel,image,10);
    subplot(2,2,2), imshow(overlapped), title('Original over Edge)');    
    
    % Prewit edge detector
    simple_prewit = prewit_edge_detector(image);
    subplot(2,2,3), imshow(simple_prewit,[]), title('Prewit Filter');
    
    overlapped = overlap_edges(simple_prewit,image,10);
    subplot(2,2,4), imshow(overlapped), title('Original over Edges');        
    
    input('Press enter to show Laplacian Diagonal and No Diagonal filter applied');
    figure('name','Laplacian Diagonal and No Diagonal filters'); 
    % Laplacian no diagonal
    simple_laplacian = laplacian_no_diagonal(image);
    subplot(2,2,1), imshow(simple_laplacian,[]), title('Laplacian No Diag.');
    
    overlapped = overlap_edges(simple_laplacian,image,10);
    subplot(2,2,2), imshow(overlapped), title('Original over Edges');        
    
    % Laplacian diagonal
    simple_laplacian_diagonal = laplacian_diagonal(image);
    subplot(2,2,3), imshow(simple_laplacian_diagonal,[]), title('Laplacian Diag.');

    overlapped = overlap_edges(simple_laplacian_diagonal,image,10);
    subplot(2,2,4), imshow(overlapped), title('Original over Edges');        
    
    % Laplacian filters with different alpha values
    input('Press enter to see three different laplacian filters');
    figure('name','Three Different Laplacian Filters')
    ns = [0.5,0.8,1]; % alpha values
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 1:3
        h = fspecial('laplacian',ns(n));
        laplacian_matlab = imfilter(image,h);
        subplot(2,2,n+1),imshow(laplacian_matlab), title(strcat('Alpha=',num2str(ns(n))));    
    end
        
    % Best laplacian over the image
    input('Press enter to see the best  Laplacian over the image');
    h = fspecial('laplacian',0.8);
    laplacian_matlab = imfilter(image,h);
    overlapped = overlap_edges(laplacian_matlab,image,10);
    figure('name','');
    subplot(1,2,1), imshow(image),title('Original');
    subplot(1,2,2), imshow(overlapped), title('Original over Edges (Laplacian alpha=0.8)');    
      
    
    % Laplacian of a gaussian
    input('Press enter to show four different laplacian of a gaussian configurations');  
    figure('name','Four different Laplacian of Gaussian edge detectors')
    ns = [[3,0.5];[3,0.8];[5,1];[8,1.3]];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 2:4
        log = laplacian_gaussian(image, ns(n,1),ns(n,2));
        subplot(2,2,n),imshow(log), title(strcat('Filt=',num2str(ns(n,1)),' Sigma=',num2str(ns(n,2))));    
    end
    
    % Best laplacian of a gaussian
    input('Press enter to see the best  Laplacian of a gaussian sigma=0.8 filter:3x3 over the image');
    log = laplacian_gaussian(image, 3,0.8);
    overlapped = overlap_edges(log,image,10);
    figure('name','');
    subplot(1,2,1), imshow(image),title('Original');
    subplot(1,2,2), imshow(overlapped), title('Original over Edges (Laplacian of Gaussian s=0.8 m=3x3)');    
    
    
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
        
    % Canny Edge Detector
    input('Press enter to Canny Edge Detector');  
    figure('name','Four different for Canny edge detectors results')
   
    st = [[0.5,0.05,0.95];[0.5,0.05,0.95];[0.8,0.1,0.9];[0.8,0.1,0.9]];
    subplot(2,2,1),imshow(image), title('Original'); 
    for n = 2:4
        canny_image = canny(image, st(n,1),st(n,2),st(n,3));
        subplot(2,2,n),imshow(canny_image), title(strcat('Sigma=',num2str(st(n,1)),'Thres=',num2str(st(n,2)),',',num2str(st(n,3))));    
    end    
    % Best canny edge detector
    input('Press enter to see the best Canny (0.8,[0.2,0.4])) over the image');
    edges = canny(image, 0.8,0.2,0.4);
    overlapped_canny = overlap_edges(edges,image,1);
    figure('name','');
    subplot(1,2,1), imshow(image),title('Original');
    subplot(1,2,2), imshow(overlapped_canny), title('Original over Edges (GB) - Canny');
    
     % Laplacian of a gaussian on three images and same configuration
    input('Press enter to show comparison of best Laplacian of a gaussian (for Starbuck) in three fixed images');
    image2 = imread('images/TomJerry.jpg');
    image3 = imread('images/alwin.jpg');
    
    log = laplacian_gaussian(image, 3,0.8);
    log2 = laplacian_gaussian(image2, 3,0.8);
    log3 = laplacian_gaussian(image3, 3,0.8);
    overlapped = overlap_edges(log,image,10);
    overlapped2 = overlap_edges(log2,image2,10);
    overlapped3 = overlap_edges(log3,image3,10);
    figure('name','Comparison of three overlapping');
    subplot(1,3,1), imshow(overlapped),title('Starbuck with Log sigma=3, alpha=0.8');
    subplot(1,3,2), imshow(overlapped2), title('TomJerry with Log sigma=3, alpha=0.8');    
    subplot(1,3,3), imshow(overlapped3), title('Alwin with Log sigma=3, alpha=0.8');   
    
      
     % Canny Edge Detector on three images and same configuration
    input('Press enter to show comparison of best Canny (for Starbuck) of a gaussian in three fixed images');
    image2 = imread('images/TomJerry.jpg');
    image3 = imread('images/alwin.jpg');
    
    edges = canny(image, 0.8,0.2,0.4);
    edges2 = canny(image2, 0.8,0.2,0.4);
    edges3 = canny(image3, 0.8,0.2,0.4);
    figure('name','Comparison of three overlapping');
    subplot(1,3,1), imshow(edges),title('Starbuck with Log sigma=3, alpha=0.8');
    subplot(1,3,2), imshow(edges2), title('TomJerry with Log sigma=3, alpha=0.8');    
    subplot(1,3,3), imshow(edges3), title('Alwin with Log sigma=3, alpha=0.8');  
    
               
end