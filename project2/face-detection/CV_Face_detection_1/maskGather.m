function [x,y] = maskGather(I,L)
    
    figure('name','Mask gatherer');
    imshow(I);
    [x1,y1] = ginput();
    x = round(x1);
    y = round(y1);
    
    s = 'x=[';
    for i=1:size(x)
        s = strcat(s,num2str(x(i)),';');
    end
    s = strcat(s,']')
    
    s = 'y=[';
    for i=1:size(y)
        s = strcat(s,num2str(y(i)),';');
    end
    s = strcat(s,']')
    
    % showing gathered masks
    XY = [x y];
    for i = 1:size(XY,1)
        PATCH = [XY(i,:) L L];
        Rectangle = [PATCH(1) PATCH(2); PATCH(1)+PATCH(3) PATCH(2); PATCH(1)+PATCH(3) PATCH(2)+PATCH(4); PATCH(1)  PATCH(2)+PATCH(4); PATCH(1) PATCH(2)];
        hold on;
        plot (Rectangle(:,1), Rectangle(:,2), 'b');
    end

end