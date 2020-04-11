<<<<<<< HEAD
function [dbm] = W2dbm(W,ls_db)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dbm= 10.* log10(W) + 30 - ls_db;
=======
function [dbm] = W2dbm(W,ls_db)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dbm= 10.* log10(W) + 30 - ls_db;
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
end