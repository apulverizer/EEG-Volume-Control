function [Data] = ExtractBCIData(filePath,Fs )
% ExtractBCIData Extracts raw data from the BCI (gdf) file based on event
% types. 
% Input:
%   filePath: The path to the file to read
%   FS:       The frequecy of the data
% Output:
%   Data: A structure with Class1 and Class2 data
%
% Author: Aaron Pulver 12/4/13

numSeconds=2;
startOffsetSeconds =0;
% each column if one instance of the user performing the class 
class1DataCh1 = [];
class2DataCh1 = [];
class1DataCh2 = [];
class2DataCh2 = [];

for j=1:size(filePath,1)
    
    [s, h] = sload(filePath(j));

    % Get metadata about event positions and types
    class1MetaData = [];
    class2MetaData = [];
    for i=1:length(h.EVENT.TYP)
        if(h.EVENT.TYP(i) == 769)
            class1MetaData= [h.EVENT.TYP(i) h.EVENT.POS(i) h.EVENT.DUR(i) h.EVENT.CHN(i); class1MetaData];
        elseif(h.EVENT.TYP(i) == 770)
            class2MetaData =[h.EVENT.TYP(i) h.EVENT.POS(i) h.EVENT.DUR(i) h.EVENT.CHN(i); class2MetaData];
        end
    end

    % foreach each class 1 in the data
    for i=1: length(class1MetaData)
         data =[];
         % from the start of the cue until the end (Fs sample/sec * 4s)
         for j=class1MetaData(i,2)+(startOffsetSeconds*Fs):class1MetaData(i,2)+(Fs*numSeconds)-1
             data = [s(j,1); data];
         end
         % append to the matrix
         class1DataCh1 = [class1DataCh1 data];
    end
    % Channel 2 class 1
    for i=1: length(class1MetaData)
         data =[];
         % from the start of the cue until the end (Fs sample/sec * 4s)
         for j=class1MetaData(i,2)+(startOffsetSeconds*Fs):class1MetaData(i,2)+(Fs*numSeconds)-1
             data = [s(j,2); data];
         end
         % append to the matrix
         class1DataCh2 = [class1DataCh2 data];
    end

    % for each class 2 in the data
    % Class 2 Channel 1
    for i=1: length(class2MetaData)
         data =[];
         % from the start of the cue until the end (Fs sample/sec * 4s)
         for j=class2MetaData(i,2)+(startOffsetSeconds*Fs):class2MetaData(i,2)+(Fs*numSeconds)-1
             data = [s(j,1); data];
         end
         % append to the matrix
         class2DataCh1 = [class2DataCh1 data];
    end
    % Class 2 Channel 2
    for i=1: length(class2MetaData)
         data =[];
         % from the start of the cue until the end (Fs sample/sec * 4s)
         for j=class2MetaData(i,2)+(startOffsetSeconds*Fs):class2MetaData(i,2)+(Fs*numSeconds)-1
             data = [s(j,2); data];
         end
         % append to the matrix
         class2DataCh2 = [class2DataCh2 data];
    end
end
Data.Class1.Ch1=class1DataCh1;
Data.Class1.Ch2=class1DataCh2;
Data.Class2.Ch1=class2DataCh1;
Data.Class2.Ch2=class2DataCh2;

