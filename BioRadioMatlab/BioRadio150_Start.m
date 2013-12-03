function BioRadio150_Start(deviceHandle, portName, programDevice, pathToConfigFile)
%----
%BIORADIO150_START Begin BioRadio communication and acquisition
%
%   BIORADIO150_START(deviceHandle, portName, programDevice, pathToConfigFile) programs
%   or pings the BioRadio's configuration, then begins collecting data at
%   the serial port from the BioRadio. BioRadio150_Load must be called first.
%
%   Once acquisition is started, data should be continuously
%   collected from the serial port, using BioRadio150_Read
%
%Prerequisite calls:
%   BioRadio150_Load
%
%Examples:
%   BioRadio150_Start(deviceHandle, 'COM1', 1, 'C:\CleveMed\BioRadio\TestConf.ini')
%   BioRadio150_Start(deviceHandle, 'COM1', 0)
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_PROGRAM, BIORADIO150_PING, BIORADIO150_READ,
%BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----

    % Establish global variables
    global BioRadio150_numEnabledFastInputs;
    global BioRadio150_numEnabledSlowInputs;
    global BioRadio150_bufSizePerFastInput;
    global BioRadio150_bufSizePerSlowInput;
    global BioRadio150_fastDataBufSize;
    global BioRadio150_slowDataBufSize;
    global BioRadio150_fastData;
    global BioRadio150_fastDataPtr;
    global BioRadio150_slowData;
    global BioRadio150_slowDataPtr;

    % Ensure correct number of arguments are specified    
    if (nargin < 3)
        error('Usage: BioRadio150_Start(<deviceHandle>, <portName>, <programDevice(0,1)> [, <pathToConfigFile (if programDevice)>])');
    end
    if (nargin ~= (3 + programDevice))
        error('Usage: BioRadio150_Start(<deviceHandle>, <portName>, <programDevice(0,1)> [, <pathToConfigFile (if programDevice)>])');
    end
    
    if ~libisloaded('BioRadio150DLL')
        error('Call BioRadio150_Load before communicating with BioRadio.');
    end
    
    try
        disp('Starting communication...');
    		if (calllib('BioRadio150DLL', 'StartCommunication', deviceHandle, portName) <= 0)
        		error('BioRadio150DLL->StartCommunication() exited in failure. Check that portName and deviceHandle parameters are correct.');
    		end
    catch
        error('BioRadio150DLL->StartCommunication() exited with an error. Check that portName and deviceHandle parameters are correct.');
    end
    disp('*BioRadio*	base communication started');

    try
    		if (calllib('BioRadio150DLL', 'StartAcq', deviceHandle, 1) <= 0)
        		error('BioRadio150DLL->StartAcq() exited in failure. Check that the User Unit is powered on and in range.');
        end
    catch
        calllib('BioRadio150DLL', 'StopCommunication', deviceHandle);
        disp('*BioRadio*	base communication stopped');
        error('BioRadio150DLL->StartAcq() exited with an error. Check that the User Unit is powered on and in range.');
    end
    disp('*BioRadio*	data acquisition started');

    if (programDevice)
        try
            BioRadio150_Program(deviceHandle, pathToConfigFile);
        catch   % Stop acquisition if Program failed
            BioRadio150_Stop(deviceHandle);
            rethrow(lasterror)
        end
    end
    
    BioRadio150_numEnabledFastInputs = calllib('BioRadio150DLL', 'GetNumEnabledFastInputs', deviceHandle);
    disp(sprintf('*BioRadio*	num enabled fast inputs: %d', BioRadio150_numEnabledFastInputs));
    BioRadio150_fastDataBufSize = BioRadio150_bufSizePerFastInput * BioRadio150_numEnabledFastInputs;
    BioRadio150_fastData = zeros(BioRadio150_fastDataBufSize, 1);
    BioRadio150_fastDataPtr = libpointer('doublePtr', BioRadio150_fastData);

    BioRadio150_numEnabledSlowInputs = calllib('BioRadio150DLL', 'GetNumEnabledSlowInputs', deviceHandle);
    disp(sprintf('*BioRadio*	num enabled slow inputs: %d', BioRadio150_numEnabledSlowInputs));
    BioRadio150_slowDataBufSize = BioRadio150_bufSizePerSlowInput * BioRadio150_numEnabledSlowInputs;
    BioRadio150_slowData = zeros(BioRadio150_slowDataBufSize, 1);
    BioRadio150_slowDataPtr = libpointer('uint16Ptr', BioRadio150_slowData);