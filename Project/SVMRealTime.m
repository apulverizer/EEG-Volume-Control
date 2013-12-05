function [ predict_Label] = SVMRealTime(Data,Model)
%Uses the model to predict the classes in real time (one sample)
% Input:
%   Data: A matrix of the features
%   Model: The RBFN model to use
%   class1Label: The class 1 label
%   class2label: The class 2 label
% Output:
%   predict_Label: The predicted class for the single sample
%   Author: Aaron Pulver 12/4/13

% Initialize variables
% for every sample
[predict_Label, accuracy, ~] =svmpredict([0],Data, Model);
end
