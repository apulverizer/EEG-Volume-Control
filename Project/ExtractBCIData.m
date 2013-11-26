function [Data] = ExtractBCIData(filePath )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

numSeconds=2.5;
startOffsetSeconds =.5;
% each column if one instance of the user performing the class 
class1DataCh1 = [];
class2DataCh1 = [];
class1DataCh2 = [];
class2DataCh2 = [];
class1DataCh3 = [];
class2DataCh3 = [];

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
         % from the start of the cue until the end (250 sample/sec * 4s)
         for j=class1MetaData(i,2)+(startOffsetSeconds*250):class1MetaData(i,2)+(250*numSeconds)-1
             data = [s(j,1); data];
         end
         % append to the matrix
         class1DataCh1 = [class1DataCh1 data];
    end
    % Channel 2 class 1
    for i=1: length(class1MetaData)
         data =[];
         % from the start of the cue until the end (250 sample/sec * 4s)
         for j=class1MetaData(i,2)+(startOffsetSeconds*250):class1MetaData(i,2)+(250*numSeconds)-1
             data = [s(j,2); data];
         end
         % append to the matrix
         class1DataCh2 = [class1DataCh2 data];
    end
    % Channel 3 class 1
    for i=1: length(class1MetaData)
         data =[];
         % from the start of the cue until the end (250 sample/sec * 4s)
         for j=class1MetaData(i,2)+(startOffsetSeconds*250):class1MetaData(i,2)+(250*numSeconds)-1
             data = [s(j,3); data];
         end
         % append to the matrix
         class1DataCh3 = [class1DataCh3 data];
    end

    % for each class 2 in the data
    % Class 2 Channel 1
    for i=1: length(class2MetaData)
         data =[];
         % from the start of the cue until the end (250 sample/sec * 4s)
         for j=class2MetaData(i,2)+(startOffsetSeconds*250):class2MetaData(i,2)+(250*numSeconds)-1
             data = [s(j,1); data];
         end
         % append to the matrix
         class2DataCh1 = [class2DataCh1 data];
    end
    % Class 2 Channel 2
    for i=1: length(class2MetaData)
         data =[];
         % from the start of the cue until the end (250 sample/sec * 4s)
         for j=class2MetaData(i,2)+(startOffsetSeconds*250):class2MetaData(i,2)+(250*numSeconds)-1
             data = [s(j,2); data];
         end
         % append to the matrix
         class2DataCh2 = [class2DataCh2 data];
    end
    % Class 2 Channel 3
    for i=1: length(class2MetaData)
         data =[];
         % from the start of the cue until the end (250 sample/sec * 4s)
         for j=class2MetaData(i,2)+(startOffsetSeconds*250):class2MetaData(i,2)+(250*numSeconds)-1
             data = [s(j,3); data];
         end
         % append to the matrix
         class2DataCh3 = [class2DataCh3 data];
    end
end
Data.Class1.Ch1=class1DataCh1;
Data.Class1.Ch2=class1DataCh2;
Data.Class1.Ch3=class1DataCh3;
Data.Class2.Ch1=class2DataCh1;
Data.Class2.Ch2=class2DataCh2;
Data.Class2.Ch3=class2DataCh3;

