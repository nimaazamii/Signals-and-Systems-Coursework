clear
clc
message='signal';
speed=5;
[y,x_axis]=coding_freq(message,speed);
plot(x_axis,y)
DcodedMessage=decoding_freq(y,speed);
disp(DcodedMessage)
col=length(y);
noise=randn(1,col);
k=0.01;
for i=1:500
    noisy=k*noise;
    y1=noisy+y;
    final=decoding_freq(y1,speed);
    if ~strcmp(final, message)
        variance=k*k;
        disp(variance)
        disp(final)
        figure
        plot(y1)
        break
    end
    k=k+0.01;
end
function DcodedMessageBin=decoding_freq(y,speed)
s=zeros(length(y)/100,100);
for r=1:(length(y)/100)
            for g=1:100
                s(r,g)=y((100*r-100)+g);
            end
end
len=length(s(:,1));
index=zeros(1,len);
for g=1:len
    y2=fftshift(fft(s(g,:)));
    out=y2/max(abs(y2));
    out=abs(out);
    oo=out(51:100);
    [~,I]=max(oo);
    index(g)=I-1;
end
frequency=cell(1,5);
frequency{1,1}=[12,37];
frequency{1,2}=[5,16,27,38];
frequency{1,3}=[4,10,16,22,28,34,40,46];
frequency{1,4}=[2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47];
frequency{1,5}=[1,2,4,5,7,8,10,11,13,14,16,17,19,20,22,23,25,26,...
    28,29,31,32,34,35,37,38,40,41,43,44,46,47];
string=[];
co=cell2mat(frequency(speed));
thre=zeros(1,length(co)+1);
thre(1)=(0+co(1)/2);
for v=1:length(co)-1
    thre(v+1)=(co(v)+co(v+1))/2;
end
thre(end)=(co(end)+49)/2;
for r=1:len 
        for k=1:length(thre)-1
            if index(r)>thre(k) && index(r)<thre(k+1)
                z=k;
                break
            end
        end
        bin=dec2bin(z-1,speed);
        string=[string bin];
end
DcodedMessageBin=[]; 
ind=1;
Alphabet ='abcdefghijklmnopqrstuvwxyz ,;?.!';
for p=(1:length(string)/5)
    characterbin=zeros(1,5);
    for cont=1:5
        vals=string(ind);
        vals1=dec2bin(vals);
        characterbin(cont)=str2double(vals1(end));
        ind=ind+1;        
    end
    num=sum(characterbin.*(2.^(4:-1:0)))+1;
    DcodedMessageBin=[DcodedMessageBin Alphabet(num)];
end
end
function [y,x_axis]=coding_freq(message,speed)
mapset=cell(2,32);
fs=100;
Alphabet ='abcdefghijklmnopqrstuvwxyz ,;?.!';
for i=1:32
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
message_len=length(message);
message_bin=cell(1,message_len);
for i=1:message_len
    ch=message(i);
    for j=1:32
        if ch==mapset{1,j}
            message_bin{i}=mapset{2,j};
        end
    end
end
binarymessage=cell2mat(message_bin);
binarymessage_len=length(binarymessage);
frequency=cell(1,5);
frequency{1,1}=[12,37];
frequency{1,2}=[5,16,27,38];
frequency{1,3}=[4,10,16,22,28,34,40,46];
frequency{1,4}=[2,5,8,11,14,17,20,23,26,29,32,35,38,41,44,47];
frequency{1,5}=[1,2,4,5,7,8,10,11,13,14,16,17,19,20,22,23,25,26,...
    28,29,31,32,34,35,37,38,40,41,43,44,46,47];
y=[];
ts=1/fs;
time=0:ts:(1-ts);
for j=0:(binarymessage_len/speed)-1
    u=[];
    for t=1:speed
        q=(binarymessage((speed*j+1)+t-1));
        u=[u q];
    end
    andis=bin2dec(u)+1;
    x=cell2mat(frequency(speed));
    f=x(andis);
    attach=sin(2*pi*f*time);
    y=[y,attach];
end
x_axis=0:0.01:binarymessage_len/speed-0.01;
end