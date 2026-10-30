signal=zeros(1,1e4);
for i=1:1e3
    signal(i)=1;
end
time=zeros(1,10000);
for j=1:10000
    time(j)=j/1e9;
end
plot(time,signal,'LineWidth',2)
