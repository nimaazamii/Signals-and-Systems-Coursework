return_signal=zeros(1,10000);
td=(450*2)/3e8;
ts=1e-9;
tau=1e-6;
for i=(td/ts):((td+tau)/ts)
    return_signal(i)=0.5;
end
time=zeros(1,10000);
for j=1:10000
    time(j)=j/1e9;
end
plot(time,return_signal)