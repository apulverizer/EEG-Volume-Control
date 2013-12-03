function BioRadio150_Stop(deviceHandle)
%----
%BIORADIO150_STOP  End BioRadio acquisition and communication
%
%   BIORADIO150_STOP(deviceHandle) ends collecting BioRadio data at the serial port
%
%Prerequisite calls:
%   BioRadio150_Load
%   BioRadio150_Start
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_PING,
%BIORADIO150_READ, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----

    if (nargin ~= 1)    % Ensure an argument is specified
        error('Usage: BioRadio150_Stop(<deviceHandle>)');
    end
    
    if ~libisloaded('BioRadio150DLL')
        error('Call BioRadio150_Load before communicating with BioRadio.');
    end

    if (calllib('BioRadio150DLL', 'StopAcq', deviceHandle))
        disp('*BioRadio*	data acquisition stopped');
    else
        disp('*BioRadio*	failed to stop acquisition');
    end
    
    if (calllib('BioRadio150DLL', 'StopCommunication', deviceHandle))
        disp('*BioRadio*	base communication stopped');
    else
        disp('*BioRadio*	failed to stop base communication');
    end