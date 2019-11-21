function [n_loss] = n_exponent(pl_do,pl_d,do,d)
%UNTITLED2 Summary of this function goes here
%  Detailed explanation goes here
k=isnan(pl_d);
for i= 1: length(pl_d)
if k(i)==1
        pl_d(i) = 0;
end
end
q=pl_d(2:end)-pl_do;
t=10*log10(d(2:end)/do);
% q=pl_d_nlosin(2:end)-pl_do_nlosin;
% t=10*log10(d_nlosin(2:end)/do_nlosin);
n_loss=sum(q)/sum(t);
end
