function show_matches_affine_model(Ia, Ib, fa, fb, matches, p)
% Written by L. Garrido, 2012
% Obtained from vl_demo_sift_match

divx = 160;
divy = 80;

offx = divx / 2;
offy = divy / 2;

imshow(cat(2, Ia, Ib),[]);

hold on

A = [1 + p(1), p(2); p(3), 1 + p(4)];
t = [p(5); p(6)];

for i = offx:divx:size(Ia,2),
    for j = offy:divy:size(Ia,1),
        xa = i;
        ya = j;
        
        r = A * [xa; ya] + t;
        
        xb = r(1) + size(Ia,2);
        yb = r(2);
        
        q = line([xa ; xb], [ya ; yb]);
        set(q,'linewidth', 2, 'color', 'r');
        plot([xa; xb], [ya; yb], 'o', 'linewidth', 2, 'color', 'g');
    end
end

hold off
axis([0 size(Ia,2)*2 0 size(Ia,1)])