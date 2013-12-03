function BioRadio150_Unload(deviceHandle)
%----
%BIORADIO150_UNLOAD    Unload BioRadio software interface
%
%   BIORADIO150_UNLOAD(deviceHandle) unloads the BioRadio DLL
%
%Prerequisite calls:
%   BioRadio150_Load
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_PING,
%BIORADIO150_READ, BIORADIO150_STOP
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----

    if (nargin ~= 1)    % Ensure an argument is specified
        error('Usage: BioRadio150_Unload(<deviceHandle>)');
    end
    
    if libisloaded('BioRadio150DLL')
        calllib('BioRadio150DLL', 'DestroyBioRadio', deviceHandle);
        unloadlibrary('BioRadio150DLL');
        disp('*BioRadio*	library unloaded');
    end