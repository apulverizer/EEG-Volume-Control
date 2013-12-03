%
%   FileName:   computeFT
%
%
%
function fftWindow = computeFT(filteredData, channelNumbers)
    
    for i = 1:length(channelNumbers)
        
        % Get the current filtered data
        x = filteredData(channelNumbers(i),:);
        
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% IMPLEMENT YOUR FFT CODE IN HERE
        
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        % Set the current channel fft data
        fftWindow(channelNumbers(i),:) = x;

        
        
    end

    