clc
a = 1 + mod(257,3)

%%

%problem-1.1
audio1 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\piano3.wav";
audio2 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\trumpet3.wav";
audio3 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\violin3.wav";
audio4 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\flute3.wav";
[y1 fs1] = audioread(audio1);
[y2 fs2] = audioread(audio2);
[y3 fs3] = audioread(audio3);
[y4 fs4] = audioread(audio4);


fft1 = fft(y1);
magspec1 = abs(fft1);
len1 = length(y1);
frequency_piano = (0:(len1-1)) * (fs1/len1);
[~,peak1] = max(magspec1);
fundamental_freq_piano = frequency_piano(peak1) 

fft2 = fft(y2);
magspec2 = abs(fft2);
len2 = length(y2);
frequency_trumpet = (0:(len2-1)) * (fs2/len2);
[~,peak2] = max(magspec2);
fundamental_freq_trumpet = frequency_trumpet(peak2)

fft3 = fft(y3);
magspec3 = abs(fft3);
len3 = length(y3);
frequency_violin = (0:(len3-1)) * (fs3/len3);
[~,peak3] = max(magspec2);
fundamental_freq_violin = frequency_violin(peak3)

fft4 = fft(y4);
magspec4 = abs(fft4);
len4 = length(y4);
frequency_flute = (0:(len4-1)) * (fs4/len4);
[~,peak4] = max(magspec4);
fundamental_freq_flute = frequency_flute(peak4)

figure;
title("Magnitude Spectrum");
subplot(2,2,1)
plot(frequency_piano,20*log10(magspec1));
ylabel("Magnitude (Piano) in dB");
xlabel("Frequency in Hz");

subplot(2,2,2)
plot(frequency_trumpet,20*log10(magspec2));
ylabel("Magnitude (Trumpet) in dB");
xlabel("Frequency in Hz");

subplot(2,2,3)
plot(frequency_violin,20*log10(magspec3));
ylabel("Magnitude (Violin) in dB");
xlabel("Frequency in Hz");

subplot(2,2,4)
plot(frequency_flute,20*log10(magspec4));
ylabel("Magnitude (Flute) in dB");
xlabel("Frequency in Hz");

%%

%problem-1.2

audioflute1 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\flute1.wav"
audioflute2 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\flute2.wav"
audioflute3 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\flute3.wav"
audioflute4 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\flute4.wav"
audiopiano3 = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\piano3.wav"

[y1 fs1] = audioread(audioflute1);
[y2 fs2] = audioread(audioflute2);
[y3 fs3] = audioread(audioflute3);
[y4 fs4] = audioread(audioflute4);
[y5 fs5] = audioread(audiopiano3);

fft1 = fft(y1);
magspec1 = abs(fft1);
len1 = length(y1);
frequency_flute1 = (0:(len1-1)) * (fs1/len1);
[~,peak1] = max(magspec1);
fundamental_freq_flute1 = frequency_flute1(peak1)

fft2 = fft(y2);
magspec2 = abs(fft2);
len2 = length(y2);
frequency_flute2 = (0:(len2-1)) * (fs2/len2);
[~,peak2] = max(magspec2);
fundamental_freq_flute2 = frequency_flute2(peak2)

fft3 = fft(y3);
magspec3 = abs(fft3);
len3 = length(y3);
frequency_flute3 = (0:(len3-1)) * (fs3/len3);
[~,peak3] = max(magspec3);
fundamental_freq_flute3 = frequency_flute3(peak3)

fft4 = fft(y4);
magspec4 = abs(fft4);
len4 = length(y4);
frequency_flute4 = (0:(len4-1)) * (fs4/len4);
[~,peak4] = max(magspec4);
fundamental_freq_flute4 = frequency_flute4(peak4)

fft5 = fft(y5);
magspec5 = abs(fft5);
len5 = length(y5);
frequency_piano3 = (0:(len5-1)) * (fs5/len5);
[~,peak5] = max(magspec5);
fundamental_freq_piano3 = frequency_piano3(peak5)

%On observing all the cases, flute 1 and piano 3 have the
%least difference in the fundamental frequencies.

%%

%problem-3

audio_opera = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-3\Experiment-3\Opera.wav";
[yo,fo] = audioread(audio_opera);
lim = 0;
const = (length(yo))/20000
while lim < const-1
    lower_lim =(lim*20000) + 1;
    upper_lim = lower_lim + 20000;
    y = yo(lower_lim:upper_lim);
    fft1 = fft(y);
    mag = abs(fft1);
    [~,peak] = max(mag);
    len = length(y);
    frequency = (0:(len-1)) * (fo/len);
    fundamental_frequency = frequency(peak)
    figure;
    plot(frequency,20*log10(mag));
    ylabel("Magnitude")
    xlabel("Frequency")
    lim = lim+1;
end

window_length = 512; 
overlap_length = 256; 
nfft = 512;           

[S, F, T] = spectrogram(y, window_length, overlap_length, nfft, Fs);

figure;
imagesc(T, F, 20*log10(abs(S)));
axis xy;
colormap jet; 
colorbar; 
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram');


%%

%problem-2

recObj = audiorecorder(44100,16,1);
recDuration = 3;
fs0 = 44100;
disp("Begin speaking.")
recordblocking(recObj,recDuration);
disp("End of recording.")
y0 = getaudiodata(recObj);
fft0 = fft(y0);
magspec0 = abs(fft0);
len = length(y0);
frequency_wistle_key = (0:(len-1)) * (fs0/len);
[~,peak0] = max(magspec0);
fundamental_freq_wistle_key = (peak0 - 1)*(fs0/len)

recObj1 = audiorecorder(44100,16,1);
recDuration1 = 3;
fs1 = 44100;
disp("Begin speaking.")
recordblocking(recObj1,recDuration);
disp("End of recording.")
y1 = getaudiodata(recObj1);
fft1 = fft(y1);
magspec1 = abs(fft1);
len = length(y1);
frequency_wistle_access = (0:(len-1)) * (fs1/len);
[~,peak1] = max(magspec1);
fundamental_freq_access = (peak1 - 1)*(fs1/len)
fn2(fundamental_freq_wistle_key,fundamental_freq_access)

subplot(2,1,1)
%sgtitle("Test Case for Access Granted/Denied")
plot(frequency_wistle_key,20*log10(magspec0))
ylabel("Magnitude (key) in dB");
xlabel("Frequency in Hz");
subplot(2,1,2)
plot(frequency_wistle_access,20*log10(magspec1))
ylabel("Magnitude (attempt) in dB");
xlabel("Frequency in Hz");

function F = fn2(fundamental_freq_wistle_key ,fundamental_freq_access)

if((abs(fundamental_freq_wistle_key - fundamental_freq_access))/fundamental_freq_wistle_key <= 0.05)
    fprintf('access granted');
else
    fprintf('access denied');
end
end


