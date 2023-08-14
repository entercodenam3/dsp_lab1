f = [220,246.94,261.63,293.66,329.63,349.23,392]
fs = 40000
for freq=f
    t = 0:(1/fs):2
    y = sin(2*pi*freq*t)
    sound(y,fs)
end 
