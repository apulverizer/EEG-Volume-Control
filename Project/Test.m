Fs
fprintf('Adding paths and loading pre-compiled data...\n');
addpath(genpath('../Data Collection'));
addpath(genpath('../libsvm-3.17'));
addpath(genpath('../RBFN'));
addpath(genpath('../TestData'));
addpath(genpath('../Project'));
addpath(genpath('../PSO'));
addpath(genpath('../VolumeControl'));
addpath(genpath('../BioRadioMatlab'));
load('realtime.mat');

CollectedData.Class1.Ch1 = [];
CollectedData.Class1.Ch2 = [];
CollectedData.Class1.Ch3 = [];
CollectedData.Class1.Ch4 = [];
CollectedData.Class2.Ch1 = [];
CollectedData.Class2.Ch2 = [];
CollectedData.Class2.Ch3 = [];
CollectedData.Class2.Ch4 = [];
CollectedData.Class2.Labels = [];
CollectedData.Class1.Labels = [];

%%Get raw data
CollectedData.Class1 = parseData(CollectedData.Class1,'HighVol-12-5-13.csv',1);
CollectedData.Class2 = parseData(CollectedData.Class2,'LowVol12-5-13.csv',2);

CollectedData.Features = [];
CollectedData.Labels = [];
for i=1:size(CollectedData.Class1.Ch1,1)
    features = extractFeatures(CollectedData.Class1.Ch1(i,:)',250);
    features = [features extractFeatures(CollectedData.Class1.Ch2(i,:)',250)];
    features = [features extractFeatures(CollectedData.Class1.Ch3(i,:)',250)];
    features = [features extractFeatures(CollectedData.Class1.Ch4(i,:)',250)];
    CollectedData.Features = [CollectedData.Features; features];
    CollectedData.Labels = [CollectedData.Labels; 1];
end
for i=1:size(CollectedData.Class2.Ch1,1)
    features = extractFeatures(CollectedData.Class2.Ch1(i,:)',250);
    features = [features extractFeatures(CollectedData.Class2.Ch2(i,:)',250)];
    features = [features extractFeatures(CollectedData.Class2.Ch3(i,:)',250)];
    features = [features extractFeatures(CollectedData.Class2.Ch4(i,:)',250)];
    CollectedData.Features = [CollectedData.Features; features];
    CollectedData.Labels = [CollectedData.Labels; 2];
end

% Break up Collected Data (Training)
% -----------------------------------------------------------------------
CollectedData.Features(isinf(CollectedData.Features)) = 0;
CollectedData.Features(isnan(CollectedData.Features)) = 0;
CollectedData.Learning.Features = [];
CollectedData.Learning.Labels =[];
CollectedData.Validation.Features =[];
CollectedData.Validation.Labels =[];
CollectedData.Testing.Features=[];
CollectedData.Testing.Labels=[];
% scramble data
%indiciesCollected = randperm(size(CollectedData.Features,1));
% CollectedData.Features=CollectedData.Features(indiciesCollected,:);
% CollectedData.Labels=CollectedData.Labels(indiciesCollected);

fprintf('Collected Data---------------------------------------------------------------\n');
params = sprintf('-t 2 -c %f -g %f -q', 9.6271, 1.3132);
%model = svmtrain(CollectedData.Learning.Labels,CollectedData.Learning.Features,params);
[~, accuracy, ~] = svmpredict(CollectedData.Labels,CollectedData.Features, modelSVM); % test the training data
fprintf('SVM Collected Data (Test): %f \n',accuracy(1));

%modelRBFN = rbfnTrain(CollectedData.Learning.Labels,CollectedData.Learning.Features,41,0,1,2);
[~, accuracy] = rbfnPredict(CollectedData.Labels,CollectedData.Features,modelRBFN,1,2);
fprintf('RBFN Collected Data (Test)  : %f \n',accuracy);


