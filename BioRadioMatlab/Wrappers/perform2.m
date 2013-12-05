function [rawWindow] = perform2(rawWindow,windowSize)
%perform2 Gets the new data from the BioRadio and appends it
global bioRadioHandle;
% Channels
channelNumbers = [1 2 3 4];
cData = [];

% Collect the channel data from the BioRadio
if(bioRadioHandle >1)
 cData = collectBioRadioData(channelNumbers);
end;
 
 rawWindow = appendData(rawWindow,cData,windowSize);