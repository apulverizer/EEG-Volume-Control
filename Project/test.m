% Fs=960; % sampling feq
% T=1/Fs; % sample period
% L=960;
% t=(0:L-1)*T;
% NFFT = 2^nextpow2(L);
% for i=1:1
%     y=filter(FilterAlphaBeta,CollectedData.Ch1(i,:));
%     Y=fft(y,NFFT)/L;
%     f=Fs/2*linspace(0,1,NFFT/2+1);
%     %plot(f,2*abs(Y(1:NFFT/2+1)));
%     plot(1:35,2*abs(Y(1:35)));
%     hold on
% end
% title('Loud Music - C3');
% xlabel('Frequency (Hz)');
% ylabel('|Y(f)|');
% figure
% for i=691:-1:690
%     y=filter(FilterAlphaBeta,CollectedData.Ch1(i,:));
%     Y=fft(y,NFFT)/L;
%     f=Fs/2*linspace(0,1,NFFT/2+1);
%     %plot(f,2*abs(Y(1:NFFT/2+1)));
%     plot(1:35,2*abs(Y(1:35)));
%     hold on
% end
% title('Quiet Music - C3');
% xlabel('Frequency (Hz)');
% ylabel('|Y(f)|');
% 
% figure
% fprintf('Avg alpha bandpower Loud-C3: %f\n',mean(alphaBandLoud));
% fprintf('Avg beta bandpower Loud-C3: %f\n',mean(betaBandLoud));
% fprintf('Avg alpha bandpower Quiet-C3: %f\n',mean(alphaBandLoud));
% fprintf('Avg beta bandpower Quiet-C3: %f\n',mean(betaBandLoud));

Xmin=0;
Xmax=size(BCIData.Features,2);
Ymin=min(min(BCIData.Features));
Ymax=max(max(BCIData.Features));
close all;
plot(BCIData.Features(3,:))
hold on
plot(BCIData.Features(1,:),'r')
axis([Xmin,Xmax,Ymin,Ymax]);
hold off

figure
plot(BCIData.Features(4,:))
hold on
plot(BCIData.Features(2,:),'r')
axis([Xmin,Xmax,Ymin,Ymax]);
hold off

figure
plot(BCIData.Features(8,:))
hold on
plot(BCIData.Features(5,:),'r')
axis([Xmin,Xmax,Ymin,Ymax]);
hold off

figure
plot(BCIData.Features(9,:))
hold on
plot(BCIData.Features(10,:),'r')
axis([Xmin,Xmax,Ymin,Ymax]);

figure
plot(BCIData.Features(400,:))
hold on
plot(BCIData.Features(399,:),'r')
axis([Xmin,Xmax,Ymin,Ymax]);
hold off

