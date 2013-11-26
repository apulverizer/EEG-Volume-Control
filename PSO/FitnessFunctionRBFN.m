function [fitness] = FitnessFunctionRBFN(C,G, Data, Class1Label,Class2Label)
    clear accuracy;
    modelRBFN = rbfnTrain(Data.Learning.Labels,Data.Learning.Features,C,G,Class1Label,Class2Label);
    [predictions, accuracy1] = rbfnPredict(Data.Testing.Labels,Data.Testing.Features,modelRBFN,Class1Label,Class2Label);
    [predictions, accuracy2] = rbfnPredict(Data.Validation.Labels,Data.Validation.Features,modelRBFN,Class1Label,Class2Label);
    fitness = 1/(accuracy1(1)+accuracy2(1));
    fprintf('Accuracy: %f L: %d B: %f \n',accuracy2,C,G);
end

