function [fitness] = FitnessFunctionSVM(C,G, Data)
    params = sprintf('-t 2 -c %f -g %f -q',C,G);
    clear accuracy;
    model = svmtrain(Data.Learning.Labels,Data.Learning.Features,params);
    modelValidation = svmtrain(Data.Validation.Labels,Data.Validation.Features,params);
    [predict_label, accuracy1, dec_values] = svmpredict(Data.Validation.Labels,Data.Validation.Features,model);
    [predict_label, accuracy2, dec_values] = svmpredict(Data.Learning.Labels,Data.Learning.Features,modelValidation);
    %fitness = abs(accuracy1(1)*100-accuracy2(1))/(accuracy1(1)*100+accuracy2(1));
    fitness = 1/(accuracy1(1)+accuracy2(1));

    fprintf('Accuracy: %f Accuracy: %f\t L: %d B: %f \n',accuracy1(1),accuracy2(1),C,G);
end

