function [result t1 t2 t3 sum1 sum2 sum3] = g_classify (Ii)    
    A = 1;
    h = waitbar(0, '0 percentage done', 'Name', 'Manipulating Image',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''cancelling'',1)');
    setappdata(h,'canceling', 0);
    for j = 1:5
        x = (j * 20) / 160;
        waitbar(x, h, sprintf('%f percentage done', x * 100));
        [glcms, si] = graycomatrix(Ii,'Offset',[0 j; -j j; -j 0; -j -j; 0 -j; j -j; j 0; j j]);
        stats = graycoprops(glcms);
        A = [A stats.Contrast stats.Correlation stats.Energy stats.Homogeneity];
    end

    for i = 2:161
        A(i) = A(i) * 1000;
    end
    xlswrite ('current.xlsx', A);
    b = xlsread ('data.xlsx');

    sum1 = 0;
    sum2 = 0;
    sum3 = 0;
    x1 = zeros (160, 1);
    x2 = zeros (160, 1);
    x3 = zeros (160, 1);
    t1 = 0;
    t2 = 0;
    t3 = 0;
    j = 160 - 16;
    for i = 1:160
        t1 = t1 + 1;
        t2 = t2 + 1;
        t3 = t3 + 1;
        if mod (i, 10) == 0
            j = j + 1;
        end
        x = j / 160;
        waitbar(x, h, sprintf('%f percentage done', x * 100));
        
        if A(i + 1) > b(i, 3)
            x1(i) = (A(i + 1) - b(i, 3)) / (b(i, 2) - b(i, 3));
        elseif A(i + 1) < b(i, 3)
            x1(i) = (b(i, 3) - A(i + 1)) / (b(i, 3) - b(i, 1));
        end
        if A(i + 1) > b(i, 2) || A(i + 1) < b(i, 1)
            x1(i) = 0;
            t1 = t1 - 1;
        end

        if A(i + 1) > b(i, 6)
            x2(i) = (A(i + 1) - b(i, 6)) / (b(i, 5) - b(i, 6));
        elseif A(i + 1) < b(i, 6)
            x2(i) = (b(i, 6) - A(i + 1)) / (b(i, 6) - b(i, 4));
        end
        if A(i + 1) > b(i, 5) || A(i + 1) < b(i, 4)
            x2(i) = 0;
            t2 = t2 - 1;
        end
        
        if A(i + 1) > b(i, 9)
            x3(i) = (A(i + 1) - b(i, 9)) / (b(i, 8) - b(i, 9));
        elseif A(i + 1) < b(i, 9)
            x3(i) = (b(i, 9) - A(i + 1)) / (b(i, 9) - b(i, 7));
        end
        if A(i + 1) > b(i, 8) || A(i + 1) < b(i, 7)
            x3(i) = 0;
            t3 = t3 - 1;
        end
        
        sum1 = sum1 + x1 (i);
        sum2 = sum2 + x2 (i);
        sum3 = sum3 + x3 (i);
    end
    sum1 = sum1 / t1;
    sum2 = sum2 / t2;
    sum3 = sum3 / t3;
    %{
    if sum1 > sum2 && sum1 > sum3
        result = 0;
    elseif sum2 > sum1 && sum2 > sum3
        result = 1;
    elseif sum3 > sum1 && sum3 > sum2
        result = 2;
    else
        result = 3;
    end
    %}
    sum1 = 1 - sum1;
    sum2 = 1 - sum2;
    sum3 = 1 - sum3;
    %{
    if t1 > t2 && t1 > t3
        result = 0;
    elseif t2 > t1 && t2 > t3
        result = 1;
    elseif t3 > t1 && t3 > t2
        result = 2;
    elseif t1 == t2 && t2 == t3
        if sum1 > sum2 && sum1 > sum3
            result = 0;
        elseif sum2 > sum1 && sum2 > sum3
            result = 1;
        elseif sum3 > sum1 && sum3 > sum2
            result = 2;
        else
            result = 3;
        end
    elseif t1 == t2
        if sum1 > sum2
            result = 0;
        elseif sum2 > sum1
            result = 1;
        end
    elseif t1 == t3
        if sum1 > sum3
            result = 0;
        elseif sum3 > sum1
            result = 2;
        end
    elseif t2 == t3
        if sum2 > sum3
            result = 1;
        elseif sum3 > sum2
            result = 2;
        end
    else
        result = 3;
    end
    %}
        if t2 > t3
            result = 1;
        elseif t3 > t2
            result = 2;
        elseif t3 == t2
            if sum2 > sum3
                result = 1;
            elseif sum3 > sum2
                result = 2;
            end
        end
    delete (h);