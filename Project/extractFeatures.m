function [ features ] = extractFeatures(RawData)

Fs=250; % sampling feq
[B,A] = butter(4,[1 30]/Fs*2);
filteredData = log(filter(ones(Fs,1),Fs,filter(B,A,double(RawData)).^2 ));

bp = bandpower(RawData,250,[8,14;14,30],1,4);
%bp = bandpower(RawData,250,[8,10;10,12;12,14;14,16;16,18;18,20;20,22;22,24],1,4);
features = [mean(bp)];

% Y=fft(filteredData);
% features = abs(Y(8:24))';

end

