function lb = g_kmeans (IG, k, xx)
    gray = IG;
    gray = double(gray);
    array = gray(:); 
    i = 0;j = 0;
    if xx == 1
    h = waitbar(0, '0 percentage done', 'Name', 'Loading Image',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''cancelling'',1)');
    setappdata(h,'canceling', 0);
    end
    %procedure of k-means clustering
    while (true)
        if xx == 1
        if getappdata(h,'cancelling')
            break;
        end
        end
        
        seed = mean(array); % Initialize seed Point
        i = i + 1; % increment counter
        while (true)
            j = j + 1; % Initialize counter
            dist = (sqrt((array-seed).^2)); %find dist between seed and gray value
            distth = (sqrt(sum((array-seed).^2)/numel(array))); %find bandwidth for cluster
            qualified = dist < distth; %check values are in selected bandwidth or not
            newseed = mean (array(qualified)); %update mean

            if isnan (newseed) %check mean is not a NaN value
                break;
            end

            if seed == newseed || j > 10 % condition for convergence and maximum iteration
                j = 0;
                array (qualified) = []; %remove values hich have assigned to cluster
                center (i) = newseed; % store center of cluster
                break;
            end
            seed = newseed; %update seed
        end
        if xx == 1
        x = i / (k + 1);
        waitbar(x, h, sprintf('%f percentage done', x * 100));
        end
        if isempty (array) || i > k %check number of clusters.
            i = 0; %reset counter
            break;
        end
    end
    
    center = sort(center);
    newcenter = diff(center); %diff between to consecutive center
    intercluster = (max(gray(:) / 10)); %findout min dist between two clusters
    if k == 4
        center(newcenter<=intercluster) = []; %discard cluster center less than distance
    end
    %make cluster image using these centers

    vector = repmat(gray(:), [1, numel(center)]); %replicate vector for parallel operationn
    centers = repmat(center, [numel(gray),1]);

    distance = ((vector-centers).^2); %find dist between center and pixel value
    [~,lb] = min(distance,[],2); % choose cluster index of minimum distance.
    lb = reshape(lb,size(gray)); % reshape the labelled index vector.
    % lb is the final clustered output
    if xx == 1
    waitbar(1, h, '100 percentage done');
    
    delete (h);
    end