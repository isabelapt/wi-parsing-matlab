function [rx_W,rx_phase] =  sum_power_phase(W,phase)
format long
phase_rad = phase;

V=sqrt(W);
[x_path,y_path] = pol2cart(phase_rad,V);

rx_x = sum(x_path);
rx_y = sum(y_path);

[rx_phase,rx_V]=cart2pol(rx_x,rx_y);

rx_phase=rad2deg(rx_phase);
rx_W=rx_V.^2;
end

