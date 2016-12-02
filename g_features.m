function g_features (c, xx)
    if xx == 1
        h = waitbar(0, '0 percentage extracted', 'Name', 'Extracting features from images',...
                'CreateCancelBtn',...
                'setappdata(gcbf,''cancelling'',1)');
        setappdata(h,'canceling', 0);
    end
    files = dir('C:\Users\Pihu\Desktop\breast_cancr\train\mdb*');
    i = 1;
    for file = files'
        if xx == 1
        if getappdata(h,'cancelling')
            break;
        end
        end
        Ii = imread(strcat ('C:\Users\Pihu\Desktop\breast_cancr\train\', file.name));
        Ii = g_boundary (Ii, 4, 0);
        %imshow (Ii);
        x1range = strcat('A', int2str(i), ':FF', int2str(i));
       
        A = [c(i, 1) c(i, 2)];
        for j = 1:5
            [glcms, si] = graycomatrix(Ii,'Offset',[0 j; -j j; -j 0; -j -j; 0 -j; j -j; j 0; j j]);
            stats = graycoprops(glcms);
            A = [A stats.Contrast stats.Correlation stats.Energy stats.Homogeneity];
        end
        xlswrite ('C:\Users\Pihu\Desktop\breast_cancr\train\features.xlsx', A, x1range);
        x = i / 322;
        i = i + 1;
        if xx == 1
        waitbar(x, h, sprintf('%f percentage extracted', x * 100));
        end
    end
    if xx == 1
    delete (h);
    end
    