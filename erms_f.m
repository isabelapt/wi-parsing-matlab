<<<<<<< HEAD
function z=erms_f(u,v)
u=u(:);
v=v(:);
n=max(size(u));
z=sqrt(sum(  (u-v).^2  )/n );
=======
function z=erms_f(u,v)
u=u(:);
v=v(:);
n=max(size(u));
z=sqrt(sum(  (u-v).^2  )/n );
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
