clear
clc
t=0:0.01:1-0.01;
fc=5;
f=-50:1:50-1;
rou=2/(3e8);
td=250*1000*rou;
fd=0.3*180/3.6;
re=0.5*cos(2*pi*(5+fd)*(t-td));
[R,V]=dist(re);
noise=randn(1,length(re));
k=0.01;
for i=1:500
    noisy=k*noise;
    y1=noisy+re;
    [R,V]=dist(y1);
    if  (R~=250) 
        disp(k)
        break
    end   
    k=k+0.01;
end
function [R,V]=dist(re)
fc=5;
rou=2/(3e8);
forieh=fftshift(fft(re));
half=forieh(52:100);
[~,I]=max(half);
fnew=I;
est_fd=fnew-fc;
V=(est_fd/0.3)*3.6;
new_phi=abs(angle(half(I)));
est_td=new_phi/(2*pi*fnew);
R=est_td/rou;
R=R/1000;
end