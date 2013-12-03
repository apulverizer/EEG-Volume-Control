function tvolumecontrol(windowsvolume,matlabvolume)
%windows volume: between 0 and 1 (default 1)
%matlab volume: between 0 and 1 (default 1)

if ~exist('windowsvolume','var')
    windowsvolume=1;
end;
if ~exist('matlabvolume','var')
    matlabvolume=1;
end;

SetWindowsVolume(windowsvolume) %sets the master volume to 100% in Windows 7
SetMatlabVolume(matlabvolume) %sets the Matlab volume to 100% in Matlab