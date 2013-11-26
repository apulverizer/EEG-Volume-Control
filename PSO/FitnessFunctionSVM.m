function [fitness] = FitnessFunctionSVM(C,G, Data)
    params = sprintf('-t 2 -c %f -g %f -q',C,G);
    clear accuracy;
    model = svmtrain(Data.Learning.Labels,Data.Learning.Features,params);
    [~, accuracy1, dec_values] = svmpredict(Data.Testing.Labels,Data.Testing.Features, model);
    [~, accuracy2, dec_values] = svmpredict(Data.Validation.Labels,Data.Validation.Features, model);
    fitness = 1/(accuracy1(1)+accuracy2(1));
end

