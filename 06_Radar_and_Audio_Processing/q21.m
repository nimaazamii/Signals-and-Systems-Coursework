clear
clc
A=880;
B=987.77;
C=523.25;
D=587.33;
E=659.25;
F=698.46;
G=783.99;
AA=932.33;
CC=554.37;
DD=622.25;
FF=739.99;
GG=830.61;
freq=[A,B,C,D,E,F,G,AA,CC,DD,FF,GG];
ts=1/8000;
T1=0.5;
t1=0:ts:T1-ts;
T2=0.25;
t2=0:ts:T2-ts;
paus=zeros(1,200);
so=[];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*G*t1)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*FF*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t1)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*FF*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t1)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t1)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*D*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t1)];
so=[so,paus];
so=[so,sin(2*pi*FF*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*FF*t2)];
so=[so,paus];
so=[so,sin(2*pi*E*t2)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*FF*t1)];
so=[so,paus];
so=[so,sin(2*pi*D*t1)];
so=[so,paus];
sound(so)
counter=1;
poc=cell(1,1000);
k=1;
for i=3:length(so)
    if so(i)~=0 && so(i-1)==0
        k=i-1;
    end
    if so(i)==0&&so(i-1)~=0
        Q=(so(k:i-1));
        poc(1,counter)={Q};
        counter=counter+1;
    end
end
poc = poc(~cellfun('isempty',poc));
r=zeros(1,length(poc));
duration=zeros(1,length(poc));
for j=1:length(poc)
    mat=cell2mat(poc(1,j));
    g=fftshift(fft(mat));
    len=length(mat);
    m=len/2000;
    if m==1
        V=4;
        duration(j)=0.25;
    elseif m==2
        V=2;
        duration(j)=0.5;
    end
    f=0:V:(4000-V);
    half=g((len/2+1):len);
    [~,I]=max(half);
    r(j)=f(I);
end
Index=zeros(1,length(poc));
final=cell(2,length(poc));
for w=1:length(poc)
    Index(w)=find(min(abs(freq-r(w)))==abs(freq-r(w)));
    if Index(w)==1
        final(1,w)={'A'};
    elseif Index(w)==2
        final(1,w)={'B'};
    elseif Index(w)==3
        final(1,w)={'C'};
    elseif Index(w)==4
        final(1,w)={'D'};
    elseif Index(w)==5
        final(1,w)={'E'};
    elseif Index(w)==6
        final(1,w)={'F'};
    elseif Index(w)==7
        final(1,w)={'G'};
    elseif Index(w)==8
        final(1,w)={'A#'};
    elseif Index(w)==9
        final(1,w)={'C#'};
    elseif Index(w)==10
        final(1,w)={'D#'};
    elseif Index(w)==11
        final(1,w)={'F#'};
    elseif Index(w)==12
        final(1,w)={'G#'};
    end
end
for k=1:length(poc)
    final(2,k)=num2cell(duration(k));
end
disp(final)