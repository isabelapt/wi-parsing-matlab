<<<<<<< HEAD
function [a,b,t,z] = log_tend1(x,y,np)
% x is the distance
% y is the residuos
% np is the number of points
xc=x(:);
yc=y(:);
m=[ ones(size(xc))  10*log10(xc) ];
param=m\yc;
a=param(1);
b=param(2);
t=linspace(min(x),max(x),np)';
=======
function [a,b,t,z] = log_tend1(x,y,np)
% x is the distance
% y is the residuos
% np is the number of points
xc=x(:);
yc=y(:);
m=[ ones(size(xc))  10*log10(xc) ];
param=m\yc;
a=param(1);
b=param(2);
t=linspace(min(x),max(x),np)';
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
z=a+b*10*log10(t);