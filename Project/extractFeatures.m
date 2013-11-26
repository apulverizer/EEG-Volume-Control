function [ features ] = extractFeatures(RawData, AlphaFilter, BetaFilter)

Fs=250; % sampling feq
[B,A] = butter(4,[1 30]/Fs*2);
filteredData = log(filter(ones(Fs,1),Fs,filter(B,A,double(RawData)).^2 ));

bp = bandpower(RawData,250,[8,14;14,30],1,4);
%bp = bandpower(RawData,250,[8,10;10,12;12,14;14,16;16,18;18,20;20,22;22,24],1,4);
features = [mean(bp)];

% Y=fft(y);
% features = abs(Y(8:24))';


% 
% Wp = [4 30]/(Fs/2);
% Ws = [1 40]/(Fs/2);
% Rp=3; Rs=40;
% [n,Wn]=buttord(Wp,Ws,Rp,Rs);
% [b,a]=butter(n,Wn);
% y=filter(b,a,RawData);
% %y=RawData;
% 
% 
% NFFT = 2^nextpow2(L);
% Y=fft(y,NFFT)/L;
% features = (abs(Y(8:24)));
end

