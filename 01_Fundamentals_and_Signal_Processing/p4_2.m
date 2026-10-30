[x,Fs] = audioread('voice.wav');
len=length(x);
time=zeros(1,len);
for i=1:len
    time(i)=i/Fs;
end
plot(time,x);
xlabel('time')
sound(x,Fs)
audiowrite('x.wav',x,Fs);
