function [ features ] = extractFeatures(RawData, Fs)
%% extractFeatures A function which given a column (Channel) of raw data
% extracts the desired features
% Input:
%   RawData: A column of data
%   FS:      Frequency of data (Hz)
% Output:
%   features: A row vector of features
%
% Currently extracts alpha and beta mean band powers
%
% Author: Aaron Pulver 12/4/13

%[B,A] = butter(4,[1 30]/Fs*2);
%filteredData = log(filter(ones(Fs,1),Fs,filter(B,A,double(RawData)).^2 ));

bp = bandpower(RawData,Fs,[8,14;14,30],1,4);
%bp = bandpower(RawData,125,[8,10;10,12;12,14;14,16;16,18;18,20;20,22;22,24],1,4);
features = [mean(bp)];

end

