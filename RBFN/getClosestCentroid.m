function [members ] = getClosestCentroid(Data,Centroids )
%getClosestCentroid uses the Euclidean distance to find the closest
%centroid to each data point/feature
%
% Input:
%   Data: A matrix of data
%   Centroids: A matrix of all the centroids
% Output:
%   members: A vectors specifying which centorid each sample of data is
%   closest to
%
% Author: Aaron Pulver 12/4/13 (Modified from Chris McCormick 8/15/13)

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
