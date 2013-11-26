function [Cost, Gradient  ] = getGradient(Weights,Data,Labels)
%% getGradient gets the gradient and cost given the data
% Input:
%   Weights: A matrix of the weights 
%   Data:   A matrix of the features
%   Labels: A vector of the features corresponding labels

% gets the changes for a single iteration of GD

sampleSize = length(Labels);
% estimations
hypothesis = Data * Weights;
% difference
difference = hypothesis - Labels;
Cost = sum(difference .^2);
% avg squared sums
Cost = Cost / (2*sampleSize);

% data points * difference
Gradient = Data'*difference;
Gradient = Gradient /sampleSize;
end

