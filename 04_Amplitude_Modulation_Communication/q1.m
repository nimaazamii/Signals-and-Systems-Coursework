close all;
clc;clear;
message='signal';
speed=3;
y=coding_amp(message,speed);
final=decoding_amp(y,speed);
disp(final)
col=length(y);
noise=randn(1,col);
figure
histogram(noise)
miangean=mean(noise);
varr=var(noise);
k=0.01;
for i=1:500
    noisy=k*noise;
    y1=noisy+y;
    final=decoding_amp(y1,speed);
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
function y=coding_amp(message,speed)
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
if speed==1
    t=0.01:(1/fs):1;
    a=zeros(1,length(t));
    b=sin(2*pi*t);
    y=[];
    for j=1:binarymessage_len
        q=str2double(binarymessage(j));
        if q==0
            y=[y,a];
        elseif q==1
            y=[y,b];
        end
    end 
    x_axis=zeros(1,binarymessage_len*100);
    for o=1:binarymessage_len*100
        x_axis(o)=o/100;
    end
elseif speed==2
    t=0.01:1/fs:1;
    a=zeros(1,length(t));
    b=sin(2*pi*t)/3;
    c=2*sin(2*pi*t)/3;
    d=sin(2*pi*t);
    y=[];
    for j=1:(binarymessage_len/2)
        q=str2double(binarymessage((j-1)*2+1));
        p=str2double(binarymessage((j-1)*2+2));
        if q==0 && p==0
            y=[y,a];
        elseif q==0 && p==1
            y=[y,b];
        elseif q==1 && p==0
            y=[y,c];
        elseif q==1 && p==1
            y=[y,d];
        end
    end
    x_axis=zeros(1,binarymessage_len/2*100);
    for o=1:binarymessage_len/2*100
        x_axis(o)=o/100;
    end
elseif speed==3
    t=0.01:1/fs:1;
    a=zeros(1,length(t));
    b=sin(2*pi*t)/7;
    c=2*sin(2*pi*t)/7;
    d=3*sin(2*pi*t)/7;
    e=4*sin(2*pi*t)/7;
    f=5*sin(2*pi*t)/7;
    g=6*sin(2*pi*t)/7;
    h=7*sin(2*pi*t)/7;
    y=[];
    for j=1:(binarymessage_len/3)
        first=str2double(binarymessage((j-1)*3+1));
        second=str2double(binarymessage((j-1)*3+2));
        third=str2double(binarymessage((j-1)*3+3));
        if first==0 && second==0 && third==0
            y=[y,a];
        elseif first==0 && second==0 && third==1
            y=[y,b];
        elseif first==0 && second==1 && third==0
            y=[y,c];
        elseif first==0 && second==1 && third==1
            y=[y,d];
        elseif first==1 && second==0 && third==0
            y=[y,e];
        elseif first==1 && second==0 && third==1
            y=[y,f];   
        elseif first==1 && second==1 && third==0
            y=[y,g];      
        elseif first==1 && second==1 && third==1
            y=[y,h];
        end
    end 
    x_axis=zeros(1,binarymessage_len/3*100);
    for o=1:binarymessage_len/3*100
        x_axis(o)=o/100;
    end
end
plot(x_axis,y)
end
function final=decoding_amp(y,speed)
    Alphabet ='abcdefghijklmnopqrstuvwxyz ,;?.!';
    fs=100;
    s=zeros(length(y)/100,100);
    for r=1:(length(y)/100)
            for g=1:100
                s(r,g)=y((100*r-100)+g);
            end
    end
    t=0.01:1/fs:1;
    f=2*sin(2*pi*t);
    len=length(s(:,1));
    b=zeros(1,(length(y)/100));
    ff=[];
    if speed==1
        for v=1:len
            X=(s(v,:));
            b(v)=sum(X.*f);
            b(v)=b(v)/100;
            if b(v)>=0.5
                ff=[ff '1'];
            elseif b(v)<0.5
                ff=[ff '0'];
            end
        end
    elseif speed==2
        for v=1:len
            X=(s(v,:));
            b(v)=sum(X.*f);
            b(v)=b(v)/100;
            if b(v)>=0.8333
                ff=[ff '11'];
            elseif b(v)>=0.5 && b(v)<0.8333
                ff=[ff '10'];
            elseif b(v)>=0.1666 && b(v)<0.5
                ff=[ff '01'];
            elseif b(v)<0.1666
                ff=[ff '00'];
            end
        end
    elseif speed==3
        for v=1:len
            X=(s(v,:));
            b(v)=sum(X.*f);
            b(v)=b(v)/100;
            if b(v)>=0.9286
                ff=[ff '111'];
            elseif b(v)>=0.7857 && b(v)<0.9286
                ff=[ff '110'];
            elseif b(v)>=0.6429 && b(v)<0.7857
                ff=[ff '101'];
            elseif b(v)>=0.5 && b(v)<0.6429
                ff=[ff '100'];
            elseif b(v)>=0.3571 && b(v)<0.5
                ff=[ff '011'];
            elseif b(v)>=0.2143 && b(v)<0.3571
                ff=[ff '010'];
            elseif b(v)>=0.0714 && b(v)<0.2143
                ff=[ff '001'];
            elseif b(v)<0.0714
                ff=[ff '000'];
            end
        end
    end
    DcodedMessageBin=[]; 
    ind=1;
    for p=(1:length(ff)/5)
        characterbin=zeros(1,5);
        for cont=1:5
            vals=ff(ind);
            vals1=dec2bin(vals);
            characterbin(cont)=str2double(vals1(end));
            ind=ind+1;        
        end
        num=sum(characterbin.*(2.^(4:-1:0)))+1;
        DcodedMessageBin=[DcodedMessageBin Alphabet(num)];
    end
    final=DcodedMessageBin;
end