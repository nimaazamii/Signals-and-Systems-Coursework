load p2.mat
[a,b]=p2_4(x,y);
noise=0.1*randn(1,1001);
new_y=zeros(1,1001);
for i=1:1001
    new_y(i)=(a*x(i))+b+noise(i);
end
plot(x,new_y,'.')
grid on