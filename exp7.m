a = 1+mod(257,3);

%%

%problem-1(a)

%fs = 200;
%t = 0 : (1/fs) : 10-(1/fs);
bl = blackman(200);
hn = hanning(200);
hm = hamming(200);
rw = rectwin(200);

subplot(2,2,1);
plot(hn)
title("Hanning");
ylabel("Amplitude");
xlabel("Time");
subplot(2,2,2);
plot(hm)
title("Hamming");
ylabel("Amplitude");
xlabel("Time");
subplot(2,2,3);
plot(rw)
title("Rectangular");
ylabel("Amplitude");
xlabel("Time");



%% 
clc
%problem-1(b)

% a=3 - Hamming Window

n = 1024;
l = [100,200,300];

for i = l
    hm = hamming(i);  
    fft_w = fftshift(fft(hm,n));
    abs_w = abs(fft_w);
    norm_amp = abs(abs_w)/i;
    freq = ((-length(norm_amp)/2):((length(norm_amp)/2)-1))/length(norm_amp);
    figure;
    plot(freq,20*log(norm_amp))
    int2str(i)
    title("Bode Plots for Length = ",i);
    xlabel("Frequency");
    ylabel("Mangnitude (dB)");
end

for i = l
    hm = hamming(i);  
    fft_w = fftshift(fft(hm,n));
    abs_w = abs(fft_w);
    norm_amp = abs(abs_w)/i;
    freq = ((-length(norm_amp)/2):((length(norm_amp)/2)-1))/length(norm_amp);
    figure;
    plot(freq,norm_amp)
    int2str(i)
    title("Spectrum for Length = ",i);
    xlabel("Frequency");
    ylabel("Mangnitude (dB)");
end

%%

%problem-2

a = 1+mod(257,3);
wc = pi/(a+1);
l = 21;
w_rec = rectwin(l);
hm = hamming(l);

r_filter = fir1(l-1,wc/pi,"low",w_rec);
w_filter = fir1(l-1,wc/pi,"low",hm);
figure;
freqz(w_filter,1)
title("Bode plot of Hamming Window Filter")
figure;
freqz(r_filter,1)
title("Bode plot of Rectangular Window Filter")
figure;
impz(w_filter)
title("Impulse Response of Hamming Window Filter")
figure;
impz(r_filter)
title("Impulse Response of Rectangular Window Filter")

%%

%problem-3

clc

[x,Fs] = audioread("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-5\Experiment-5\instru3.wav");
m = abs(fft(x));
F = (0:length(m)-1)*Fs/length(m);
figure;
plot(F,m)
title('Instrument-3')
xlabel("Frequency");
ylabel("Amplitude");
fft1 = fft(x);
l1 = length(fft1);
mag1 = abs(fft1);
freq = (0:(l1-1))*(Fs/l1);
[~,peak] = max(mag1);
fund_f1 = freq(peak);


window_length = 100; 
overlap = 10;        
window_length_2 = 150;
fund_f = 775;
l = fund_f-40;
h = fund_f+40;
[A,B,C,D] = butter(8,[l h]/(Fs/2),"bandpass");
d1 = designfilt("bandpassiir",FilterOrder=8,HalfPowerFrequency1=l,HalfPowerFrequency2=h,SampleRate=Fs);
sos = ss2sos(A,B,C,D);


filtered_audio = filtfilt(d1,x);
audiowrite('filtered_audio.wav', filtered_audio, Fs);
sound(filtered_audio, Fs);


figure;
spectrogram(x, hamming(window_length), overlap);
title('Spectrogram of instru3');

figure;
[x1,Fs] = audioread("filtered_audio.wav");
spectrogram(x1, hamming(window_length), overlap);
title('Spectrogram of filtered output');