function [area] = getRectangleArea(S, y,x, dx,dy,h,w)
    
    x1 = S(y+dy+1,x+dx+1);
    x2 = S(y+dy+1,x+dx+w);
    x3 = S(y+dy+h,x+dx+1);
    x4 = S(y+dy+h,x+dx+w);

    area = x4-x2-x3+x1;
end