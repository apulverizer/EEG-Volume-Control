function BioRadio150_Test(pathToDllDirectory, pathToConfigFile, pathToFastDataOutputFile, pathToSlowDataOutputFile, NumChannelsToPlot, useLegacyComputerUnit)
%----
%BIORADIO150_TEST Example of acquiring and saving BioRadio data
%
%   BIORADIO150_TEST(pathToDllDirectory, pathToConfigFile, pathToFastDataOutputFile, pathToSlowDataOutputFile, NumChannelsToPlot)
%   uses the main BioRadio MATLAB functions to Load, Find, Start, Program, and
%   repeatedly Read incoming BioRadio data. Acquired data is logged to output
%		files, (divided by Fast and Slow inputs,) and a selected number of input
%		channels are plotted. When finished, communication is stopped, and the
%		BioRadio library and memory is unloaded.
%
%   Example usage: BioRadio150_Test('C:\BioRadioSDK\Matlab SDK', 'C:\BioRadioSDK\Matlab SDK\ExampleConfig.ini', 'fast.out', 'slow.out', 1, 0);
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_PING,
%BIORADIO150_READ, BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----

    % Ensure all arguments are specified
    if (nargin ~= 6)
        error('Usage: BioRadio150_Test(<pathToDllDirectory>, <pathToConfigFile>, <pathToFastDataOutputFile>, <pathToSlowDataOutputFile>, <NumChannelsToPlot>), <useLegacyComputerUnit>');
    end
    
    % Load the library
    try
    		deviceHandle = BioRadio150_Load(pathToDllDirectory, useLegacyComputerUnit);
    catch
    		rethrow(lasterror)
    end
    
    % Report DLL version
    infoStrSize = 20;
    dllVersionString = blanks(infoStrSize);
    dllVersionString = calllib('BioRadio150DLL', 'GetDLLVersionString', dllVersionString, infoStrSize-1);
    disp(sprintf('*BioRadio*  DLL version: %s', dllVersionString));

    % Find devices, and use the first one found
    deviceComPorts = BioRadio150_Find;
    if (length(deviceComPorts) <= 0)
    		disp('*BioRadio*  no devices found; aborting');
    		BioRadio150_Unload(deviceHandle);
    		return;
    end
    portName = char(deviceComPorts(1));
    disp(sprintf('*BioRadio*  using %s', portName));

    % Start BioRadio data acquisition
    try
        BioRadio150_Start(deviceHandle, portName, 1, pathToConfigFile);
    catch
        BioRadio150_Unload(deviceHandle);
        rethrow(lasterror)
    end
    
    try
    		% Report Device ID
    		deviceIDStr = blanks(infoStrSize);
    		[getDeviceIDStrReturn, deviceIDStr] = calllib('BioRadio150DLL', 'GetDeviceIDString', deviceHandle, deviceIDStr, infoStrSize-1);
    		disp(sprintf('*BioRadio*  Device ID: %s', deviceIDStr));
    		    
    		% Report Firmware version
    		firmwareVersionStr = blanks(infoStrSize);
    		[getFirmwareVerStrReturn, firmwareVersionStr] = calllib('BioRadio150DLL', 'GetFirmwareVersionString', deviceHandle, firmwareVersionStr, infoStrSize-1);
    		disp(sprintf('*BioRadio*  Firmware version: %s', firmwareVersionStr));
    		
    		% Bring in global status variables
    		global BioRadio150_numEnabledFastInputs;
    		global BioRadio150_numEnabledSlowInputs;
    		global BioRadio150_fastDataReadSize;
    		global BioRadio150_slowDataReadSize;
    		
    		% Clear data files
    		if (BioRadio150_numEnabledFastInputs > 0)
    				dlmwrite(pathToFastDataOutputFile, []);
    		end
    		if (BioRadio150_numEnabledSlowInputs > 0)
    				dlmwrite(pathToSlowDataOutputFile, []);
    		end
    		
    		totalFastRead = 0;
    		totalSlowRead = 0;
    		
    		% Initialize plot
    		plotLength = 1000;
    		if (BioRadio150_numEnabledFastInputs < NumChannelsToPlot)
    			NumChannelsToPlot = BioRadio150_numEnabledFastInputs;
    		end
    		plotData = zeros(NumChannelsToPlot, plotLength);
    		plotHandle = plot(transpose(plotData));
    		xlabel('Samples');
    		ylabel('uV');
    		title('Real-time BioRadio Data');

    		% Acquire data (perform 50 reads,) plot chosen channels, and write to file
    		for repeatCount=1:50
    		  	[fastData, slowData] = BioRadio150_Read(deviceHandle);
    		  	
    		  	% Fast Input Data
    		  	if (BioRadio150_fastDataReadSize>0)
    		  			% Write data to file
    		  			totalFastRead = totalFastRead + BioRadio150_fastDataReadSize
    		  			disp(sprintf(' * %d fast points collected (%d total)', BioRadio150_fastDataReadSize, totalFastRead));
    		  			numFastSamples = BioRadio150_fastDataReadSize / BioRadio150_numEnabledFastInputs;
    		  			dlmwrite(pathToFastDataOutputFile, transpose(fastData(:, 1:numFastSamples)), '-append')

    						% Add data to plot
    						if (numFastSamples < plotLength)
    								% Shift current plot data and append new
    						  	plotData(:, 1:plotLength-numFastSamples) = plotData(:, numFastSamples+1:plotLength);
    						  	plotData(:, plotLength-numFastSamples+1:plotLength) = fastData(1:NumChannelsToPlot, 1:numFastSamples);
    						else
    								% Use only last plotLength points (size of plot)
    						  	plotData = fastData(1:NumChannelsToPlot, numFastSamples-plotLength+1:numFastSamples);
    						end
    						plot(transpose(plotData));
    		  	end
    		  	    
    		  	% Slow Input Data
    		  	if (BioRadio150_slowDataReadSize>0)
    		  			% Write data to file
    		  			totalSlowRead = totalSlowRead + BioRadio150_slowDataReadSize
    		  			disp(sprintf(' * %d slow points collected (%d total)', BioRadio150_slowDataReadSize, totalSlowRead));
    		  			numSlowSamples = BioRadio150_slowDataReadSize / BioRadio150_numEnabledSlowInputs;
    		  			dlmwrite(pathToSlowDataOutputFile, transpose(slowData(:, 1:numSlowSamples)), '-append' )
    		  	end
    		  	
    		  	pause(.080); % Wait 80ms between collections
    		end
    catch
      	BioRadio150_Stop(deviceHandle);
      	BioRadio150_Unload(deviceHandle);
      	rethrow(lasterror)
    end
    
    BioRadio150_Stop(deviceHandle);
    BioRadio150_Unload(deviceHandle);