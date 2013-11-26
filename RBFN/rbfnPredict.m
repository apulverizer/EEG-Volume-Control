function [ predict_Label, accuracy ] = rbfnPredict(Labels,Data,Model,class1Label,class2Label )
%% Uses the model to predict the classes
% Input:
%   Labels: A vector of the class labels
%   Data: A matrix of the features
%   Model: The RBFN model to use

% Initialize variables
predict_Label = zeros(size(Labels,1),1);
correct =0;
incorrect=0;
% for every sample
for i=1:size(Labels,1)
    % calculate the activation levels using the input data
    phi = getActivations(Data(i,:),Model.Centers,Model.Betas);
    
    % "score" the data to determine which class it is
    score1=Model.Weights1'*phi;
    score2=Model.Weights2'*phi;
    
    % if class 2 score is higher, then choose class 2
    if(score2>score1)
        predict_Label(i,1)=class2Label;
    else
        predict_Label(i,1)=class1Label;
    end
    % determine accuracy 
    if(Labels(i)==predict_Label(i,1))
        correct=correct+1;
    else
        incorrect=incorrect+1;
    end
end
accuracy = 100*correct/(correct+incorrect);
end

