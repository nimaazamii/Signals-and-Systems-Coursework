t=0:0.01:1;
z1=sin(2*pi*t);
z2=cos(2*pi*t);
subplot(1,2,1);
plot(t,z1,'--b')
title(' sin ');
legend('sin')
xlabel('time')
ylabel('amplitude')
x0=0.5;
y0=0.2;
s0='sin(2\pi t)';
text(x0,y0,s0);
subplot(1,2,2);
plot(t,z2,'r')
x1=0.25;
y1=-0.8;
s1='cos(2\pi t)';
text(x1,y1,s1);
title(' cos');
legend('cos')
xlabel('time')
ylabel('amplitude')
grid on
