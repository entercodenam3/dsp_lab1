a = 1 + mod(257,3)

%problem - 1

%(1)

fs = 120;
n1 = 0:1/fs:2-(1/fs);
xn1 = sin(2*pi*15*a*n1);

signal1 = xn1(1:120);

l1 = length(signal1)

y1 = fft(signal1);
m1 = abs(y1);
freq1 = (0:(l1-1)) * (fs/l1); 

subplot(2,1,1)
plot(freq1,m1,'b')
title("120 Samples")
xlabel("Frequency (Hz)")
ylabel("Amplitude")

%(2)

signal2 = xn1(1:130);

l2 = length(signal2)

y2 = fft(signal2);
m2 = abs(y2);
freq2 = (0:(l2-1)) * (fs/l2);

subplot(2,1,2)
plot(freq2,m2,'r')
title("130 Samples")
xlabel("Frequency (Hz)")
ylabel("Amplitude")
%%
%(3)

signal3 = xn1(1:240);

l3 = length(signal3)

y3 = fft(signal3);
m3 = abs(y3);
freq3 = (0:(l3-1)) * (fs/l3);


plot(freq3,m3,'g')

%%

%problem - 2

fs = 200;
t = 0 : (1/fs) : (10-(1/fs));
xa = 0.1*sin(160*pi*t) + cos(166*pi*t);

samples = [215,415,1115,1515,1915];

for s = samples
    signal = xa(1:s);
    l = length(signal);
    y = fft(signal);
    amp = abs(y);
    freq = (0:(l-1))*(fs/l);
    figure;
    plot(freq,amp);
    int2str(s)
    title(s,"Samples")
    xlabel("Frequency")
    ylabel("Amplitude")
end


%%

%problem - 3

fs = 200
t = 0 : (1/fs) : 10-(1/fs);
w = blackman(2000);
xa = (0.1*sin(140*pi*t) + cos(146*pi*t)).* w';
figure;
plot(t,xa)
xlabel("Time");
ylabel("Amplitude");

y1 = fft(xa,215);
m1 = abs(y1);
l1 = length(m1);
f1 = (0:(l1-1))*(fs/l1);
figure;
plot(f1,m1)
title('Magnitude 215');
xlabel("Frequency");
ylabel("Amplitude");

y2 = fft(xa,415);
m2 = abs(y2);
l2 = length(m2);
f2 = (0:l2-1)*(fs/l2);
figure;
plot(f2,m2)
title('Magnitude 415');
xlabel("Frequency");
ylabel("Amplitude");

y3 = fft(xa,1115);
m3 = abs(y3);
l3 = length(m3);
f3 = (0:l3-1)*(fs/l3);
figure;
plot(f3,m3)
title('Magnitude 1115');
xlabel("Frequency");
ylabel("Amplitude");

y4 = fft(xa,1515);
m4 = abs(y4);
l4 = length(m4);
f4 = (0:l4-1)*(fs/l4);
figure;
plot(f4,m4)
title('Magnitude 1515');
xlabel("Frequency");
ylabel("Amplitude");

y5 = fft(xa,1915);
m5 = abs(y5);
l5 = length(m5);
f5 = (0:l5-1)*(fs/l5);
figure;
plot(f5,m5)
title('Magnitude 1915');
xlabel("Frequency");
ylabel("Amplitude");


figure;
plot(t,w)
title("Blackman Signal");
xlabel("Time");
ylabel("Amplitude");



%%

file = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Experiment-4\Experiment-4\Exp4Data3.txt";
x1 = importdata(file) ; 
m1 = abs(fft(x,10000));
l1 = length(m1);
f1 = (0:length(m1)-1)*1/l1;
figure;
plot(f1,m1)
title("Without Hamming");
xlabel("Frequency");
ylabel("Amplitude");

w = hamming(500);
x2 = x1.* w' ; 
m2 = abs(fft(x2,10000));
l2 = length(m2);
f2 = (0:length(m2)-1)*1/l2;
figure;
plot(f2,m2)
title("With Hamming");
xlabel("Frequency");
ylabel("Amplitude");

figure;
plot(w)
title("Hamming Signal");
xlabel("Time");
ylabel("Amplitude");








