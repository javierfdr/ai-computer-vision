function show_matches_linear_model(Ia, Ib, fa, fb, matches, p)
% Written by L. Garrido, 2013
% Obtained from vl_demo_sift_match

divx = 160;
divy = 80;

offx = divx / 2;
offy = divy / 2;

imshow(cat(2, Ia, Ib),[]);

hold on

for i = offx:divx:size(Ia,2),
    for j = offy:divy:size(Ia,1),
        xa = i;
        ya = j;
        
        xb = xa + p(1) + size(Ia,2);
        yb = ya + p(2);

        q = line([xa ; xb], [ya ; yb]);
        set(q,'linewidth', 2, 'color', 'r');
        plot([xa; xb], [ya; yb], 'o', 'linewidth', 2, 'color', 'g');
    end
end

hold off
axis([0 size(Ia,2)*2 0 size(Ia,1)])