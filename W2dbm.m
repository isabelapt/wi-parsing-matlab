function [dbm] = W2dbm(W)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% dbm= 10.* log10(W) + 30 - ls_db;
dbm= 10.* log10(W) + 30;
end