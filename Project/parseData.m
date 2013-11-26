function [Data] = parseData(Data,fileName,classLabel)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [Ch1,Ch2,Ch3,Ch4]=importData(fileName,2);
    l=length(Ch1);
    numberOfSamples=floor(l/960); % 1 second intervals
    for i=0:numberOfSamples-1
        Data.Ch1= [Data.Ch1; Ch1((i*960)+1:(i*960)+960)'];
        Data.Ch2= [Data.Ch2; Ch1((i*960)+1:(i*960)+960)'];
        Data.Ch3= [Data.Ch3; Ch1((i*960)+1:(i*960)+960)'];
        Data.Ch4= [Data.Ch4; Ch1((i*960)+1:(i*960)+960)'];
        Data.Labels = [Data.Labels; classLabel];
    end;
end

