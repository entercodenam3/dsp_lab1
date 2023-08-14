t = -5:0.001:5
x = 46
a = 1 + mod(x,3)
y = @(t)(exp(-a*t))
subplot(2,2,1)
plot(t,y(t))
subplot(2,2,2)
plot(t,y(-t))
subplot(2,2,3)
plot(t,y(t-(1.5*a)))
subplot(2,2,4)
plot(t,y(2*a*t))