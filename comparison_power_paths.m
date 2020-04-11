<<<<<<< HEAD
function [rx_W,rx_phase] =  comparison_power_paths(powerpaths_W,powerphase_deg)
format long
phase_rad = deg2rad(powerphase_deg);

V=sqrt(powerpaths_W);
[x_path,y_path] = pol2cart(phase_rad,V);

rx_x = sum(x_path);
rx_y = sum(y_path);

[rx_phase,rx_V]=cart2pol(rx_x,rx_y);


rx_phase=rad2deg(rx_phase);
rx_W=rx_V.^2;
end

=======
function [rx_W,rx_phase] =  comparison_power_paths(powerpaths_W,powerphase_deg)
format long
phase_rad = deg2rad(powerphase_deg);

V=sqrt(powerpaths_W);
[x_path,y_path] = pol2cart(phase_rad,V);

rx_x = sum(x_path);
rx_y = sum(y_path);

[rx_phase,rx_V]=cart2pol(rx_x,rx_y);


rx_phase=rad2deg(rx_phase);
rx_W=rx_V.^2;
end

>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
