function f = BioRadio150_Ping(deviceHandle)
%----
%BIORADIO150_PING  Ping BioRadio device configuration
%
%   BIORADIO150_PING(deviceHandle) retrieves the BioRadio device's
%   configuration, to populate the software object.
%
%Prerequisite calls:
%   BioRadio150_Load
%   BioRadio150_Start
%
%Example:
%   BioRadio150_Ping(deviceHandle, 'C:\CleveMed\BioRadio\TestConf.ini')
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_READ,
%BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----
    
    if (nargin ~= 1)    % Ensure an argument is specified
        error('Usage: BioRadio150_Ping(<deviceHandle>)');
    end
    
    if ~libisloaded('BioRadio150DLL')
        error('Call BioRadio150_Load before starting device communication.');
    end

    if ~calllib('BioRadio150DLL', 'PingConfig', deviceHandle, 1)
        error('BioRadio150DLL->PingConfig exited with an error. If data acquisition started properly, try again, or try programming.');
    end
    disp('*BioRadio*	device configuration pinged');