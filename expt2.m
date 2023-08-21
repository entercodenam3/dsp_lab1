alpha = 1+mod(257,3);


t = 0:1/alpha:(10-1/alpha);
y1 =alpha.*cos(5*alpha.*t);
y2 =(alpha/2).*cos(6*alpha.*t);
y3 =(alpha/4).*cos(10*alpha.*t);

%%

y4 =y1+ y2 + y3;
plot(t,y4);

%%

x = linspace(0,5,14*5*alpha);
n1 = alpha.*cos(5*alpha.*x);
n2 = (alpha/2).*cos(6*alpha.*x);
n3 =  (alpha/4).*cos(10*alpha.*x);
n4 = n1 + n2 + n3;
figure(1);
stem(x,n1);
figure(2);
stem(x,n2);
figure(3);
stem(x,n3);
figure(4);
stem(x,n4);
y4 = n4;
Fs = 14*alpha;

Fs = 1000;         
T = 1/Fs;           
t = 0:T:1-T;        
f1 = 50;           
signal = y4;

N = length(signal); 
fft_signal = fft(signal);


frequencies = Fs*(0:(N/2))/N;


amplitude_spectrum = 2*abs(fft_signal(1:N/2+1))/N;


subplot(2, 1, 1);
plot(t, signal);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(frequencies, amplitude_spectrum);
title('Amplitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


xlim([0, Fs/2]);


sgtitle('FFT Example');

%%

x1 = linspace(0,10,200*alpha);
n_1 = alpha.*cos(5*alpha.*x1);
n_2 = (alpha/2).*cos(6*alpha.*x1);
n_3 =  (alpha/4).*cos(10*alpha.*x1);
n_4 = n_3+n_2+n_1;
figure(2);
stem(x1,n_4);
[y4,Fs] = []
t=linspace(0,length(y4)/Fs,length(y4));
Nfft=16777216; %power of 2 and I put a huge number so there are many data point
f=linspace(0,Fs,Nfft);
X1=abs(fft(y4,Nfft));
figure(1);
plot(f(1:Nfft/2),X1(1:Nfft/2))
xlabel('Frequency'); 
ylabel ('amp');
title ('FFT Spectrum');

%%

x2 = linspace(0,10,90*alpha);
n__1 = alpha.*cos(5*alpha.*x1);
n__2 = (alpha/2).*cos(6*alpha.*x1);
n__3 =  (alpha/4).*cos(10*alpha.*x1);
n__4 = n_3+n_2+n_1;
figure(3);
stem(x2,n__4);

[y4,Fs] = []
t=linspace(0,length(y4)/Fs,length(y4));
Nfft=16777216; 
f=linspace(0,Fs,Nfft);
X1=abs(fft(y4,Nfft));
figure(1);
plot(f(1:Nfft/2),X1(1:Nfft/2))
xlabel('Frequency'); 
ylabel ('amp');
title ('FFT Spectrum');

%%

base_frequency = 440;  % Frequency of "Do" in Hz
tone_names = {'Do', 'Re', 'Mi', 'Fa', 'So', 'La', 'Ti', 'Do'};
duration = 1;  % Duration of each tone in seconds

% Different sampling rates to test
sampling_rates = [44100, 22050, 11025];

for rate = sampling_rates
    % Generate audio sequence for each tone
    tone_signals = cell(1, length(tone_names));
    for i = 1:length(tone_names)
        frequency = base_frequency * (2 ^ ((i - 1) / 12));
        t = 0:1/rate:duration - 1/rate;
        tone_signal = 0.5 * sin(2 * pi * frequency * t);
        tone_signals{i} = tone_signal;
    end
    
  
    audio_sequence = cell2mat(tone_signals);
    
 
    output_filename = sprintf('tone_sequence_%dHz.wav', rate);
    audiowrite(output_filename, audio_sequence, rate);
end
audio_filenames = {
    'tone_sequence_44100Hz.wav',
    'tone_sequence_22050Hz.wav',
    'tone_sequence_11025Hz.wav'
};

for i = 1:length(audio_filenames)
    filename = audio_filenames{i};
    
    [audio, sample_rate] = audioread(filename);
 
    sound(audio, sample_rate);
    
    pause(length(audio) / sample_rate);
end

%%
filename = 'Track002.wav';
[audio, original_sample_rate] = audioread(filename);
downsampling_factors = [2, 3, 4];  
upsampling_factors = [2, 3, 4]; 
for factor = downsampling_factors
   
    downsampled_audio = downsample(audio, factor);
    
    new_sample_rate = original_sample_rate / factor;

    output_filename = sprintf('downsampled_%dx.wav', factor);
    audiowrite(output_filename, downsampled_audio, new_sample_rate);
end

for factor = upsampling_factors
   
    downsampled_audio = upsample(audio, factor);
    
    new_sample_rate = original_sample_rate * factor;

    output_filename = sprintf('upsampled_%dx.wav', factor);
    audiowrite(output_filename, downsampled_audio, new_sample_rate);
end


for factor = downsampling_factors
    downsampled_filename = sprintf('downsampled_%dx.wav', factor);
    [downsampled_audio, downsampled_sample_rate] = audioread(downsampled_filename);
    sound(downsampled_audio, downsampled_sample_rate);
    pause(length(downsampled_audio) / downsampled_sample_rate);
end



for factor = upsampling_factors
    upsampled_filename = sprintf('upsampled_%dx.wav', factor);
    [downsampled_audio, upsampled_sample_rate] = audioread(upsampled_filename);
    sound(downsampled_audio, upsampled_sample_rate);
    pause(length(downsampled_audio)*upsampled_sample_rate);
end