function g_correct ()
    tic
     h = waitbar(0, '0 percentage done', 'Name', 'Manipulating Image',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''cancelling'',1)');
    setappdata(h,'canceling', 0);
    A = xlsread ('C:\Users\Pihu\Desktop\breast_cancr\result\features.xlsx');
    b = xlsread ('data.xlsx');
    c = xlsread ('C:\Users\Pihu\Desktop\breast_cancr\result\class.xlsx');
    jkkjj = zeros (322, 3);
    kulla = 0;
    for j = 1:100
        result = 5;
        sum1 = 0;
        sum2 = 0;
        sum3 = 0;
        x1 = zeros (160, 1);
        x2 = zeros (160, 1);
        x3 = zeros (160, 1);
        t1 = 0;
        t2 = 0;
        t3 = 0;
        
        for i = 1:160
            t1 = t1 + 1;
            t2 = t2 + 1;
            t3 = t3 + 1;
            A(j, i + 2) = A(j, i + 2) * 1000;         
            if A(j, i + 2) > b(i, 3)
                x1(i) = (A(j, i + 2) - b(i, 3)) / (b(i, 2) - b(i, 3));
            elseif A(j, i + 2) < b(i, 3)
                x1(i) = (b(i, 3) - A(j, i + 2)) / (b(i, 3) - b(i, 1));
            end
            if A(j, i + 2) > b(i, 2) || A(j, i + 2) < b(i, 1)
                x1(i) = 0;
                t1 = t1 - 1;
            end

            if A(j, i + 2) > b(i, 6)
                x2(i) = (A(j, i + 2) - b(i, 6)) / (b(i, 5) - b(i, 6));
            elseif A(j, i + 2) < b(i, 6)
                x2(i) = (b(i, 6) - A(j, i + 2)) / (b(i, 6) - b(i, 4));
            end
            if A(j, i + 2) > b(i, 5) || A(j, i + 2) < b(i, 4)
                x2(i) = 0;
                t2 = t2 - 1;
            end

            if A(j, i + 2) > b(i, 9)
                x3(i) = (A(j, i + 2) - b(i, 9)) / (b(i, 8) - b(i, 9));
            elseif A(j, i + 2) < b(i, 9)
                x3(i) = (b(i, 9) - A(j, i + 2)) / (b(i, 9) - b(i, 7));
            end
            if A(j, i + 2) > b(i, 8) || A(j, i + 2) < b(i, 7)
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
            elseif sum2 == sum3
                result = 6;
            end
        end
        if result == 0
            result
            break;
        end
        jkkjj (j , 1) = j;
        jkkjj (j, 2) = result;
        jkkjj (j, 3) = c(j, 1);
        jkkjj (j, 4) = c(j, 2);
        
        if result == c(j, 1)
            kulla = kulla + 1;
        end
        x = j / 100;
        waitbar(x, h, sprintf('%f percentage done', x * 100));
        
    end
    delete (h);
    xlswrite ('C:\Users\Pihu\Desktop\breast_cancr\result\a_result.xlsx', jkkjj);
    kulla = kulla / 100;
    kulla = kulla * 100;
    kulla = num2str(kulla);
    w = toc;
    w = strcat(kulla, ' precentage correctness. ', 'Time elapsed : ', num2str (w));
    h = msgbox(w);