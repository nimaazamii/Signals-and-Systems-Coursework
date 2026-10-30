function x=p4_4(x,speed)
Fs=48000;
len=length(x);
if (speed>1)
    waste=(speed-1)*10;
    for i=1:fix(len/(speed*10))
        t=(i*speed*10);
        t=int64(t);
        for k=0:waste-1
            x(t+k,:)=[nan,nan];
        end
    end
    x(isnan(x(:,1)),:)=[];
    x(isnan(x(:,2)),:)=[];
%elseif speed<1
    %array=round((1/speed)*len);
    %r=zeros(array,2);
    %for i=1:(len)
       % j=i;
       % r((1/speed)*j,:)=x(i,:);
    %end
    %for k=1:len
     %   r(2*k+1,1)=(r(2*k,1)+r(2*k+2,1))/2;
      %  r(2*k+1,2)=(r(2*k,2)+r(2*k+2,2))/2;
    %end
    %r(1,:)=[];
    %r(2*len+1,:)=[];
    %x=r;
else
    x=('error');
end

sound(x,Fs)
end