function SetWindowsVolume(proportion)
%proportion = 0 to 1 (in Windows 7's scaling), default is 1

oldcd=cd;
thisfilename=mfilename('fullpath');
lastslash=find(thisfilename==filesep,1,'last');
thisfolder=thisfilename(1:(lastslash-1));
cd(thisfolder);
if exist('proportion','var')
    system(sprintf('SetWindowsVolume.exe %f',proportion));
else
    system(sprintf('SetWindowsVolume.exe')); %default is full volume
end;
cd(oldcd)