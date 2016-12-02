function g_plot (c, xx, k)
    data = xlsread ('data.xlsx');

    b = zeros (160, 3);
    if xx == 1
        c = zeros (160, 1);
    end
    cc = zeros (160, 1);
    for i = 1:160
        b(i, 1) = data (i, 1 + k);
        b(i, 2) = data (i, 2 + k) - data (i, 1 + k);
        b(i, 3) = 1000 - data (i, 2 + k);
       if xx == 1
        c(i) = data (i, 3 + k);
       end
       cc(i) = data (i, 3 + k);
    end

    z = bar (b, 'stacked');
    set (z(1), {'FaceColor'}, {'w'});
    set (z(1), {'EdgeColor'}, {'w'});
    set (z(2), {'FaceColor'}, {'g'});
    set (z(3), {'FaceColor'}, {'w'});
    set (z(3), {'EdgeColor'}, {'w'});
    hold on;
    
    %xlabel (' Contrast, Correlation, Energy, Homogeneity at 1, 2, 3, 4 and 5 distance and at 0, 45, 90, 135 degrees');
    ylabel ('Bandwidth');
    ylim([0 1000]);
    xlim([0 160]);
    p = plot (cc, 'r');
    p = plot (c, 'k');
    hold off;