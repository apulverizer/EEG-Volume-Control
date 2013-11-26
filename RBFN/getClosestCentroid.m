function [members ] = getClosestCentroid(Data,Centroids )
%getClosestCentroid uses the Euclidean distance to find the closest
%centroid to each data point/feature

% get the number of centroids
numCentroids=size(Centroids,1);

distances =zeros(size(Data,1),numCentroids);

for i=1:numCentroids
    distance = zeros(size(Data));
    % get difference from current centroid to each data point
    for j=1:size(Data,1)
        distance(j,:)=Data(j,:)-Centroids(i,:);
    end
    % square distance
    distance = distance .^2;
    % get the euclidena distance
    distances(:,i) = sqrt(sum(distance,2));
end
% get the closest centroid to each data point and assgin the members
[mins members] = min(distances,[],2);
end
