function g_manipulate (xx)

    if xx == 1
     h = waitbar(0, '0 percentage done', 'Name', 'Manuplating features from images',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''cancelling'',1)');
    setappdata(h,'canceling', 0);
    end
    num = xlsread('C:\Users\Pihu\Desktop\breast_cancr\train\features.xlsx');

    z = zeros (160, 9);
    for i = 1:160
        z(i, 1) = 1;
        z(i, 4) = 1;
        z(i, 7) = 1;
    end

    sum_0 = 0;
    sum_1 = 0;
    sum_2 = 0;
    
    for i = 3:162
        if xx == 1
        if getappdata(h,'cancelling')
            break;
        end
        end
        sum_0 = 0;
        sum_1 = 0;
        sum_2 = 0;
        for j = 1:322
            if num (j, 1) == 0
                if isnan (num (j, i)) == 0
                    z (i - 2, 1) = min (z(i - 2, 1), num (j, i));
                    z (i - 2, 2) = max (z(i - 2, 2), num (j, i));
                    z (i - 2, 3) = z(i - 2, 3) + num (j, i);
                    sum_0 = sum_0 + 1;
                end
            elseif num (j, 1) == 1
                if isnan (num (j, i)) == 0
                    z (i - 2, 4) = min (z(i - 2, 4), num (j, i));
                    z (i - 2, 5) = max (z(i - 2, 5), num (j, i));
                    z (i - 2, 6) = z(i - 2, 6) + num (j, i);
                    sum_1 = sum_1 + 1;
                end
            elseif num (j, 1) == 2
                if isnan (num (j, i)) == 0
                    z (i - 2, 7) = min (z(i - 2, 7), num (j, i));
                    z (i - 2, 8) = max (z(i - 2, 8), num (j, i));
                    z (i - 2, 9) = z(i - 2, 9) + num (j, i);
                    sum_2 = sum_2 + 1;
                end
            end
        end
        x = 1000;
        z(i - 2, 1) = z(i - 2, 1) * x;
        z(i - 2, 2) = z(i - 2, 2) * x;
        z(i - 2, 3) = z(i - 2, 3) * x / sum_0;
        z(i - 2, 4) = z(i - 2, 4) * x;
        z(i - 2, 5) = z(i - 2, 5) * x;
        z(i - 2, 6) = z(i - 2, 6) * x / sum_1;
        z(i - 2, 7) = z(i - 2, 7) * x;
        z(i - 2, 8) = z(i - 2, 8) * x;
        z(i - 2, 9) = z(i - 2, 9) * x / sum_2;
        
        x = (i - 2) / 160;
        if xx == 1
        waitbar(x, h, sprintf('%f percentage done', x * 100));
        end
    end
    xlswrite ('data.xlsx', z);
    if xx == 1
    delete (h);
    end