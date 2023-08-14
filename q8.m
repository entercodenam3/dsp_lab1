[y,Fs] = audioread("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-1\Experiment-1\speech.wav");
t=linspace(0,length(y)/Fs,length(y));
Nfft=16777216; %power of 2 and I put a huge number so there are many data point
f=linspace(0,Fs,Nfft);
X1=abs(fft(y,Nfft));
figure(2);
plot(f(1:Nfft),X1(1:Nfft))
xlabel('Frequency'); 
ylabel ('amp');
title ('FFT Spectrum');