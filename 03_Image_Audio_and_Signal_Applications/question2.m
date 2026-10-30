close all;
clc;clear;
fr=[697 770 852 941];
fc=[1209 1336 1477];
fs=8000;
Ts=1/fs;
Ton=0.1;
Toff=0.1;
space=zeros(1,fs*Toff);
t=0:Ts:Ton-Ts;
y1=sin(2*pi*fr(1)*t);
y2=sin(2*pi*fc(1)*t);
y_1=(y1+y2)/2;
y1=sin(2*pi*fr(1)*t);
y2=sin(2*pi*fc(2)*t);
y_2=(y1+y2)/2;
y1=sin(2*pi*fr(1)*t);
y2=sin(2*pi*fc(3)*t);
y_3=(y1+y2)/2;
y1=sin(2*pi*fr(2)*t);
y2=sin(2*pi*fc(1)*t);
y_4=(y1+y2)/2;
y1=sin(2*pi*fr(2)*t);
y2=sin(2*pi*fc(2)*t);
y_5=(y1+y2)/2;
y1=sin(2*pi*fr(2)*t);
y2=sin(2*pi*fc(3)*t);
y_6=(y1+y2)/2;
y1=sin(2*pi*fr(3)*t);
y2=sin(2*pi*fc(1)*t);
y_7=(y1+y2)/2;
y1=sin(2*pi*fr(3)*t);
y2=sin(2*pi*fc(2)*t);
y_8=(y1+y2)/2;
y1=sin(2*pi*fr(3)*t);
y2=sin(2*pi*fc(3)*t);
y_9=(y1+y2)/2;
y1=sin(2*pi*fr(4)*t);
y2=sin(2*pi*fc(1)*t);
y_star=(y1+y2)/2;
y1=sin(2*pi*fr(4)*t);
y2=sin(2*pi*fc(2)*t);
y_0=(y1+y2)/2;
y1=sin(2*pi*fr(4)*t);
y2=sin(2*pi*fc(3)*t);
y_moraba=(y1+y2)/2;
y=[];
y=[y,y_4,space];
y=[y,y_3,space];
y=[y,y_2,space];
y=[y,y_1,space];
y=[y,y_8,space];
y=[y,y_7,space];
y=[y,y_6,space];
y=[y,y_5,space];
audiowrite('y.wav',y,fs)
%2-2
[a,fs]=audioread('a.wav');
a=a';
[row,col]=size(a);
numberofkey=(col/800)/2;
temp=zeros(numberofkey,800);
for i=1:numberofkey
    for j=1:800
        temp(i,j)=a((2*i-2)*800+j);
    end
end
num=zeros(1,numberofkey);
for t=1:numberofkey
        co(1)=corr((temp(t,:))',(y_1)');
        co(2)=corr((temp(t,:))',(y_2)');
        co(3)=corr((temp(t,:))',(y_3)');
        co(4)=corr((temp(t,:))',(y_4)');
        co(5)=corr((temp(t,:))',(y_5)');
        co(6)=corr((temp(t,:))',(y_6)');
        co(7)=corr((temp(t,:))',(y_7)');
        co(8)=corr((temp(t,:))',(y_8)');
        co(9)=corr((temp(t,:))',(y_9)');
        co(10)=corr((temp(t,:))',(y_star)');
        co(11)=corr((temp(t,:))',(y_0)');
        co(12)=corr((temp(t,:))',(y_moraba)');
        [~,index]=max(co);
        num(t)=index;
        if num(t)==11
            num(t)=0;
        end
end
number = 0;
for i = 1:length(num)
    number = number * 10 + num(i);
end
disp(number)