function [fitness] = FitnessFunctionRBFN(C,G, Data, Class1Label,Class2Label)
%FitnessFunctionRBFN This is the fitness function used for PSO with the
%RBFN. 
% Inputs: 
%   C: The number of hidden layers to use
%   G: The power to use when calculating Beta coefficents
%   Data: The data structure to optimize for (BCI, BreastCancer...)
%   Class1Label: The label of class 1 (1,2,3...)
%   Class2Label: The label of class 2 (1,2,3...)
% Output:
%   fitness: The fitness of the function (0 is optimal)
%
% Author: Aaron Pulver 12/4/13
clear accuracy;
    modelRBFN = rbfnTrain(Data.Learning.Labels,Data.Learning.Features,C,G,Class1Label,Class2Label);
    modelRBFNValidation = rbfnTrain(Data.Validation.Labels,Data.Validation.Features,C,G,Class1Label,Class2Label);
    [predictions, accuracy1] = rbfnPredict(Data.Validation.Labels,Data.Validation.Features,modelRBFN,Class1Label,Class2Label);
    [predictions, accuracy2] = rbfnPredict(Data.Learning.Labels,Data.Learning.Features,modelRBFNValidation,Class1Label,Class2Label);
    fitness = 1/(accuracy1(1)*accuracy2(1));
    fprintf('Accuracy: %f Accuracy: %f\t L: %d B: %f \n',accuracy1,accuracy2,C,G);
end

