function I = g_load (filename)
    Ii = imread (filename);
    Ii = imresize (Ii, [1024, 1024]);

    if size (Ii, 3) == 3
       I = rgb2gray (Ii);
    else
        I = Ii;
    end