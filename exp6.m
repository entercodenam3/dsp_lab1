clc
a = 1+mod(257,3);

%problem-1
fs = 720;
f_edge = 10/(fs/2); 
f_stopband = 20/(fs/2);
f = linspace(0,50,100);

[n,Wn] = buttord(f_edge,f_stopband,a,40)

[b,a] = butter(n,Wn,"low")
figure;
h = tf(b,a,(1/fs))
zplane(b,a);
pzmap(h);


figure;
[mag,ph] = bode(h,2*pi*f);
plot(f,db(squeeze(mag)))
title("Butterworth Filter");
xlabel("Frequency");
ylabel("Magnitude (in dB)")

figure;
stepz(b,a)
hold on
impz(b,a)
hold off
title("Step vs Impluse Signal")
legend("Step Signal","Impulse Signal");

%%

%problem-2

data = importdata("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-6\Experiment-6\ECG_Data.txt");
f_data = filter(b,a,data)
fs = 720;
t = (0:(length(data)-1))/fs;
figure;
plot(t,data)
hold on
plot(t,f_data)
hold off
title("ECG Data")
legend("Original ECG Data","Filtered ECG Data")
xlabel("Frequency")
ylabel("Amplitude")

%%
%problem-3

clc

[y Fs] = audioread("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-5\Experiment-5\instru3.wav");

m = abs(fft(y));
F = (0:length(m)-1)*Fs/length(m);
figure;
plot(F,m)
title('Instrument - 3')
xlabel("Frequency");
ylabel("Amplitude");
fft1 = fft(x);
l1 = length(fft1);
mag1 = abs(fft1);
freq = (0:(l1-1))*(Fs/l1);
[~,peak] = max(mag1);
fund_f = freq(peak)

window_length = 100; 
overlap = 10;       
window_length_2 = 150;

l = fund_f-50;
h = fund_f+50;
[A,B,C,D] = butter(8,[l h]/(Fs/2),"bandpass");
d1 = designfilt("bandpassiir",FilterOrder=8,HalfPowerFrequency1=l,HalfPowerFrequency2=h,SampleRate=Fs);
sos = ss2sos(A,B,C,D);
fvt = fvtool(sos);
legend(fvt,"butter")

filtered_audio = filtfilt(d1,x);
audiowrite('filtered_audio.wav', filtered_audio, Fs);
sound(filtered_audio, Fs);

figure;
spectrogram(x, hamming(window_length), overlap);
axis xy
title('Spectrogram of Instrument-3');

figure;
[y1 Fs] = audioread("filtered_audio.wav");
spectrogram(y1, hamming(window_length), overlap);
axis xy
title('Filtered Output of Instrument-3');


%%

%problem-4

clc

fs= 720;
Wpb = 10/(fs/2);
Wsb = 20/(fs/2);
[nb,Wnb] = buttord(Wpb,Wsb,2,40);
[b_b,a_b]=butter(n,Wnb);
sys_b=tf(b_b,a_b,1/Fs);

Wpc = 10/(fs/2);
Wsc = 20/(fs/2);
[nc,Wpc] = cheb1ord(Wpc,Wsc,2,40)
[b,a]=cheby1(n,2,Wpc);
% tra
sys=tf(b,a,1/Fs);

subplot(2,1,1)
zplane(b,a)
title("Chebyshev")
subplot(2,1,2)
zplane(b_b,a_b)
title("Butterworth")

figure;
F = linspace(0,50,100);
[mag,phase] = bode(sys,2*pi*F);
plot(F,db(squeeze(mag)))
title("Chebyshev Filter")
legend("Bode plot (Chebyshev)")
xlabel("Frequency")
ylabel("Magnitude (dB)")
hold on
[mag_b,phase_b] = bode(sys_b,2*pi*F);
plot(F,db(squeeze(mag_b)))
legend("Bode plot (Chebyshev)","Bode plot (Butterworth)")
hold off

figure;
impz(b,a);
hold on
impz(b_b,a_b);
legend("Impulse Response (Chebyshev)","Impulse (Butterworth)")
title('Impulse Response');
hold off
figure;
stepz(b,a);
hold on
legend("Step (Chebyshev)")
stepz(b_b,a_b);
legend("Step Response (Chebyshev)","Step Response (Butterworth)")
title('Step Response');
hold off


