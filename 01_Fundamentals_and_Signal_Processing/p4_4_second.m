function p4_4_second(x,speed)
Fs=48000;
if speed>=0.5 && speed <=2
    if rem(speed,0.1)~= 0
        error('number should be *0.1');
    end
new_x=resample(x,Fs,round(Fs*speed));
sound(new_x,round(Fs*speed));
end