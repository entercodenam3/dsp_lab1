%problem1.1

a = 1 + mod(257,3)

l_lim = 2 + (2*a); %8
u_lim = 5 + (5*a); %20
fs = 100;
t = 0 :(1/fs):(10-(1/fs));
f = l_lim + ((u_lim-l_lim)*t/10);
x = sin(2*pi*f.*t);

figure;
plot(t,x)
title("Chirp Signal");
xlabel("Time");
ylabel("Amplitude");

%%
%problem1.2

y = fft(x);
m = abs(y);
l = length(y);
f = (0:(l-1))*(fs/l);

figure;
plot(f,m)
title("FFT Plot of Chirp Signal");
xlabel("Frequency");
ylabel("Amplitude");

%%
%problem1.3
a = 1 + mod(257,3)

l_lim = 2 + (2*a) %8
u_lim = 5 + (5*a) %20
fs = 100;
t = 0 :(1/fs):(10-(1/fs));
f = l_lim + ((u_lim-l_lim)*t/10);
x = sin(2*pi*f.*t);

%100
window_len = 100;
overlap = 10;
[S,F,T] = spectrogram(x,window_len,overlap);

figure;
imagesc(T,F,20*log10(abs(S)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram (100) Hamming Window');

%150
window_len = 150;
overlap = 10;
[S,F,T] = spectrogram(x,window_len,overlap);

figure;
imagesc(T,F,20*log10(abs(S)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram (150) Hamming Window');

%200
window_len = 200;
overlap = 10;
[S,F,T] = spectrogram(x,window_len,overlap);

figure;
imagesc(T,F,20*log10(abs(S)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram (200) Hamming Window');

%200
window_len = 200;
overlap = 10;
[S,F,T] = spectrogram(x,hanning(window_len),overlap);

figure;
imagesc(T,F,20*log10(abs(S)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram (200) Hanning Window');

%200
window_len = 200;
overlap = 10;
[S,F,T] = spectrogram(x,blackman(window_len),overlap);

figure;
imagesc(T,F,20*log10(abs(S)));
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram (200) Blackman Window');

%%
%problem2.1

fileid = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-5\Experiment-5\instru3.wav";
[y,fs] = audioread(fileid);

window_len = 200;
overlap = 10;
figure;
[S,F,T] = spectrogram(y,hamming(window_len),overlap);
imagesc(T,F,20*log10(abs(S)));
xlabel('Time (s)');
axis xy;
ylabel('Frequency (Hz)');
title('Spectrogram for Instrument');

fft1 = fft(y);
l1 = length(fft1);
mag1 = abs(fft1);
freq = (0:(l1-1))*(fs/l1);
[~,peak] = max(mag1);
fundamental_freq = freq(peak) 
figure;
plot(freq,mag1)
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("FFT Plot for Instrument");

%%
%problem2.2

fileid = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-5\Experiment-5\Opera.wav";
[y,fs] = audioread(fileid);

window_len = 200;
overlap = 10;
figure;
[S,F,T] = spectrogram(y,window_len,overlap);
imagesc(T,F,20*log10(abs(S)));
xlabel('Time (s)');
axis xy;
ylabel('Frequency (Hz)');
title('Spectrogram for Opera');

fft1 = fft(y);
l1 = length(fft1);
mag1 = abs(fft1);
freq = (0:(l1-1))*(fs/l1);
[~,peak] = max(mag1);
fundamental_freq = freq(peak) 
figure;
plot(freq,mag1)
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("FFT Plot for Opera");

%%
%problem3

recObj1 = audiorecorder(4000,16,1);
recDuration = 3;
fs1 = 4000;
disp("Begin speaking.")
recordblocking(recObj1,recDuration);
disp("End of recording.")
y1 = getaudiodata(recObj1);

window_len = 200;
overlap = 10;
[S,F,T] = spectrogram(y1,hamming(window_len),overlap);
figure;
imagesc(T,F,20*log10(abs(S)));
xlabel('Time (s)');
axis xy;
ylabel('Frequency (Hz)');
title('Spectrogram');

