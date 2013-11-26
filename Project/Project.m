%% BioRobotics Project
% Aaron Pulver
% Deep Tayal
%% Load and extract data
% Add paths and clear memory and charts
close all;
addpath(genpath('../Data Collection'));
addpath(genpath('../libsvm-3.17'));
addpath(genpath('../RBFN'));
addpath(genpath('../TestData'));
addpath(genpath('../Project'));
addpath(genpath('../PSO'));
load('filters.mat');

% Extract Data Collected
% CollectedData.Ch1 = [];
% CollectedData.Ch2 = [];
% CollectedData.Ch3 = [];
% CollectedData.Ch4 = [];
% CollectedData.Labels = [];
% 
% CollectedData = parseData(CollectedData,'HighVolumeTest1.csv',1);
% CollectedData = parseData(CollectedData,'HighVolumeTest2.csv',1);
% CollectedData = parseData(CollectedData,'LowVolumeTest1.csv',2);
% CollectedData = parseData(CollectedData,'LowVolumeTest2.csv',2);


% Extract BCI Data
BCIData = ExtractBCIData(cellstr(['../TestData/B0101T.gdf';'../TestData/B0102T.gdf';'../TestData/B0103T.gdf';]));
%BCIData2 = ExtractBCIData(cellstr(['../TestData/B0104E.gdf']));

% Extract Sample Data Set Liver
[Y,X] = libsvmread('../TestData/liver-disorders');
X=full(X);

LiverData.Learning.Features=[];
LiverData.Learning.Labels=[];
LiverData.Validation.Features=[];
LiverData.Validation.Labels=[];
LiverData.Testing.Features=[];
LiverData.Testing.Labels=[];
LiverData.Features=X;
LiverData.Labels=Y;
clear X;
clear Y;

rows =size(LiverData.Features,1);
LiverData.Learning.Features=LiverData.Features(1:round(rows/2),:);
LiverData.Learning.Labels=LiverData.Labels(1:round(rows/2),:);
LiverData.Validation.Features=LiverData.Features(round(rows/2)+1:round(rows*3/4),:);
LiverData.Validation.Labels=LiverData.Labels(round(rows/2)+1:round(rows*3/4),:);
LiverData.Testing.Features=LiverData.Features(round(rows*3/4)+1:end,:);
LiverData.Testing.Labels=LiverData.Labels(round(rows*3/4)+1:end,:);

% Extract 
[Y,X] = libsvmread('../TestData/diabetes');
X=full(X);

DiabetesData.Learning.Features=[];
DiabetesData.Learning.Labels=[];
DiabetesData.Validation.Features=[];
DiabetesData.Validation.Labels=[];
DiabetesData.Testing.Features=[];
DiabetesData.Testing.Labels=[];
DiabetesData.Features=X;
DiabetesData.Labels=Y;
clear X;
clear Y;

rows =size(DiabetesData.Features,1);
DiabetesData.Learning.Features=DiabetesData.Features(1:round(rows/2),:);
DiabetesData.Learning.Labels=DiabetesData.Labels(1:round(rows/2),:);
DiabetesData.Validation.Features=DiabetesData.Features(round(rows/2)+1:round(rows*3/4),:);
DiabetesData.Validation.Labels=DiabetesData.Labels(round(rows/2)+1:round(rows*3/4),:);
DiabetesData.Testing.Features=DiabetesData.Features(round(rows*3/4)+1:end,:);
DiabetesData.Testing.Labels=DiabetesData.Labels(round(rows*3/4)+1:end,:);


% Extract Cancer Cell Data
X=xlsread('Hw2CancerData.xls');
rows =size(X,1);
BreastCancerData.Learning.Features=X(1:round(rows/2),2:10);
BreastCancerData.Learning.Labels=X(1:round(rows/2),11);
BreastCancerData.Validation.Features=X(round(rows/2)+1:round(rows*3/4),2:10);
BreastCancerData.Validation.Labels=X(round(rows/2)+1:round(rows*3/4),11);
BreastCancerData.Testing.Features=X(round(rows*3/4)+1:end,2:10);
BreastCancerData.Testing.Labels=X(round(rows*3/4)+1:end,11);

%% Format BCI Data
BCIData.Features = [];
BCIData.Labels = [];
for i=1:size(BCIData.Class1.Ch1,2)
    features = extractFeatures(BCIData.Class1.Ch1(:,i),FilterAlpha,FilterBeta);
    features = [features extractFeatures(BCIData.Class1.Ch2(:,i),FilterAlpha,FilterBeta)];
    BCIData.Features = [BCIData.Features; features];
    BCIData.Labels = [BCIData.Labels; 1];
end
for i=1:size(BCIData.Class2.Ch1,2)
    features = extractFeatures(BCIData.Class2.Ch1(:,i),FilterAlpha,FilterBeta);
    features = [features extractFeatures(BCIData.Class2.Ch2(:,i),FilterAlpha,FilterBeta)];
    BCIData.Features = [BCIData.Features; features];
    BCIData.Labels = [BCIData.Labels; 2];
end

BCIData.Learning.Features = [];
BCIData.Learning.Labels =[];
BCIData.Validation.Features =[];
BCIData.Validation.Labels =[];
BCIData.Testing.Features=[];
BCIData.Testing.Labels=[];

if(size(BCIData.Features,1)==240) 
    indicies=indicies2;
elseif (size(BCIData.Features,1)==400)
    indicies=indicies3;
end;
        
% Randomize the data based on previously established sequence
%indicies=randperm(size(BCIData.Features,1));
BCIData.Features=BCIData.Features(indicies,:);
BCIData.Labels=BCIData.Labels(indicies);

% Break up BCI Data
rows =size(BCIData.Features,1);
BCIData.Learning.Features=BCIData.Features(1:round(rows/2),:);
BCIData.Learning.Labels=BCIData.Labels(1:round(rows/2),:);
BCIData.Validation.Features=BCIData.Features(round(rows/2)+1:round(rows*3/4),:);
BCIData.Validation.Labels=BCIData.Labels(round(rows/2)+1:round(rows*3/4),:);
BCIData.Testing.Features=BCIData.Features(round(rows*3/4)+1:end,:);
BCIData.Testing.Labels=BCIData.Labels(round(rows*3/4)+1:end,:);

%% Classification Section Using Breast Cancer Data
%SVM..
fprintf('Breast Cancer\n');
model = svmtrain(BreastCancerData.Learning.Labels,BreastCancerData.Learning.Features,'-t 0 -c 262.8556 -g .001 -q');
[predict_label, accuracy, dec_values] = svmpredict(BreastCancerData.Testing.Labels, BreastCancerData.Testing.Features, model); % test the training data
fprintf('SVM Breast Cancer (Test) : %f \n',accuracy(1));
[predict_label, accuracy, dec_values] = svmpredict(BreastCancerData.Validation.Labels, BreastCancerData.Validation.Features, model); % test the training data
fprintf('SVM Breast Cancer (Validation) : %f \n',accuracy(1));

% %RBFN
modelRBFN = rbfnTrain(BreastCancerData.Learning.Labels,BreastCancerData.Learning.Features,3,0.4836,2,4);
[predictions, accuracy] = rbfnPredict(BreastCancerData.Testing.Labels,BreastCancerData.Testing.Features,modelRBFN,2,4);
fprintf('RBFN Breast Cancer (Test): %f \n',accuracy);
[predictions, accuracy] = rbfnPredict(BreastCancerData.Validation.Labels,BreastCancerData.Validation.Features,modelRBFN,2,4);
fprintf('RBFN Breast Cancer (Validation): %f \n\n',accuracy(1));


%Liver Data
fprintf('Liver Disorder\n');
model = svmtrain(LiverData.Learning.Labels,LiverData.Learning.Features,'-t 0 -c 41.7462 -g 0.000020038 -q');
[predict_label, accuracy, dec_values] = svmpredict(LiverData.Testing.Labels,LiverData.Testing.Features, model); % test the training data
fprintf('SVM Liver (Test): %f\n',accuracy(1));
[predict_label, accuracy, dec_values] = svmpredict(LiverData.Validation.Labels,LiverData.Validation.Features, model); % test the training data
fprintf('SVM Liver (Validation): %f\n',accuracy(1));

modelRBFN = rbfnTrain(LiverData.Learning.Labels,LiverData.Learning.Features,50,4.4430,1,2);
[predictions, accuracy] = rbfnPredict(LiverData.Testing.Labels,LiverData.Testing.Features,modelRBFN,1,2);
fprintf('RBFN Liver (Test) : %f \n',accuracy(1));
[predictions, accuracy] = rbfnPredict(LiverData.Validation.Labels,LiverData.Validation.Features,modelRBFN,1,2);
fprintf('RBFN Liver (Validation) : %f \n\n',accuracy(1));


%Diabetes Data
fprintf('Diabetes Disorder\n');
model = svmtrain(DiabetesData.Learning.Labels,DiabetesData.Learning.Features,'-t 2 -c 4.8157 -g .0000042381 -q');
[predict_label, accuracy, dec_values] = svmpredict(DiabetesData.Testing.Labels,DiabetesData.Testing.Features, model); % test the training data
fprintf('SVM Diabetes (Test): %f \n',accuracy(1));
[predict_label, accuracy, dec_values] = svmpredict(DiabetesData.Validation.Labels,DiabetesData.Validation.Features, model); % test the training data
fprintf('SVM Diabetes (Validation): %f \n',accuracy(1));

modelRBFN = rbfnTrain(DiabetesData.Learning.Labels,DiabetesData.Learning.Features,43,2.7711,-1,1);
[predictions, accuracy] = rbfnPredict(DiabetesData.Testing.Labels,DiabetesData.Testing.Features,modelRBFN,-1,1);
fprintf('RBFN Diabetes (Test): %f \n',accuracy(1));
[predictions, accuracy] = rbfnPredict(DiabetesData.Validation.Labels,DiabetesData.Validation.Features,modelRBFN,-1,1);
fprintf('RBFN Diabetes (Validation): %f \n\n',accuracy(1));

fprintf('BCIData\n');
model = svmtrain(BCIData.Learning.Labels,BCIData.Learning.Features,'-t 2 -c 46.4786 -g 0.0695 -q');
[predict_label, accuracy, dec_values] = svmpredict(BCIData.Testing.Labels,BCIData.Testing.Features, model); % test the training data
fprintf('SVM BCI (Test): %f \n',accuracy(1));
[predict_label, accuracy, dec_values] = svmpredict(BCIData.Validation.Labels,BCIData.Validation.Features, model); % test the training data
fprintf('SVM BCI (Validation): %f \n',accuracy(1));

modelRBFN = rbfnTrain(BCIData.Learning.Labels,BCIData.Learning.Features,6,.3316,1,2);
[predictions, accuracy] = rbfnPredict(BCIData.Testing.Labels,BCIData.Testing.Features,modelRBFN,1,2);
fprintf('RBFN BCIData (Test)  : %f \n',accuracy);
[predictions, accuracy] = rbfnPredict(BCIData.Validation.Labels,BCIData.Validation.Features,modelRBFN,1,2);
fprintf('RBFN BCIData (Validation)  : %f \n\n',accuracy);
% 
% modelRBFN = rbfnTrain(BCIData.Validation.Labels,BCIData.Validation.Features,NumClusters,1,2);
% [predictions, accuracy] = rbfnPredict(BCIData.Testing.Labels,BCIData.Testing.Features,modelRBFN,1,2);
% fprintf('Testing RBFN BCIData  : %f \n\n',accuracy);
% 
% modelRBFN = rbfnTrain(BCIData.Labels,BCIData.Features,NumClusters,1,2);
% [predictions, accuracy] = rbfnPredict(BCIData.Labels,BCIData.Features,modelRBFN,1,2);
% fprintf('Learning All RBFN BCIData  : %f \n\n',accuracy);
