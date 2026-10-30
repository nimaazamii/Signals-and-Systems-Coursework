function [a,b]=p2_4(x,y)
sum_xy=0;
sum_xx=0;
sum_y=0;
sum_x=0;
for i=1:1001
    xy=x(i)*y(i);
    sum_xy=xy+sum_xy;
end
for i=1:1001
    xx=x(i)*x(i);
    sum_xx=xx+sum_xx;
end
for i=1:1001
    sum_y=y(i)+sum_y;
end
for i=1:1001
    sum_x=x(i)+sum_x;
end
sum_power_2=sum_x*sum_x;
a=(1001*sum_xy-sum_x*sum_y)/(1001*sum_xx-sum_power_2);
b=(sum_y*sum_xx-sum_x*sum_xy)/(1001*sum_xx-sum_power_2);
end

