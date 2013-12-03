function [rawWindow filterWindow fftWindow] = perform(rawWindow,filterWindow,fftWindow,windowSize)

% Channels
channelNumbers = [1 2];

% Collect the channel data from the BioRadio
 cData = collectBioRadioData(channelNumbers);
 
 rawWindow = appendData(rawWindow,cData,windowSize);

 % Filter the current data
 filterWindow = filterData(rawWindow,channelNumbers);
 
 % Take fft of the current data
 
 fftWindow = computeFT(filterWindow, channelNumbers);