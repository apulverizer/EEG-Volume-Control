function [rawWindow] = perform2(rawWindow,windowSize)
%perform2 Gets the new data from the BioRadio and appends it

% Channels
channelNumbers = [1 2 3 4];

% Collect the channel data from the BioRadio
 cData = collectBioRadioData(channelNumbers);
 
 rawWindow = appendData(rawWindow,cData,windowSize);