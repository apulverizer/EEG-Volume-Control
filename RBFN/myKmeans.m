function [centroids, members ] = myKmeans(Data,Centroids, Iterations )
%myKmeans A k-means clustering algorithm to find the centroids of the given
%data and to return a vector of indexes which refer to which centroid the
%data points belong

% get the number of centroids to be used
numCentroids=size(Centroids,1);
centroids=Centroids;
oldCentroids=Centroids;

for i=1:Iterations
    % get the closest centroid to each data point
    members=getClosestCentroid(Data,Centroids);
    % re-average data points to fine the new centroids
    centroids=getCentroids(Data,members,numCentroids);
    % if no update, then quit 
    if(size(oldCentroids) == size(centroids))
        if(oldCentroids==centroids)
            break;
        end
    end
    oldCentroids=centroids;
end

