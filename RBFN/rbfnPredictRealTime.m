function [ predict_Label] = rbfnPredictRealTime(Data,Model,class1Label,class2Label )
%% Uses the model to predict the classes
% Input:
%   Labels: A vector of the class labels
%   Data: A matrix of the features
%   Model: The RBFN model to use

% Initialize variables
% for every sample
predict_Label=0;
% calculate the activation levels using the input data
phi = getActivations(Data,Model.Centers,Model.Betas);

% "score" the data to determine which class it is
score1=Model.Weights1'*phi;
score2=Model.Weights2'*phi;

% if class 2 score is higher, then choose class 2
if(score2>score1)
    predict_Label=class2Label;
else
    predict_Label=class1Label;
end
end

