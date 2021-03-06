%% Optimize all data sets for RBFN and SVM
% Breast Cancer Data
% Diabetes
% Liver
% BCI
% Collected Data
%
% Author: Aaron Pulver 12/4/13
load('../Project/project.mat');

Iterations = 100;
C1= 2.6;
C2 = 1.5;
SwarmSize = 20;
C_BCI_RBFN = 0;
G_BCI_RBFN = 0;
C_Breast_RBFN = 0;
G_Breast_RBFN = 0;
C_Diabetes_RBFN = 0;
G_Diabetes_RBFN = 0;
C_Liver_RBFN = 0;
G_Liver_RBFN = 0;
C_CollectedData_RBFN = 0;
G_CollectedData_RBFN = 0;
C_S4b_RBFN =0;
G_S4b_RBFN =0;


C_BCI_SVM = 0;
G_BCI_SVM = 0;
C_Breast_SVM = 0;
G_Breast_SVM = 0;
C_Diabetes_SVM = 0;
G_Diabetes_SVM = 0;
C_Liver_SVM = 0;
G_Liver_SVM = 0;
C_CollectedData_SVM = 0;
G_CollectedData_SVM = 0;
C_S4b_SVM =0;
G_S4b_SVM =0;

%%SVM
%% BCI Data
%[C_BCI_SVM, G_BCI_SVM] = PSO(Iterations,C1,C2,SwarmSize,BCIData);

%% S4b Data
%[C_S4b_SVM, G_S4b_SVM] = PSO(Iterations,C1,C2,SwarmSize,S4bData);

%% Breast Cancer Data
%[C_Breast_SVM, G_Breast_SVM] = PSO(Iterations,C1,C2,SwarmSize,BreastCancerData);

% Diabetes
[C_Diabetes_SVM, G_Diabetes_SVM] = PSO(Iterations,C1,C2,SwarmSize,DiabetesData);

%% Liver Data
[C_Liver_SVM, G_Liver_SVM] = PSO(Iterations,C1,C2,SwarmSize,LiverData);

% Test Data
%[C_CollectedData_SVM, G_CollectedData_SVM] = PSO(Iterations,C1,C2,SwarmSize,CollectedData);


%% Radial Basis Function
%% BCI Data
% [C_BCI_RBFN, G_BCI_RBFN] = PSORBFN(Iterations,C1,C2,SwarmSize,BCIData,1,2,1,.001,30,100);
% 
% %% S4b Data
% %[C_S4b_RBFN, G_S4b_RBFN] = PSORBFN(Iterations,C1,C2,SwarmSize,S4bData,1,2,1,.001,50,100);
% 
% % %% Breast Cancer Data
% [C_Breast_RBFN, G_Breast_RBFN] = PSORBFN(Iterations,C1,C2,SwarmSize,BreastCancerData,2,4,1,.001,40,100);
% % 
% % %% Diabetes Data
% [C_Diabetes_RBFN, G_Diabetes_RBFN] = PSORBFN(Iterations,C1,C2,SwarmSize,DiabetesData,-1,1,1,.001,40,100);
% % 
% % %% Liver Data
% [C_Liver_RBFN, G_Liver_RBFN] = PSORBFN(Iterations,C1,C2,SwarmSize,LiverData,1,2,1,.001,70,100);
% % 
% % %% Test Data
% [C_CollectedData_RBFN, G_CollectedData_RBFN] = PSORBFN(Iterations,C1,C2,SwarmSize,CollectedData,1,2,1,0,150,100);
% % 

%% Get Results

% %SVM..
% fprintf('Breast Cancer\n');
% params = sprintf('-t 2 -c %f -g %f -q', C_Breast_SVM, G_Breast_SVM);
% model = svmtrain(BreastCancerData.Learning.Labels,BreastCancerData.Learning.Features,params);
% [predict_label, accuracy, dec_values] = svmpredict(BreastCancerData.Testing.Labels, BreastCancerData.Testing.Features, model); % test the training data
% fprintf('SVM Breast Cancer (Test) : %f \n',accuracy(1));
% [predict_label, accuracy, dec_values] = svmpredict(BreastCancerData.Validation.Labels, BreastCancerData.Validation.Features, model); % test the training data
% fprintf('SVM Breast Cancer (Validation) : %f \n',accuracy(1));

% %RBFN
% modelRBFN = rbfnTrain(BreastCancerData.Learning.Labels,BreastCancerData.Learning.Features,C_Breast_RBFN,G_Breast_RBFN,2,4);
% [predictions, accuracy] = rbfnPredict(BreastCancerData.Testing.Labels,BreastCancerData.Testing.Features,modelRBFN,2,4);
% fprintf('RBFN Breast Cancer (Test): %f \n',accuracy);
% [predictions, accuracy] = rbfnPredict(BreastCancerData.Validation.Labels,BreastCancerData.Validation.Features,modelRBFN,2,4);
% fprintf('RBFN Breast Cancer (Validation): %f \n\n',accuracy(1));


%Liver Data
fprintf('Liver Disorder\n');
params = sprintf('-t 2 -c %f -g %f -q', C_Liver_SVM, G_Liver_SVM);
model = svmtrain(LiverData.Learning.Labels,LiverData.Learning.Features,params);
[predict_label, accuracy, dec_values] = svmpredict(LiverData.Testing.Labels,LiverData.Testing.Features, model); % test the training data
fprintf('SVM Liver (Test): %f\n',accuracy(1));
[predict_label, accuracy, dec_values] = svmpredict(LiverData.Validation.Labels,LiverData.Validation.Features, model); % test the training data
fprintf('SVM Liver (Validation): %f\n',accuracy(1));

% modelRBFN = rbfnTrain(LiverData.Learning.Labels,LiverData.Learning.Features,C_Liver_RBFN,G_Liver_RBFN,1,2);
% [predictions, accuracy] = rbfnPredict(LiverData.Testing.Labels,LiverData.Testing.Features,modelRBFN,1,2);
% fprintf('RBFN Liver (Test) : %f \n',accuracy(1));
% [predictions, accuracy] = rbfnPredict(LiverData.Validation.Labels,LiverData.Validation.Features,modelRBFN,1,2);
% fprintf('RBFN Liver (Validation) : %f \n\n',accuracy(1));


%Diabetes Data
fprintf('Diabetes Disorder\n');
params = sprintf('-t 2 -c %f -g %f -q', C_Diabetes_SVM, G_Diabetes_SVM);
model = svmtrain(DiabetesData.Learning.Labels,DiabetesData.Learning.Features,params);
[predict_label, accuracy, dec_values] = svmpredict(DiabetesData.Testing.Labels,DiabetesData.Testing.Features, model); % test the training data
fprintf('SVM Diabetes (Test): %f \n',accuracy(1));
[predict_label, accuracy, dec_values] = svmpredict(DiabetesData.Validation.Labels,DiabetesData.Validation.Features, model); % test the training data
fprintf('SVM Diabetes (Validation): %f \n',accuracy(1));

% modelRBFN = rbfnTrain(DiabetesData.Learning.Labels,DiabetesData.Learning.Features,C_Diabetes_RBFN,G_Diabetes_RBFN,-1,1);
% [predictions, accuracy] = rbfnPredict(DiabetesData.Testing.Labels,DiabetesData.Testing.Features,modelRBFN,-1,1);
% fprintf('RBFN Diabetes (Test): %f \n',accuracy(1));
% [predictions, accuracy] = rbfnPredict(DiabetesData.Validation.Labels,DiabetesData.Validation.Features,modelRBFN,-1,1);
% fprintf('RBFN Diabetes (Validation): %f \n\n',accuracy(1));

% % BCI Data
% fprintf('BCIData\n');
% params = sprintf('-t 2 -c %f -g %f -q', C_BCI_SVM, G_BCI_SVM);
% model = svmtrain(BCIData.Learning.Labels,BCIData.Learning.Features,params);
% [predict_label, accuracy, dec_values] = svmpredict(BCIData.Testing.Labels,BCIData.Testing.Features, model); % test the training data
% fprintf('SVM BCI (Test): %f \n',accuracy(1));
% [predict_label, accuracy, dec_values] = svmpredict(BCIData.Validation.Labels,BCIData.Validation.Features, model); % test the training data
% fprintf('SVM BCI (Validation): %f \n',accuracy(1));

% modelRBFN = rbfnTrain(BCIData.Learning.Labels,BCIData.Learning.Features,C_BCI_RBFN,G_BCI_RBFN,1,2);
% [predictions, accuracy] = rbfnPredict(BCIData.Testing.Labels,BCIData.Testing.Features,modelRBFN,1,2);
% fprintf('RBFN BCIData (Test)  : %f \n',accuracy);
% [predictions, accuracy] = rbfnPredict(BCIData.Validation.Labels,BCIData.Validation.Features,modelRBFN,1,2);
% fprintf('RBFN BCIData (Validation)  : %f \n\n',accuracy);

% S4b Data
% fprintf('Sb4\n');
% params = sprintf('-t 2 -c %f -g %f -q', C_S4b_SVM, G_S4b_SVM);
% model = svmtrain(S4bData.Learning.Labels,S4bData.Learning.Features,params);
% [predict_label, accuracy, dec_values] = svmpredict(S4bData.Testing.Labels,S4bData.Testing.Features, model); % test the training data
% fprintf('SVM S4b (Test): %f \n',accuracy(1));
% [predict_label, accuracy, dec_values] = svmpredict(S4bData.Validation.Labels,S4bData.Validation.Features, model); % test the training data
% fprintf('SVM S4b (Validation): %f \n',accuracy(1));
% 
% modelRBFN = rbfnTrain(S4bData.Learning.Labels,S4bData.Learning.Features,C_S4b_RBFN,G_S4b_RBFN,1,2);
% [predictions, accuracy] = rbfnPredict(S4bData.Testing.Labels,S4bData.Testing.Features,modelRBFN,1,2);
% fprintf('RBFN S4b (Test)  : %f \n',accuracy);
% [predictions, accuracy] = rbfnPredict(S4bData.Validation.Labels,S4bData.Validation.Features,modelRBFN,1,2);
% fprintf('RBFN S4b (Validation)  : %f \n\n',accuracy);

% % Collected Data
% fprintf('Collected Data\n');
% params = sprintf('-t 2 -c %f -g %f -q', C_CollectedData_SVM, G_CollectedData_SVM);
% model = svmtrain(CollectedData.Learning.Labels,CollectedData.Learning.Features,params);
% [predict_label, accuracy, dec_values] = svmpredict(CollectedData.Learning.Labels,CollectedData.Learning.Features, model); % test the training data
% fprintf('SVM Collected Data (Learning): %f \n',accuracy(1));
% [predict_label, accuracy, dec_values] = svmpredict(CollectedData.Testing.Labels,CollectedData.Testing.Features, model); % test the training data
% fprintf('SVM Collected Data (Test): %f \n',accuracy(1));
% [predict_label, accuracy, dec_values] = svmpredict(CollectedData.Validation.Labels,CollectedData.Validation.Features, model); % test the training data
% fprintf('SVM Collected Data (Validation): %f \n',accuracy(1));

% modelRBFN = rbfnTrain(CollectedData.Learning.Labels,CollectedData.Learning.Features,C_CollectedData_RBFN,G_CollectedData_RBFN,1,2);
% [predictions, accuracy] = rbfnPredict(CollectedData.Testing.Labels,CollectedData.Testing.Features,modelRBFN,1,2);
% fprintf('RBFN BCIData (Test)  : %f \n',accuracy);
% [predictions, accuracy] = rbfnPredict(CollectedData.Validation.Labels,CollectedData.Validation.Features,modelRBFN,1,2);
% fprintf('RBFN BCIData (Validation)  : %f \n\n',accuracy);

%% Print Results 
results = [C_BCI_SVM, G_BCI_SVM, C_Breast_SVM, G_Breast_SVM, C_Diabetes_SVM, G_Diabetes_SVM,C_Liver_SVM, G_Liver_SVM, C_CollectedData_SVM, G_CollectedData_SVM,C_S4b_SVM,G_S4b_SVM,Iterations,C1,C2,SwarmSize;
           C_BCI_RBFN, G_BCI_RBFN, C_Breast_RBFN, G_Breast_RBFN, C_Diabetes_RBFN, G_Diabetes_RBFN,C_Liver_RBFN, G_Liver_RBFN,C_CollectedData_RBFN,G_CollectedData_RBFN,C_S4b_RBFN,G_S4b_RBFN,Iterations,C1,C2,SwarmSize];

headers = {'C_BCI','G_BCI','C_Breast','G_Breast','C_Diabetes','G_Diabetes','C_Liver','G_Liver','C_CollectedData','G_CollectedData','C_S4b','G_S4b','Iterations','C1','C2','Size'};
file = sprintf('psoResults-%s.csv',datestr(clock,'mm-dd-yyyy-HH-MM-SS-FFF'));
csvwriteh(file,results,headers);