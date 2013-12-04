%% BioRobotics Project
% Aaron Pulver
% Deep Tayal
% Load and extract data
%% Add paths and clear memory and charts
close all;
fprintf('Adding paths and loading pre-compiled data...\n');
addpath(genpath('../Data Collection'));
addpath(genpath('../libsvm-3.17'));
addpath(genpath('../RBFN'));
addpath(genpath('../TestData'));
addpath(genpath('../Project'));
addpath(genpath('../PSO'));
addpath(genpath('../VolumeControl'));
addpath(genpath('../BioRadioMatlab'));
load('project.mat');

% %% Extract Data Collected---------------------------------------------------------------------------------------------------------
fprintf('Extracting and parsing collected data...\n');
% Get Raw Data
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

% Get raw data
CollectedData.Class1 = parseData(CollectedData.Class1,'HighVolumeTest1.csv',1);
CollectedData.Class2 = parseData(CollectedData.Class2,'LowVolumeTest1.csv',2);
CollectedData.Class1 = parseData(CollectedData.Class1,'HighVolumeTest2.csv',1);
CollectedData.Class2 = parseData(CollectedData.Class2,'LowVolumeTest2.csv',2);
CollectedData.Class1 = parseData(CollectedData.Class1, 'highVol1.csv',1);
CollectedData.Class2 = parseData(CollectedData.Class2, 'lowVol1.csv',2);
CollectedData.Class1 = parseData(CollectedData.Class1, 'highVol2.csv',1);
CollectedData.Class2 = parseData(CollectedData.Class2, 'lowVol2.csv',2);
CollectedData.Class1 = parseData(CollectedData.Class1, 'highVol3.csv',1);
CollectedData.Class2 = parseData(CollectedData.Class2, 'lowVol3.csv',2);
% get features
CollectedData.Features = [];
CollectedData.Labels = [];
for i=1:size(CollectedData.Class1.Ch1,1)
    features = extractFeatures(CollectedData.Class1.Ch1(i,:)');
    features = [features extractFeatures(CollectedData.Class1.Ch2(i,:)')];
    features = [features extractFeatures(CollectedData.Class1.Ch3(i,:)')];
    features = [features extractFeatures(CollectedData.Class1.Ch4(i,:)')];
    CollectedData.Features = [CollectedData.Features; features];
    CollectedData.Labels = [CollectedData.Labels; 1];
end
for i=1:size(CollectedData.Class2.Ch1,1)
    features = extractFeatures(CollectedData.Class2.Ch1(i,:)');
    features = [features extractFeatures(CollectedData.Class2.Ch2(i,:)')];
    features = [features extractFeatures(CollectedData.Class2.Ch3(i,:)')];
    features = [features extractFeatures(CollectedData.Class2.Ch4(i,:)')];
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
indiciesCollected = randperm(size(CollectedData.Features,1));
CollectedData.Features=CollectedData.Features(indiciesCollected,:);
CollectedData.Labels=CollectedData.Labels(indiciesCollected);

rows =size(CollectedData.Features,1);
CollectedData.Learning.Features=CollectedData.Features(1:round(rows/2),:);
CollectedData.Learning.Labels=CollectedData.Labels(1:round(rows/2),:);
CollectedData.Validation.Features=CollectedData.Features(round(rows/2)+1:round(rows*3/4),:);
CollectedData.Validation.Labels=CollectedData.Labels(round(rows/2)+1:round(rows*3/4),:);
CollectedData.Testing.Features=CollectedData.Features(round(rows*3/4)+1:end,:);
CollectedData.Testing.Labels=CollectedData.Labels(round(rows*3/4)+1:end,:);
  
% % Extract Sample Data Set Liver
% fprintf('Extracting and parsing liver data...\n');
% [Y,X] = libsvmread('../TestData/liver-disorders');
% X=full(X);
% 
% LiverData.Learning.Features=[];
% LiverData.Learning.Labels=[];
% LiverData.Validation.Features=[];
% LiverData.Validation.Labels=[];
% LiverData.Testing.Features=[];
% LiverData.Testing.Labels=[];
% LiverData.Features=X;
% LiverData.Labels=Y;
% clear X;
% clear Y;
% 
% rows =size(LiverData.Features,1);
% LiverData.Learning.Features=LiverData.Features(1:round(rows/2),:);
% LiverData.Learning.Labels=LiverData.Labels(1:round(rows/2),:);
% LiverData.Validation.Features=LiverData.Features(round(rows/2)+1:round(rows*3/4),:);
% LiverData.Validation.Labels=LiverData.Labels(round(rows/2)+1:round(rows*3/4),:);
% LiverData.Testing.Features=LiverData.Features(round(rows*3/4)+1:end,:);
% LiverData.Testing.Labels=LiverData.Labels(round(rows*3/4)+1:end,:);
% 
% % % Extract Diabetes Data
% fprintf('Extracting and parsing diabetes data...\n');
% [Y,X] = libsvmread('../TestData/diabetes');
% X=full(X);
% 
% DiabetesData.Learning.Features=[];
% DiabetesData.Learning.Labels=[];
% DiabetesData.Validation.Features=[];
% DiabetesData.Validation.Labels=[];
% DiabetesData.Testing.Features=[];
% DiabetesData.Testing.Labels=[];
% DiabetesData.Features=X;
% DiabetesData.Labels=Y;
% clear X;
% clear Y;
% 
% rows =size(DiabetesData.Features,1);
% DiabetesData.Learning.Features=DiabetesData.Features(1:round(rows/2),:);
% DiabetesData.Learning.Labels=DiabetesData.Labels(1:round(rows/2),:);
% DiabetesData.Validation.Features=DiabetesData.Features(round(rows/2)+1:round(rows*3/4),:);
% DiabetesData.Validation.Labels=DiabetesData.Labels(round(rows/2)+1:round(rows*3/4),:);
% DiabetesData.Testing.Features=DiabetesData.Features(round(rows*3/4)+1:end,:);
% DiabetesData.Testing.Labels=DiabetesData.Labels(round(rows*3/4)+1:end,:);
% 
% 
% % % Extract Cancer Cell Data
% fprintf('Extracting and parsing cancer data...\n');
% X=xlsread('Hw2CancerData.xls');
% rows =size(X,1);
% BreastCancerData.Learning.Features=X(1:round(rows/2),2:10);
% BreastCancerData.Learning.Labels=X(1:round(rows/2),11);
% BreastCancerData.Validation.Features=X(round(rows/2)+1:round(rows*3/4),2:10);
% BreastCancerData.Validation.Labels=X(round(rows/2)+1:round(rows*3/4),11);
% BreastCancerData.Testing.Features=X(round(rows*3/4)+1:end,2:10);
% BreastCancerData.Testing.Labels=X(round(rows*3/4)+1:end,11);
% 
% %% Format S4bData Data
% Extract S4bData Data
% fprintf('Extracting and parsing S4b data...\n');
% S4bData = ExtractBCIData(cellstr(['../TestData/S4b.gdf']));
% 
% S4bData.Features = [];
% S4bData.Labels = [];
% for i=1:size(S4bData.Class1.Ch1,2)
%     features = extractFeatures(S4bData.Class1.Ch1(:,i));
%     features = [features extractFeatures(S4bData.Class1.Ch2(:,i))];
%     S4bData.Features = [S4bData.Features; features];
%     S4bData.Labels = [S4bData.Labels; 1];
% end
% for i=1:size(S4bData.Class2.Ch1,2)
%     features = extractFeatures(S4bData.Class2.Ch1(:,i));
%     features = [features extractFeatures(S4bData.Class2.Ch2(:,i))];
%     S4bData.Features = [S4bData.Features; features];
%     S4bData.Labels = [S4bData.Labels; 2];
% end
% 
% S4bData.Learning.Features = [];
% S4bData.Learning.Labels =[];
% S4bData.Validation.Features =[];
% S4bData.Validation.Labels =[];
% S4bData.Testing.Features=[];
% S4bData.Testing.Labels=[];
% 
% %indiciesS4b=randperm(size(S4bData.Features,1));
% S4bData.Features=S4bData.Features(indiciesS4b,:);
% S4bData.Labels=S4bData.Labels(indiciesS4b);
% 
% % Break up S4bData Data
% rows =size(S4bData.Features,1);
% S4bData.Learning.Features=S4bData.Features(1:round(rows/2),:);
% S4bData.Learning.Labels=S4bData.Labels(1:round(rows/2),:);
% S4bData.Validation.Features=S4bData.Features(round(rows/2)+1:round(rows*3/4),:);
% S4bData.Validation.Labels=S4bData.Labels(round(rows/2)+1:round(rows*3/4),:);
% S4bData.Testing.Features=S4bData.Features(round(rows*3/4)+1:end,:);
% S4bData.Testing.Labels=S4bData.Labels(round(rows*3/4)+1:end,:);

% %% Format BCI Data
% fprintf('Extracting and parsing BCI B0101T-B0103T data...\n');
% BCIData = ExtractBCIData(cellstr(['../TestData/B0101T.gdf';'../TestData/B0102T.gdf';'../TestData/B0103T.gdf';]));
% 
% BCIData.Features = [];
% BCIData.Labels = [];
% for i=1:size(BCIData.Class1.Ch1,2)
%     features = extractFeatures(BCIData.Class1.Ch1(:,i));
%     features = [features extractFeatures(BCIData.Class1.Ch2(:,i))];
%     BCIData.Features = [BCIData.Features; features];
%     BCIData.Labels = [BCIData.Labels; 1];
% end
% for i=1:size(BCIData.Class2.Ch1,2)
%     features = extractFeatures(BCIData.Class2.Ch1(:,i));
%     features = [features extractFeatures(BCIData.Class2.Ch2(:,i))];
%     BCIData.Features = [BCIData.Features; features];
%     BCIData.Labels = [BCIData.Labels; 2];
% end
% 
% BCIData.Learning.Features = [];
% BCIData.Learning.Labels =[];
% BCIData.Validation.Features =[];
% BCIData.Validation.Labels =[];
% BCIData.Testing.Features=[];
% BCIData.Testing.Labels=[];
% 
% if(size(BCIData.Features,1)==240) 
%     indicies=indicies2;
% elseif (size(BCIData.Features,1)==400)
%     indicies=indicies3;
% end;
%         
% %Randomize the data based on previously established sequence
% %indicies=randperm(size(BCIData.Features,1));
% BCIData.Features=BCIData.Features(indicies,:);
% BCIData.Labels=BCIData.Labels(indicies);
% 
% % Break up BCI Data
% rows =size(BCIData.Features,1);
% BCIData.Learning.Features=BCIData.Features(1:round(rows/2),:);
% BCIData.Learning.Labels=BCIData.Labels(1:round(rows/2),:);
% BCIData.Validation.Features=BCIData.Features(round(rows/2)+1:round(rows*3/4),:);
% BCIData.Validation.Labels=BCIData.Labels(round(rows/2)+1:round(rows*3/4),:);
% BCIData.Testing.Features=BCIData.Features(round(rows*3/4)+1:end,:);
% BCIData.Testing.Labels=BCIData.Labels(round(rows*3/4)+1:end,:);

%% Classification Section Using Breast Cancer Data
%SVM..
fprintf('Breast Cancer----------------------------------------------------------------\n');
model = svmtrain(BreastCancerData.Learning.Labels,BreastCancerData.Learning.Features,'-t 2 -c 9.7038 -g .0000233 -q');
[~, accuracy, ~] = svmpredict(BreastCancerData.Testing.Labels, BreastCancerData.Testing.Features, model); % test the training data
fprintf('SVM Breast Cancer (Test) : %f \n',accuracy(1));
[~, accuracy, ~] = svmpredict(BreastCancerData.Validation.Labels, BreastCancerData.Validation.Features, model); % test the training data
fprintf('SVM Breast Cancer (Validation) : %f \n',accuracy(1));

% %RBFN
modelRBFN = rbfnTrain(BreastCancerData.Learning.Labels,BreastCancerData.Learning.Features,3,0.4836,2,4);
[~, accuracy] = rbfnPredict(BreastCancerData.Testing.Labels,BreastCancerData.Testing.Features,modelRBFN,2,4);
fprintf('RBFN Breast Cancer (Test): %f \n',accuracy);
[~, accuracy] = rbfnPredict(BreastCancerData.Validation.Labels,BreastCancerData.Validation.Features,modelRBFN,2,4);
fprintf('RBFN Breast Cancer (Validation): %f \n\n',accuracy(1));


%Liver Data
fprintf('Liver Disorder---------------------------------------------------------------\n');
model = svmtrain(LiverData.Learning.Labels,LiverData.Learning.Features,'-t 2 -c 73.446 -g 0.0000121 -q');
[~, accuracy, ~] = svmpredict(LiverData.Testing.Labels,LiverData.Testing.Features, model); % test the training data
fprintf('SVM Liver (Test): %f\n',accuracy(1));
[~, accuracy, ~] = svmpredict(LiverData.Validation.Labels,LiverData.Validation.Features, model); % test the training data
fprintf('SVM Liver (Validation): %f\n',accuracy(1));

modelRBFN = rbfnTrain(LiverData.Learning.Labels,LiverData.Learning.Features,53,4.4452,1,2);
[~, accuracy] = rbfnPredict(LiverData.Testing.Labels,LiverData.Testing.Features,modelRBFN,1,2);
fprintf('RBFN Liver (Test) : %f \n',accuracy(1));
[~, accuracy] = rbfnPredict(LiverData.Validation.Labels,LiverData.Validation.Features,modelRBFN,1,2);
fprintf('RBFN Liver (Validation) : %f \n\n',accuracy(1));


%Diabetes Data
fprintf('Diabetes Disorder------------------------------------------------------------\n');
model = svmtrain(DiabetesData.Learning.Labels,DiabetesData.Learning.Features,'-t 2 -c 2.677 -g 0.00000530 -q');
[~, accuracy, ~] = svmpredict(DiabetesData.Testing.Labels,DiabetesData.Testing.Features, model); % test the training data
fprintf('SVM Diabetes (Test): %f \n',accuracy(1));
[~, accuracy, ~] = svmpredict(DiabetesData.Validation.Labels,DiabetesData.Validation.Features, model); % test the training data
fprintf('SVM Diabetes (Validation): %f \n',accuracy(1));

modelRBFN = rbfnTrain(DiabetesData.Learning.Labels,DiabetesData.Learning.Features,40,2.8317,-1,1);
[~, accuracy] = rbfnPredict(DiabetesData.Testing.Labels,DiabetesData.Testing.Features,modelRBFN,-1,1);
fprintf('RBFN Diabetes (Test): %f \n',accuracy(1));
[~, accuracy] = rbfnPredict(DiabetesData.Validation.Labels,DiabetesData.Validation.Features,modelRBFN,-1,1);
fprintf('RBFN Diabetes (Validation): %f \n\n',accuracy(1));

%BCI
fprintf('BCIData----------------------------------------------------------------------\n');
model = svmtrain(BCIData.Learning.Labels,BCIData.Learning.Features,'-t 2 -c 238.45 -g 0.025962 -q');
[~, accuracy, ~] = svmpredict(BCIData.Testing.Labels,BCIData.Testing.Features, model); % test the training data
fprintf('SVM BCI (Test): %f \n',accuracy(1));
[~, accuracy, ~] = svmpredict(BCIData.Validation.Labels,BCIData.Validation.Features, model); % test the training data
fprintf('SVM BCI (Validation): %f \n',accuracy(1));

modelRBFN = rbfnTrain(BCIData.Learning.Labels,BCIData.Learning.Features,6,.34641,1,2);
[~, accuracy] = rbfnPredict(BCIData.Testing.Labels,BCIData.Testing.Features,modelRBFN,1,2);
fprintf('RBFN BCIData (Test)  : %f \n',accuracy);
[~, accuracy] = rbfnPredict(BCIData.Validation.Labels,BCIData.Validation.Features,modelRBFN,1,2);
fprintf('RBFN BCIData (Validation)  : %f \n\n',accuracy);

%S4bData
fprintf('S4b Data----------------------------------------------------------------------\n');
model = svmtrain(S4bData.Learning.Labels,S4bData.Learning.Features,'-t 2 -c 238.45 -g 0.025962 -q');
[~, accuracy, ~] = svmpredict(S4bData.Testing.Labels,S4bData.Testing.Features, model); % test the training data
fprintf('SVM S4b Data (Test): %f \n',accuracy(1));
[~, accuracy, ~] = svmpredict(S4bData.Validation.Labels,S4bData.Validation.Features, model); % test the training data
fprintf('SVM S4b Data (Learning): %f \n',accuracy(1));

modelRBFN = rbfnTrain(S4bData.Learning.Labels,S4bData.Learning.Features,6,.34641,1,2);
[~, accuracy] = rbfnPredict(S4bData.Testing.Labels,S4bData.Testing.Features,modelRBFN,1,2);
fprintf('RBFN S4b Data (Test)  : %f \n',accuracy);
[~, accuracy] = rbfnPredict(S4bData.Validation.Labels,S4bData.Validation.Features,modelRBFN,1,2);
fprintf('RBFN S4b Data (Learning)  : %f \n\n',accuracy);

% Collected Data
fprintf('Collected Data---------------------------------------------------------------\n');
params = sprintf('-t 2 -c %f -g %f -q', 9.6271, 1.3132);
model = svmtrain(CollectedData.Learning.Labels,CollectedData.Learning.Features,params);
[~, accuracy, ~] = svmpredict(CollectedData.Testing.Labels,CollectedData.Testing.Features, model); % test the training data
fprintf('SVM Collected Data (Test): %f \n',accuracy(1));
[~, accuracy, ~] = svmpredict(CollectedData.Validation.Labels,CollectedData.Validation.Features, model); % test the training data
fprintf('SVM Collected Data (Validation): %f \n',accuracy(1));
[~, accuracy, ~] = svmpredict(CollectedData.Learning.Labels,CollectedData.Learning.Features, model); % test the training data
fprintf('SVM Collected Data (Learning): %f \n',accuracy(1));

modelRBFN = rbfnTrain(CollectedData.Learning.Labels,CollectedData.Learning.Features,41,0,1,2);
[~, accuracy] = rbfnPredict(CollectedData.Testing.Labels,CollectedData.Testing.Features,modelRBFN,1,2);
fprintf('RBFN Collected Data (Test)  : %f \n',accuracy);
[~, accuracy] = rbfnPredict(CollectedData.Validation.Labels,CollectedData.Validation.Features,modelRBFN,1,2);
fprintf('RBFN Collected Data (Validation)  : %f\n',accuracy);
[~, accuracy] = rbfnPredict(CollectedData.Learning.Labels,CollectedData.Learning.Features,modelRBFN,1,2);
fprintf('RBFN Collected Data (Learning)  : %f \n\n',accuracy);

clear params;
clear model;
clear modelRBFN;
clear accuracy;
clear rows;
clear i;
