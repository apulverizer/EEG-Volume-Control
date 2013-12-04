function [Cost, Gradient  ] = getGradient(Weights,Data,Labels)
%% getGradient gets the gradient and cost given the data
% Input:
%   Weights: A matrix of the weights 
%   Data:   A matrix of the features
%   Labels: A vector of the features corresponding labels
% Ouput:
%   Cost: The cost
%   Gradient: The gradient
%
%   Author: Aaron Pulver 12/4/13 (Modified from Chris McCormick 8/15/13)

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

