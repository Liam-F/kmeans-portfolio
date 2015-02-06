function [ avgN ] = NCheck( x,K)
%NCHECK Check for average number of assets in a kMeans index
%   x -> data, K -> Cluster
%   avgN -> Average Number of Assets in the kMeans excluding 1

    % Check on an average asset basis
    [idx] = kmeans(x,K);
    countN = [];
    for i=1:K %Get the asset size of each portfolio in each cluster
        countN = [countN ; sum(idx==i)];
    end
    avgN = mean(countN(find(countN>1))); % Excluding 1 Asset portfolios, Get Avg N of Portfolios
    
end
