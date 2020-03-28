function [totaldiff_power,totaldiff_phase] = comparison_totalpower(ds_power_file,ls_db)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

specularpower_W=dbm2W(ds_power_file(:,6),ls_db);
specularphase_rad=deg2rad(ds_power_file(:,7));
diffusepower_W=dbm2W(ds_power_file(:,8),ls_db);
diffusephase_rad = deg2rad(ds_power_file(:,9));

[x_path1,y_path1] = pol2cart(specularphase_rad,specularpower_W);
[x_path2,y_path2] = pol2cart(diffusephase_rad,diffusepower_W);

total_x = x_path1+x_path2;
total_y = y_path1+y_path2;

[total_phase,total_mag]=cart2pol(total_x,total_y);

totalpower_dbm= W2dbm(total_mag,ls_db);
totalphase_deg = rad2deg(total_phase);

totaldiff_power = abs(ds_power_file(:,11)- totalpower_dbm);
totaldiff_phase = abs(ds_power_file(:,12)- totalphase_deg);
end

