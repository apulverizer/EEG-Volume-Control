%   FileName:   collectBioRadioData
%   Date:       04/08/09
%   Author:     Ryan M. Bowen
%
%   Input:      channelNumbers  - array of channdels to collect (1:N)
%   Output:     channelData     - channel data of specified others are
%                                 filled with zeros
function channelData = collectBioRadioData(channelNumbers)

% Global constants from bioradio functions
global BioRadio150_numEnabledFastInputs;
global BioRadio150_fastDataReadSize;
global bioRadioHandle;

% Use Provided BioRadio150_Read to gather data
[fastData, slowData] = BioRadio150_Read(bioRadioHandle);

% Get the size of the incoming FAST data packets  
currentDataSize = BioRadio150_fastDataReadSize/BioRadio150_numEnabledFastInputs;

maxChannel = max(channelNumbers);

channelData = zeros(maxChannel,currentDataSize);

for i=1:length(channelNumbers)
    channelData(channelNumbers(i),:) = fastData(channelNumbers(i),1:currentDataSize);
end
