function [W] = dbm2W(dbm)
% W = 10.^((dbm - 30 + ls_db) / 10); 

W = 10.^((dbm - 30) / 10); 

end
