clc;           
clear;        
close all;
number=68;
baj=8;
calling_customer(number,baj)
function calling_customer(number,baj)
    files=dir('Map Set');
len=length(files)-2;
TRAIN=cell(2,len);
fs=48000;
for i=1:len
   TRAIN{1,i}=audioread(['Map Set','\',files(i+2).name]);
   TRAIN{2,i}=(files(i+2).name);
   TRAIN{2,i}=erase(TRAIN{2,i},'.wav');
end
save('TRAIN');
yekan=mod(number,10);
dah=floor(number/10);
if number>99 || baj>9 || number<1 || baj<1
    disp('error')
else
    Y=cell2mat(TRAIN(1,30));
sound(Y,fs)
pause(1.2)
if number<20
    for i=1:30
        if str2double(cell2mat(TRAIN(2,i)))==number
            Y=cell2mat(TRAIN(1,i));
            sound(Y,fs)
        end
    end
elseif (yekan==0)&&(number>=20)
    for i=1:30
        if str2double(cell2mat(TRAIN(2,i)))==number
            Y=cell2mat(TRAIN(1,i));
            sound(Y,fs)
        end
    end
else 
     for i=1:30
         if str2double(cell2mat(TRAIN(2,i)))==(dah*10)
                Y=cell2mat(TRAIN(1,i));
                sound(Y,fs)
         end
     end
     pause(0.7)
     Y=cell2mat(TRAIN(1,29));
     sound(Y,fs)
     pause(0.7)
     for i=1:30
        if str2double(cell2mat(TRAIN(2,i)))==yekan
            Y=cell2mat(TRAIN(1,i));
            sound(Y,fs)
        end
    end
end
pause(0.7)
Y=cell2mat(TRAIN(1,28));
sound(Y,fs)
pause(0.8)
for i=1:30
        if str2double(cell2mat(TRAIN(2,i)))==baj
            Y=cell2mat(TRAIN(1,i));
            sound(Y,fs)
        end
end
end
end