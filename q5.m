x = 46
a = 1 + mod(x,3)
fs = 1/0.001
t = 0:(1/fs):(5-1/fs)
y1 = sin(2*pi*200*a*t)
y2 = sin(2*pi*220*a*t)
y = y1 + y2
filename = "q5.wav"
audiowrite(filename,y,fs)
[y,fs] = audioread(filename)
sound(y,fs)



%sounds like a continuous dial tone