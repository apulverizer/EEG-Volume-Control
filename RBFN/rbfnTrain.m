function [ model ] = rbfnTrain(Labels,Data,HiddenLayers, BetaPower,class1Label,class2Label)
%% rbfnTrain Trains the Radial Basis Function Network
% Input:
%   Labels: an (Nx1) vector of the class labels
%   Data: an NxM matrix of the features
%   HiddenLayers: The number of RBF to use
%   BetaPower: Power used to calculate the beta coefficients
%   class1Label: The label for class 1
%   class2Label: The label for class 2
%
% Output:
%   Model: The model structure to be used later when predicting results
%   Author: Aaron Pulver 12/4/13 (Modified from Chris McCormick 8/15/13)

% for breast cancer data
% can be modified later for more 

Data1 = Data((Labels==class1Label),:);
Data2 = Data((Labels==class2Label),:);

% pick first <HiddenLayers> as the centroids for each class
if(HiddenLayers>size(Data1,1))
    HiddenLayers1=size(Data1,1);
    warning('Hidden layers 1 exceeds data; reduced to %d', HiddenLayers1);
else
    HiddenLayers1=HiddenLayers;
end
if(HiddenLayers>size(Data2,1))
    HiddenLayers2=size(Data2,1);
    warning('Hidden layers 2 exceeds data; reduced to %d', HiddenLayers2);
else
    HiddenLayers2=HiddenLayers;
end

Centroids1 = Data1(1:HiddenLayers1,:);
Centroids2 = Data2(1:HiddenLayers2,:);

% do k-means on them to get the best centroids
[Centroids1, Members1] = myKmeans(Data1,Centroids1,200);
[Centroids2, Members2] = myKmeans(Data2,Centroids2,200);

Centers = [Centroids1;Centroids2];

% Get Beta Values
betas1 = getBeta(Data1,Centroids1,Members1, BetaPower);
betas2 = getBeta(Data2,Centroids2,Members2, BetaPower);
Betas = [betas1;betas2];

x_train = zeros(size(Data,1),size(Centers,1));

% for all the training data get the activation levels for each point
for i=1:size(Data,1)
    activations=getActivations(Data(i,:),Centers,Betas);
    x_train(i,:)=activations';
end

% gradient descent
weights = zeros(size(Centers,1),1);
options = optimset('Display','off','GradObj','on','MaxIter',25);

% learn class 1 weights (output)
y_train = (Labels==class1Label);
% find the minimum starting at 0
[weights1,Cost,exit] =fminunc(@(t)(getGradient(t, x_train, y_train)), weights, options);

% learn class 2 weights (output)
y_train = (Labels==class2Label);
[weights2,Cost,exit] =fminunc(@(t)(getGradient(t, x_train, y_train)), weights, options);

% set the model parameters
model.Centers=Centers;
model.Betas=Betas;
model.Weights1=weights1;
model.Weights2=weights2;
end