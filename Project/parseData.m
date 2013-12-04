function [Data] = parseData(Data,fileName,classLabel)
%parseData Parses the BCI data and labels it
% Inputs:
%   Data: A structure with Channels and Labels
%   fileName: The file to import and parse
%   classLabel: The label of the class (1,2,3...)
%
% Author: Aaron Pulver 12/4/13

    [Ch1,Ch2,Ch3,Ch4]=importData(fileName,2);
    l=length(Ch1);
    numberOfSamples=floor(l/960); % 1 second intervals
    for i=2:numberOfSamples-5
        Data.Ch1= [Data.Ch1; Ch1((i*960)+1:(i*960)+960)'];
        Data.Ch2= [Data.Ch2; Ch2((i*960)+1:(i*960)+960)'];
        Data.Ch3= [Data.Ch3; Ch3((i*960)+1:(i*960)+960)'];
        Data.Ch4= [Data.Ch4; Ch4((i*960)+1:(i*960)+960)'];
        Data.Labels = [Data.Labels; classLabel];
    end;
end

