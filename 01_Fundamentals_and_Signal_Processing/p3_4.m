ts=1e-9;
t=0:ts:1e-5;
t_len=length(t);
N=1000;
x=zeros(1,t_len);
x(1:N)=1;
y=zeros(1,t_len);
idx=3000;
pulse=ones(1,N);
y(idx:idx+N-1)=0.5*pulse;
t=0.1;
khata=zeros(1,100);
dif=zeros(1,100);
for k=1:100
    for j=1:100
        noise=t*randn(1,t_len);
        yn=y+noise;
        ro=zeros(1,t_len-N-1);
        for i=1:t_len-N-1
            ro(i)=pulse*yn(i:i+N-1)';
        end
        [val,index]=max(ro);
        td=index*ts;
        C=300e6;
        R=td*C/2;
        khata(j)=abs(R-450);
    end
    dif(k)=mean(khata);
    if dif(k)>10
        final_khata=dif(k-1);
        break
    end
    t=t+0.1;
end
disp(t)
disp(final_khata)
noi=0.1:0.1:10;
plot(noi(1:k),dif(1:k))
xlabel('noise strength')
ylabel('khata')