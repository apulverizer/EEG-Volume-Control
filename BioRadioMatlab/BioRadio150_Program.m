function BioRadio150_Program(deviceHandle, pathToConfigFile)
%----
%BIORADIO150_PROGRAM  Program BioRadio device configuration
%
%   BIORADIO150_PROGRAM(deviceHandle, pathToConfigFile) programs the loaded BioRadio
%   device to the configuration specified in the file-path input.
%
%Prerequisite calls:
%   BioRadio150_Load
%   BioRadio150_Start (BioRadio150_Start optionally calls this function)
%
%Example:
%   BioRadio150_Program(deviceHandle, 'C:\CleveMed\BioRadio\TestConf.ini')
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PING, BIORADIO150_READ,
%BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----

    if (nargin ~= 2)    % Ensure 2 arguments are specified
        error('Usage: BioRadio150_Program(<deviceHandle>, <pathToConfigFile>)');
    end
    
    if ~libisloaded('BioRadio150DLL')
        error('Call BioRadio150_Load before starting device communication.');
    end
    
    if ~(exist(pathToConfigFile, 'file') == 2)
        error('Config file ''%s'' does not exist', pathToConfigFile);
    end
    
    if ~calllib('BioRadio150DLL', 'ProgramConfig', deviceHandle, 1, pathToConfigFile)
        error('BioRadio150DLL->ProgramConfig exited with an error. If data acquisition started properly, try again and/or try another config file.');
    end
    disp('*BioRadio*: device programmed to specified configuration');