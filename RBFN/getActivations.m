function [ activations ] = getActivations(Data,Centers,Beta )
%% getActivations gets how activated each neuron is for the specified data point
% Input:
%   Data: A single data vector
%   Centers: A matrix of the Centroids
%   Beta: The corresponding Beta values for each centroid

distance = zeros(size(Centers));
% get the difference from each center to the Data point
for i=1:size(Centers,1)
    distance(i,:)=Centers(i,:)-Data;
end
% distance funciton
distance = sum(distance .^2,2);
% equation
activations = exp(-Beta .* distance);
activations(isnan(activations))=0;
end

