function [W] = dbm2W(dbm,ls_db)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

W = 10.^((dbm - 30 + ls_db) / 10); 

end

