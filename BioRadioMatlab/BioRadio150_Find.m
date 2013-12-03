function Devices = BioRadio150_Find
%----
%BIORADIO150_FIND Find attached BioRadio 150 Computer Units
%
%   BIORADIO150_FIND searches and reports on all
%   attached and available BioRadio 150 Computer Units, returning a
%   cell array of strings of port names of each device found.
%
%Prerequisite calls:
%   BioRadio150_Load
%
%See also BIORADIO150_LOAD, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_PING,
%BIORADIO150_READ, BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----
    
    % deviceStrList = libpointer('charPtrPtr');
		maxDevices = 8;
    portNameStrLen = 10;
    
    % array of garbage-filled strings
    % don't use "blanks()" because cellstr will remove whitespace and shorten length
    deviceStr = char(ones(1,portNameStrLen+1));
    devicesCharArrList = repmat(char(ones(maxDevices,1)), 1, portNameStrLen+1);
    
    devicesCellArrStrs = cellstr(devicesCharArrList);
		devicesCharArrListStrPtr = libpointer('stringPtrPtr', devicesCellArrStrs);
		
    deviceCount = 0;
		deviceCountPtr = libpointer('int32Ptr', deviceCount);
		
    try
    		[findDevicesSimpleReturn, devicesCharArrListStrPtr, deviceCount] = calllib('BioRadio150DLL', 'FindDevicesSimple', devicesCharArrListStrPtr, deviceCountPtr, maxDevices, portNameStrLen);
    catch
    		error('BioRadio150DLL->FindDevicesSimple() exited with an error');
    end
    Devices = devicesCharArrListStrPtr(1:deviceCount,:);
    disp(sprintf('*BioRadio*	%d devices found:', deviceCount));
    disp(char(Devices));