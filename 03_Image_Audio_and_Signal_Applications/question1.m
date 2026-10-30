close all;
clc;clear;
mapset=cell(2,32);
Alphabet ='ABCDEFGHIJKLMNOPQRSTUVWXYZ ,;?.!';
for i=1:32
    mapset{1,i}=Alphabet(i);
    mapset{2,i}=dec2bin(i-1,5);
end
X=imread('Amsterdam.jpg');
X=rgb2gray(X);
X=imresize(X,[700,400]);
message='SIGNAL;';
max_block=50;
size=5;
Y=coding(message,X,mapset);
DcodedMessageBin=decoding(Y,Alphabet,size,max_block);
function [Y]=coding(message,X,mapset)
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
Y=X;
%blocking
block=zeros(5,5,11200);
n=1;
 for t=1:80
        for j=1:140
            block(1,1,n)=X(5*j-4,5*t-4);
            block(2,1,n)=X(5*j-3,5*t-4);
            block(3,1,n)=X(5*j-2,5*t-4);
            block(4,1,n)=X(5*j-1,5*t-4);
            block(5,1,n)=X(5*j,5*t-4);
            block(1,2,n)=X(5*j-4,5*t-3);
            block(2,2,n)=X(5*j-3,5*t-3);
            block(3,2,n)=X(5*j-2,5*t-3);
            block(4,2,n)=X(5*j-1,5*t-3);
            block(5,2,n)=X(5*j,5*t-3);
            block(1,3,n)=X(5*j-4,5*t-2);
            block(2,3,n)=X(5*j-3,5*t-2);
            block(3,3,n)=X(5*j-2,5*t-2);
            block(4,3,n)=X(5*j-1,5*t-2);
            block(5,3,n)=X(5*j,5*t-2);
            block(1,4,n)=X(5*j-4,5*t-1);
            block(2,4,n)=X(5*j-3,5*t-1);
            block(3,4,n)=X(5*j-2,5*t-1);
            block(4,4,n)=X(5*j-1,5*t-1);
            block(5,4,n)=X(5*j,5*t-1);
            block(1,5,n)=X(5*j-4,5*t);
            block(2,5,n)=X(5*j-3,5*t);
            block(3,5,n)=X(5*j-2,5*t);
            block(4,5,n)=X(5*j-1,5*t);
            block(5,5,n)=X(5*j,5*t);
            n=n+1;
        end
 end
 %enheraf meyar
st=zeros(1,11200);
for r=1:11200
    A(:,:)=block(:,:,r);
    st(r)=std(std(A));
end
%maximum std and find final matrix for coding
[~,I]=sort(st,'descend');
%jaygozari
needed_block=ceil(binarymessage_len/25);
counter=1;
    for r=1:needed_block   
        second=(floor(I(r)/140))*5+1;
        for i=0:4
            first=(mod((I(r)-1),140))*5+1;
            for j=0:4
                vals=X(first,second);
                valsbin=dec2bin(vals);
                if counter<=binarymessage_len
                    valsbin(end)=binarymessage(counter);
                    Y(first,second)=bin2dec(valsbin);
                    counter=counter+1;
                    first=first+1;
                end
            end
            second=second+1;
        end
    end
figure
plot1=subplot(1,2,1);
imshow(X)
title('Original PIC')
plot2=subplot(1,2,2);
imshow(Y)
title('Coded PIC')
linkaxes([plot1 plot2])
end
function DcodedMessageBin=decoding(Y,Alphabet,size,max_block)
%decode
blocked=zeros(size,size,11200);
%blocking coded picture
n=1;
 for t=1:80
        for j=1:140
            blocked(1,1,n)=Y(5*j-4,5*t-4);
            blocked(2,1,n)=Y(5*j-3,5*t-4);
            blocked(3,1,n)=Y(5*j-2,5*t-4);
            blocked(4,1,n)=Y(5*j-1,5*t-4);
            blocked(5,1,n)=Y(5*j,5*t-4);
            blocked(1,2,n)=Y(5*j-4,5*t-3);
            blocked(2,2,n)=Y(5*j-3,5*t-3);
            blocked(3,2,n)=Y(5*j-2,5*t-3);
            blocked(4,2,n)=Y(5*j-1,5*t-3);
            blocked(5,2,n)=Y(5*j,5*t-3);
            blocked(1,3,n)=Y(5*j-4,5*t-2);
            blocked(2,3,n)=Y(5*j-3,5*t-2);
            blocked(3,3,n)=Y(5*j-2,5*t-2);
            blocked(4,3,n)=Y(5*j-1,5*t-2);
            blocked(5,3,n)=Y(5*j,5*t-2);
            blocked(1,4,n)=Y(5*j-4,5*t-1);
            blocked(2,4,n)=Y(5*j-3,5*t-1);
            blocked(3,4,n)=Y(5*j-2,5*t-1);
            blocked(4,4,n)=Y(5*j-1,5*t-1);
            blocked(5,4,n)=Y(5*j,5*t-1);
            blocked(1,5,n)=Y(5*j-4,5*t);
            blocked(2,5,n)=Y(5*j-3,5*t);
            blocked(3,5,n)=Y(5*j-2,5*t);
            blocked(4,5,n)=Y(5*j-1,5*t);
            blocked(5,5,n)=Y(5*j,5*t);
            n=n+1;
        end
 end
 %enheraf meyar for coded picture
enheraf=zeros(1,11200);
for r=1:11200
    Q(:,:)=blocked(:,:,r);
    enheraf(r)=std(std(Q));
end
%maximum std and find final matrix for decoding
[~,index]=sort(enheraf,'descend');
final_for_decode=[];
for b=1:max_block
    final_for_decode=[final_for_decode,blocked(:,:,index(b))];
end
%decoding
DcodedMessageBin=[];
flag=1; 
ind=1;
Alphabet ='abcdefghijklmnopqrstuvwxyz ,;?.!';
while flag
    characterbin=zeros(1,5);
    for cont=1:5
        vals=final_for_decode(ind);
        vals1=dec2bin(vals);
        characterbin(cont)=str2double(vals1(end));
        ind=ind+1;        
    end
    num=sum(characterbin.*(2.^(4:-1:0)))+1;
    if strcmp(Alphabet(num),';')
        flag=0;
    else
        DcodedMessageBin=[DcodedMessageBin Alphabet(num)];
    end
end
sprintf(DcodedMessageBin)
end