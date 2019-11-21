function z=erms_f(u,v)
u=u(:);
v=v(:);
n=max(size(u));
z=sqrt(sum(  (u-v).^2  )/n );
