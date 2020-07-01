% Calculate angle difference according to distance in RT

close all;
clear;

%% Parameters
d_1 = [1 2 5 10 50 100]; % distance Tx1-Rx1 in meters
aa_size = [2:128]';
AoA = pi/3; % angle of incidence in relation to Rx array axis in rad
delta_rx_spac = 0.5; %normalized distance between antennas
fc = 60*10^9;
lambda = physconst('LightSpeed')/fc;

%% Tringle size

% Law of cosines (plus sign due to the inner_angle = pi - ext_angle)


if 0<=AoA<pi/2
    for n_d = 1:length(d_1)
        c(:,n_d) = sqrt(d_1(n_d)^2+((aa_size-1).*delta_rx_spac.*lambda).^2+2.*d_1(n_d).*(aa_size-1).*delta_rx_spac.*lambda.*cos(AoA));
        
        d_approx(:,n_d) = d_1(n_d) + (aa_size-1).*delta_rx_spac.*lambda.*cos(AoA);
        
        cos_phi(:,n_d) = (-(d_1(n_d))^2 + ((aa_size-1).*delta_rx_spac.*lambda).^2 + c(:,n_d).^2)./...
            (2*(aa_size-1).*delta_rx_spac.*lambda.*c(:,n_d));
    end
elseif pi/2<=AoA<pi
    c(:,n_d) = sqrt(d_1(n_d)^2+((aa_size-1).*delta_rx_spac.*lambda).^2-2.*d_1(n_d).*(aa_size-1).*delta_rx_spac.*lambda.*cos(AoA));
    
    d_approx(:,n_d) = d_1(n_d) + (aa_size-1).*delta_rx_spac.*lambda.*cos(AoA);
    
    cos_phi(:,n_d) = (-(d_1(n_d))^2 + ((aa_size-1).*delta_rx_spac.*lambda).^2 + c(:,n_d).^2)./...
        (2*(aa_size-1).*delta_rx_spac.*lambda.*c(:,n_d));
end

AoA_deg = rad2deg(AoA);

AoA_calc = acos(mod(cos_phi,1));

AoA_calc_deg = rad2deg(AoA_calc);


figure;
plot(aa_size,AoA_deg-AoA_calc_deg);
title ("Geometrical model AoA (\phi_{const}) and exact geometrical AoA (\phi_i) difference");
xlabel ("Antenna index (i)");
ylabel ("Angle difference in degrees");
legend ("d = 1 m","d = 2 m","d = 5 m","d = 10 m","d = 50 m", "d = 100 m","location", "northwest");
grid on;

figure;
plot(aa_size,d_approx-c);
title ("Geometrical model distance from Tx-Rx_i and exact geometrical distance difference");
xlabel ("Antenna index (i)");
ylabel ("distance difference in meters");
legend ("d = 1 m","d = 2 m","d = 5 m","d = 10 m","d = 50 m", "d = 100 m","location", "southwest");
grid on;

figure;
plot(aa_size,cos(AoA)-cos_phi);
title ("Geometrical model \Omega = cos(\phi_{1}) from Tx-Rx_i and exact geometrical \Omega_i difference");
xlabel ("Antenna index (i)");
ylabel ("cos(\phi_1)-cos(\phi_i)");
legend ("d = 1 m","d = 2 m","d = 5 m","d = 10 m","d = 50 m", "d = 100 m","location", "southwest");
grid on;