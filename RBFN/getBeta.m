function [ beta ] = getBeta(Data,Centroids,Members, BetaPower )
%getBeta returns the vector of beta coefficients for the centroids
% Input:
%   Data: An nxm matrix of the features
%   Centroids: A matrix of the centroids
%   Members: A vector of which feature set corresponds to which member
% Ouput:
%   beta: A vector of beta values
%
%   Uses the average distance between the centroid and it's points (sigma)
%   beta = 1/(2*sigma^BetaPower) for now at least
%
%   sigma = mean(distance of all particles distance to their closest
%   centroid/layer)
%
%   Author: Aaron Pulver 12/4/13 (Modified from Chris McCormick 8/15/13)

sigma = zeros(size(Centroids,1),1);

for i=1:size(Centroids,1)
    thisCentroid = Centroids(i,:);
    members = Data((Members==i),:);
    distance = zeros(size(members));
    % get the difference from the current Centroid to each member
    for j=1:size(members,1)
        distance(j,:) = members(j,:)-thisCentroid;
    end
    % euclidean distance
    distance = sqrt(sum(distance .^2,2));
    % using the avg right now
    if(isempty(members))
        sigma(i,:)=0;
    else
        sigma(i,:) = mean(distance);
    end
end
% can change this to alter the coefficients
beta = 1 ./(2.*sigma .^BetaPower); %4.5 and 70 for diabetes/breast cancer
% 4 and 1 for bci 2b 1
end

