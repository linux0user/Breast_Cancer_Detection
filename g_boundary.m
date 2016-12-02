function mask = g_boundary (I, k, xx);
    lb = g_kmeans (I, k, xx);
    mask = lb>(max(max(lb))-1);
    