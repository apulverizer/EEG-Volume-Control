function BioRadio150_RTPlot(pathToDllDirectory, pathToConfigFile)
%----
%BIORADIO150_RTPlot Example of acquiring and displaying BioRadio data in real-time
%
%   BIORADIO150_RTPlot(portName, pathToDllDirectory, pathToConfigFile)
%   uses the main BioRadio MATLAB functions to Load, Start, Configure and 
%   repeatedly Read incoming BioRadio data, and maintains a live data plot
%   of the first fast data channel.  When finished, it Stops communication 
%   and Unloads the BioRadio library.
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_PING,
%BIORADIO150_READ, BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----

    % Ensure all arguments are specified
    if (nargin ~= 2)
        error('Usage: BioRadio150_RTPlot(<pathToDllDirectory>, <pathToConfigFile>)');
    end
    
    % Load the library
    try
        deviceHandle = BioRadio150_Load(pathToDllDirectory);
    catch
        rethrow(lasterror)
    end

    % Report DLL version
    infoStrSize = 20;
    dllVersionString = blanks(infoStrSize);
    dllVersionString = calllib('BioRadio150DLL', 'GetDLLVersionString', dllVersionString, infoStrSize-1);
    disp(sprintf('*BioRadio*  DLL version: %s', dllVersionString));

		% Find devices, and use the first one found
    deviceComPorts = BioRadio150_Find(pathToDllDirectory);
		if (length(deviceComPorts) <= 0)
				disp('*BioRadio*	no devices found; aborting');
				BioRadio150_Unload(deviceHandle);
				return;
		end
		portName = char(deviceComPorts(1));
		disp(sprintf('*BioRadio*	using %s', portName));

		% Start BioRadio data acquisition
    try
        BioRadio150_Start(deviceHandle, portName, 1, pathToConfigFile);
    catch
        BioRadio150_Unload(deviceHandle);
        rethrow(lasterror)
    end
    
    % Report Device ID
		deviceIDStr = blanks(infoStrSize);
		[getDeviceIDStrReturn, deviceIDStr] = calllib('BioRadio150DLL', 'GetDeviceIDString', deviceHandle, deviceIDStr, infoStrSize-1);
		disp(sprintf('*BioRadio*	Device ID: %s', deviceIDStr));
		    
    % Report Firmware version
		firmwareVersionStr = blanks(infoStrSize);
		[getFirmwareVerStrReturn, firmwareVersionStr] = calllib('BioRadio150DLL', 'GetFirmwareVersionString', deviceHandle, firmwareVersionStr, infoStrSize-1);
		disp(sprintf('*BioRadio*	Firmware version: %s', firmwareVersionStr));
    
    % Bring in global status variables
    global BioRadio150_numEnabledFastInputs;
    global BioRadio150_numEnabledSlowInputs;
    global BioRadio150_fastDataReadSize;
    global BioRadio150_slowDataReadSize;
    
    totalFastRead = 0;
    totalSlowRead = 0;

    % Initialize plot
    plotLength = 1000;
    plotChannels = 4;
    if (BioRadio150_numEnabledFastInputs < plotChannels)
    	plotChannels = BioRadio150_numEnabledFastInputs;
    end
    plotData = zeros(plotChannels, plotLength);
    plotHandle = plot(transpose(plotData));
    xlabel('Samples');
    ylabel('uV');
    title('Real-time BioRadio Data');
    
    % Acquire data and plot
    try
    		% Perform 50 Reads
    		for repeatCount=1:50
    				[fastData, slowData] = BioRadio150_Read(deviceHandle);
    				
    				if (BioRadio150_fastDataReadSize > 0)
    				  	totalFastRead = totalFastRead + BioRadio150_fastDataReadSize
    				  	disp(sprintf(' * %d fast points collected (%d total)', BioRadio150_fastDataReadSize, totalFastRead));
    				  	numSamples = BioRadio150_fastDataReadSize / BioRadio150_numEnabledFastInputs;
    				  	
    				  	% Add new data to plot
    				  	if (numSamples < plotLength)
    				  			% Shift current plot data and append new
    				  	  	plotData(:, 1:plotLength-numSamples) = plotData(:, numSamples+1:plotLength);
    				  	  	plotData(:, plotLength-numSamples+1:plotLength) = fastData(1:plotChannels, 1:numSamples);
    				  	else
    				  			% Use only last plotLength points (size of plot)
    				  	  	plotData = fastData(1:plotChannels, numSamples-plotLength+1:numSamples);
    				  	end
    				  	plot(transpose(plotData));
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
