function Signature = g_detected_boundary (mask, I, x)

    AdR = regionprops(mask, 'All');
    [B,L,N] = bwboundaries(mask);
    if x == 1
        imshow(I); hold on;
    end
    
    kh = 1;
    for k = 1:length(AdR),
        boundary = B{k};
        if x == 1
            plot(boundary(:,2),...
            boundary(:,1),'b','LineWidth',0.5);
        end
        for sw = 1:length(boundary)
            Signature(kh)=abs(AdR(k).Centroid(1)-boundary(sw,1));
            kh=kh+1;
        end
    end
    hold off;