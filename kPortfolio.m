function [pIndex C sse] = kPortfolio(x,avgN,avgRange)
% Create a kMeans Clustered Portfolio (High Values are Preferential)
    % <a href="matlab:web('http://kpei.me/blog')">Created by Kevin Pei</a>
    % INPUT %
        % x - Data Matrix -> each row should be an asset with its characteristics
        % avgN - Average number of Assets per clustered portfolio Default:
        % 25
        % avgRange - Range of freedom for the avgN Default: 2
    % OUTPUT %
        % pIndex - Vector of index for the cluster with atleast
        % avgN-avgRange Assets
        % C - Mu of the selected centroid renormalized
        % sse - Total Sum of squared cluster errors.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Error checking
if(isnumeric(avgN)==false || avgRange <=0)
    disp('avgN field is inputted wrong Default: 25 used');
    avgN=25;
end
if(isnumeric(avgRange)==false || avgRange <=0)
    disp('avgRange field is inputted wrong Default: 2 used');
    avgRange=2;
end

% Z Normalize X
    mX = mean(x); sX = std(x);
    x = bsxfun(@rdivide,bsxfun(@minus,x,mX),sX);
    
% Use heuristic to determine optimal k=sqrt(n/2)
    K = round(sqrt(size(x,1)/2));
    
    % Check on an average asset basis
    avgCN = NCheck(x,K);

    % Find optimal K within range of avgN
    while(avgCN < avgN-avgRange || avgCN > avgN+avgRange)
        if(avgCN < avgN-avgRange) K=K-1; else K=K+1; end
        avgCN = NCheck(x,K);
    end

    % Using optimal K, Run k-means again
    [idx,fC,sst] = kmeans(x,K,'display','final');
    filt = [];
    for i=1:K
        if(sum(idx==i)>=(avgN-avgRange))
            filt = [filt ; i];
        end
    end
    
    % Optimal Portfolio Selection
    c = fC(filt,:);
    C_m = mean(c,2); % Mean of each centroid that pass the filter
    
    %Get the final Index by 1. finding max in filtered centroids, 2.
    % finding the centroid number and 3. finding the assets belonging to
    % that cluster
    o = (filt(find(C_m==max(C_m))));
    
    %Variable finding
    pIndex = find(idx==o); 
    sse = sum(sst);
    C = fC(o,:).*sX+mX;
    
end

