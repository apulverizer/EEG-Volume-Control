function [centroids] = getCentroids(Data,members,numCentroids )
%getCentroids gets the new centroids 
% Input:
%   Data: An nxm matrix of the features
%   Members: A nx1 vector of the indecies of the centroids to which the data points belong
%   numCentroids: the number of centroids to have

[a b] = size(Data);
centroids = zeros(numCentroids,b);

for i=1:numCentroids
    % find the mean of the data points which are closeset to the i-th
    % centroid
    dataPoints = Data((members==i),:);
    if(isempty(dataPoints))
        centroids(i,:) = 0;
    else
        centroids(i,:) = mean(dataPoints);
    end
end
centroids(all(centroids==0,2),:)=[]; % remove centroids with all zeros, they are not used
end

