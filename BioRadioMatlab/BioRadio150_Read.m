function [FastInputsData, SlowInputsData] = BioRadio150_Read(deviceHandle)
%----
%BIORADIO150_READ  Read & return acquired BioRadio data
%
%   BIORADIO150_READ(deviceHandle) retrieves available BioRadio data from the buffer,
%   returning it in matrix form in rows by input channel (max 65536 columns)
%
%Prerequisite calls:
%   BioRadio150_Load
%   BioRadio150_Start
%
%See also BIORADIO150_LOAD, BIORADIO150_FIND, BIORADIO150_START, BIORADIO150_PING, BIORADIO150_PROGRAM,
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
    global BioRadio150_fastDataReadSize;
    global BioRadio150_fastDataReadSizePtr;
    global BioRadio150_slowDataReadSize;
    global BioRadio150_slowDataReadSizePtr;
    global BioRadio150_fastData;
    global BioRadio150_fastDataPtr;
    global BioRadio150_slowData;
    global BioRadio150_slowDataPtr;
    
    % Read from buffer
    try
        NumToBeRead = calllib('BioRadio150DLL', 'TransferBuffer', deviceHandle);
        calllib('BioRadio150DLL', 'ReadScaledFastAndSlowData', deviceHandle, BioRadio150_fastDataPtr, BioRadio150_fastDataBufSize, BioRadio150_fastDataReadSizePtr, BioRadio150_slowDataPtr, BioRadio150_slowDataBufSize, BioRadio150_slowDataReadSizePtr);
        if(BioRadio150_fastDataBufSize>0)
            BioRadio150_fastData = get(BioRadio150_fastDataPtr, 'Value');
        end
        if(BioRadio150_slowDataBufSize>0)
            BioRadio150_slowData = get(BioRadio150_slowDataPtr, 'Value');
        end
    catch
        BioRadio150_Stop(deviceHandle);
        rethrow(lasterror)
    end

    % Amount of data returned
    BioRadio150_fastDataReadSize = double(get(BioRadio150_fastDataReadSizePtr, 'Value'));
    BioRadio150_slowDataReadSize = double(get(BioRadio150_slowDataReadSizePtr, 'Value'));

    % Check TransferBuffer return against ReadSize
    if(NumToBeRead ~= BioRadio150_fastDataReadSize)
        disp(sprintf('debug TfrBuf=%d != ReadReturn=%d', NumToBeRead, BioRadio150_fastDataReadSize));
    end
    
    if(BioRadio150_fastDataReadSize > 0)
        FastInputsData = zeros(BioRadio150_numEnabledFastInputs, BioRadio150_bufSizePerFastInput);
        FastInputsData(1:BioRadio150_fastDataReadSize) = BioRadio150_fastData(1:BioRadio150_fastDataReadSize);
    else
        FastInputsData = zeros(0,0);
    end
    
    if(BioRadio150_slowDataReadSize > 0)
        SlowInputsData = zeros(BioRadio150_numEnabledSlowInputs, BioRadio150_bufSizePerSlowInput);
        SlowInputsData(1:BioRadio150_slowDataReadSize) = BioRadio150_slowData(1:BioRadio150_slowDataReadSize);
    else
        SlowInputsData = zeros(0,0);
    end