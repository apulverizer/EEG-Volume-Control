%%  ��������Mallat�㷨ʵ��С���任
%%  �����    ɳ��(Wei Sha) ���մ�ѧ(Anhui University) ws108@ahu.edu.cn

clc;clear;

%  1.���Ҳ�����
f1=50;  %  Ƶ��1
f2=100; %  Ƶ��2
fs=2*(f1+f2);  %  ����Ƶ��
Ts=1/fs;  %  �������
N=120;    %  ��������

n=1:N;
y=sin(2*pi*f1*n*Ts)+sin(2*pi*f2*n*Ts);  %  ���Ҳ����

figure(1)
subplot(2,1,1)
plot(y);
title('Signal')
subplot(2,1,2)
stem(abs(fft(y)));
title('Amplitude Spectrum')

%%  2.С���˲����׷���
h=wfilters('db30','l');  %  ��ͨ
g=wfilters('db30','h');  %  ��ͨ

h=[h,zeros(1,N-length(h))];  %  ���㣨Բ�ܾ����������ֱ��ʱ��ڹ۲죩
g=[g,zeros(1,N-length(g))];  %  ���㣨Բ�ܾ����������ֱ��ʱ��ڹ۲죩

figure(3);
subplot(2,1,1)
stem(abs(fft(h)));
title('Low-pass Filter(V_{0})')

subplot(2,1,2)
stem(abs(fft(g)));
title('High-pass Filter(W_{0})')

%  3.MALLET�ֽ��㷨(Բ�ܾ���Ŀ��ٸ���Ҷ�任ʵ��)
sig1=ifft(fft(y).*fft(h));  %  ��ͨ(��Ƶ����)
sig2=ifft(fft(y).*fft(g));  %  ��ͨ(��Ƶ����)

figure(5);  %  �ź�ͼ
subplot(2,1,1)
plot(real(sig1));
title('Low-frequency Component')

subplot(2,1,2)
plot(real(sig2));
title('High-frequency Component')

figure(6);  %  Ƶ��ͼ
subplot(2,1,1)
stem(abs(fft(sig1)));
title('Amplitude Spectrum of Low-frequency Component')

subplot(2,1,2)
stem(abs(fft(sig2)));
title('Amplitude Spectrum of High-frequency Component')

%%  4.MALLET�ع��㷨
sig1=dyaddown(sig1); %  2��ȡ
sig2=dyaddown(sig2); %  2��ȡ

sig1=dyadup(sig1);   %  2��ֵ
sig2=dyadup(sig2);   %  2��ֵ
sig1=sig1(1,[1:N]);  %  ȥ�����һ����
sig2=sig2(1,[1:N]);  %  ȥ�����һ����

hr=h(end:-1:1);         %  �ع���ͨ
gr=g(end:-1:1);         %  �ع���ͨ
hr=circshift(hr',1)';   %  λ�õ���Բ������һλ
gr=circshift(gr',1)';   %  λ�õ���Բ������һλ

sig1=ifft(fft(hr).*fft(sig1));  %  ��Ƶ
sig2=ifft(fft(gr).*fft(sig2));  %  ��Ƶ
sig=sig1+sig2; %  Դ�ź�

%%  5.�Ƚ�
figure(7);
subplot(2,1,1)
plot(real(sig1));
title('Reconstructed Low-frequency Signal');
subplot(2,1,2)
plot(real(sig2));
title('Reconstructed High-frequency Signal');

figure(8);
subplot(2,1,1)
stem(abs(fft(sig1)));
title('Spectra of the Reconstructed Low-frequency Signal');
subplot(2,1,2)
stem(abs(fft(sig2)));
title('Spectra of the Reconstructed High-frequency Signal');

figure(9)
plot(real(sig),'r','linewidth',2);
hold on;
plot(y);
legend('Reconstructed Signal','Original Signal')
title('Comparisons between Original Signal and Reconstructed Signal')










