function deviceHandle = BioRadio150_Load(pathToDllDirectory, useLegacyComputerUnit)
%----
%BIORADIO150_LOAD  Load BioRadio software interface
%
%   BIORADIO150_LOAD(pathToDllDirectory, useLegacyComputerUnit) loads the BioRadio
%   DLL to allow the calling of its library functions, and prepares
%   necessary data structures for use by those functions.  If you are using
%   a legacy Computer Unit, set useLegacyComputerUnit to true.  Otherwise,
%   set to false.
%
%
%Example:
%   BioRadio150_Load('C:\CleveMed\BioRadio', true)
%
%See also BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PROGRAM, BIORADIO150_PING, BIORADIO150_READ,
%BIORADIO150_STOP, BIORADIO150_UNLOAD
%
%Copyright 2004-2007, Cleveland Medical Devices Inc., http://www.CleveMed.com
%----
    
    % Ensure one argument is specified
    if (nargin ~= 2)
        error('Usage: BioRadio150_Load(<pathToDllDirectory>)');
    end

    % Load the library if not already loaded
    if (~libisloaded('BioRadio150DLL'))
    		if ~(exist(pathToDllDirectory, 'dir') == 7)
    		    error('''%s'' is not a valid directory', pathToDllDirectory);
    		end
    		addpath(pathToDllDirectory);
        loadlibrary('BioRadio150DLL', 'BioRadio150DLL.h');
    end

    deviceHandle = calllib('BioRadio150DLL', 'CreateBioRadio', useLegacyComputerUnit);
    disp(sprintf('*BioRadio* library loaded. Handle: %d', deviceHandle));

    global BioRadio150_bufSizePerFastInput;
    global BioRadio150_bufSizePerSlowInput;
    global BioRadio150_fastDataReadSizePtr;
    global BioRadio150_slowDataReadSizePtr;
    
    BioRadio150_bufSizePerFastInput = 65540;
    BioRadio150_bufSizePerSlowInput = BioRadio150_bufSizePerFastInput/10;
    readSize = int32(0);
    BioRadio150_fastDataReadSizePtr = libpointer('int32Ptr', readSize);
    BioRadio150_slowDataReadSizePtr = libpointer('int32Ptr', readSize);