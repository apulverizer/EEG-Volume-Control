%% Real-time Volume control
% Collects data in real-time from the BioRadio, classifies it and adjust
% the volume of the Windows 7 PC
%
% Author: Aaron Pulver 12/4/13

% Add paths and clear memory and charts
close all;
clear all;
addpath(genpath('../Data Collection'));
addpath(genpath('../libsvm-3.17'));
addpath(genpath('../RBFN'));
addpath(genpath('../TestData'));
addpath(genpath('../Project'));
addpath(genpath('../PSO'));
addpath(genpath('../VolumeControl'));
addpath(genpath('../BioRadioMatlab'));
load('realtime.mat');

% initialize global variables
global bioRadioHandle isCollecting;
bioRadioHandle = -1;
isCollecting = 0;

% set paths
configPath = '..\BioRadioMatlab\EEG.ini';
dllPath = 'C:\Users\atp1317.MAIN\Documents\MATLAB\Lab3MATLABFOLDER';
portName = 'COM10';
collectionInterval = 960;

% connect to bio radio
bioRadioHandle = connectBioRadio(dllPath,configPath,portName);
% start collecting
isCollecting = 1;

Volume=.5;
SetWindowsVolume(Volume);
rawWindow = zeros( 4,collectionInterval);
while (isCollecting ==1 && Volume < 1 && Volume >0)
    % wait one second
    pause(1);
    % get new values
    rawWindow = perform2(rawWindow,collectionInterval);
    % classify 
    if(2==classifyVolume(rawWindow, modelRBFN))
        Volume= Volume-.05;
    else
        Volume = Volume+.05;
    end
    % set  volume
    if(Volume >= 0 && Volume <=100)
        SetWindowsVolume(Volume);
    end
end;
% clean up 
isCollecting = 0;
if(bioRadioHandle ~=1)
    disconnectBioRadio(bioRadioHandle);
end
    


