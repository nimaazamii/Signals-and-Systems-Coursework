syms y(x)
syms x
stepp=heaviside(x);
Dy = diff(y);
ode = diff(y,x,2)+3*diff(y,x) == -2*y+5*stepp;
cond1 = y(0) == 1;
cond2 = Dy(0) == 1;
conds = [cond1 cond2];
ySol(x) = dsolve(ode,conds);
fplot(ySol,[0 10])
%hand calculation
t=0:0.01:10;
realans=5/2-2*exp(-t)+exp(-2*t)/2;
figure
plot(realans)