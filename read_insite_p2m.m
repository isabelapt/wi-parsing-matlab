% filename_power = '/home/lasse/Documentos/5GMDATA/Rosslyn/myarea1/Rosslyn.power.t001_02.r016.p2m';
% filename_pl = '/home/lasse/Documentos/5GMDATA/Rosslyn/myarea1/Rosslyn.pl.t001_02.r016.p2m';
% filenamme_spread = '/home/lasse/Documentos/5GMDATA/Rosslyn/myarea1/Rosslyn.spread.t001_02.r016.p2m';
% filename_cir = '/home/lasse/Documentos/5GMDATA/Rosslyn/myarea1/Rosslyn.cir.t001_02.r016.p2m';
% filename_paths = '/home/lasse/Documentos/5GMDATA/Rosslyn/myarea1/Rosslyn.paths.t001_02.r016.p2m';



%% Script to read files p2m
%% Results per receiver
% Read the total received power (dBm) %% 
[power_phase,rx,rx_position] = power_insite(filename_power);

% Read Path Loss (dB) % 
[pl_db] = pldb_insite(filename_pl);

% Delay Spread (sec) % 
% [delayspread] = ds_insite(filename_spread);

% -250 is the power threshold to eliminate the receiver 
for i = 1:rx
    if power_phase(i,1) == -250 || length(power_phase)< rx 
        power_phase(i,:)= NaN;
    end
    if pl_db(i) == 250 || length(pl_db)< rx 
        pl_db(i)= NaN;
    end
end

%% Results per path
% Read the Complex Impulse Response
if rx ~=0
[time_arrival,powerpaths_dbm,phasepaths_deg,rx_paths,path_max_rx] =cir_insite(rx,paths_max,filename_cir);
else
    powerpaths_dbm=-Inf;
    phasepaths_deg=0;
    rx_paths=0;
    total_paths=0;
    paths_summary=0;
end

if powerpaths_dbm==-Inf
    powerpaths_W=0;
else
   powerpaths_W = dbm2W(powerpaths_dbm,ls_db); 
end

time_arrival = time_arrival(~isnan(time_arrival));
powerpaths_dbm = powerpaths_dbm(~isnan(powerpaths_dbm));
phasepaths_deg = phasepaths_deg(~isnan(phasepaths_deg ));
powerpaths_W = powerpaths_W(~isnan(powerpaths_W));


% Read the Propagation Paths
[rx_matrix,path_int,path_info,path_des,path_int_position] = paths_insite(rx,filename_paths,rx_paths,path_max_rx);

% Read the Complex Eletric Fields 
[e_phimag, e_phiphase,e_thetamag, e_thetaphase, ...
     e_xmag,e_xphase,e_ymag,e_yphase,e_zmag,e_zphase,rx_paths,path_max_rx] =cef_insite(rx,filename_cef);

% Calculate Complex Voltage 
% gain_theta = 2*pi/(inputpower_W*impedance);
% gain_phi = 2*pi/(inputpower_W*impedance);
% 
% doa_theta = sqrt(gain_theta)*exp(1j*e_thetaphase);
% doa_phi = sqrt(gain_phi)*exp(1j*e_phiphase);
% 
% e_phi_complex = e_phimag .* exp(1j*e_phiphase);
% e_theta_complex = e_thetamag .* exp(1j*e_thetaphase);
% 
% V = e_phi_complex.*doa_phi + e_theta_complex.*doa_theta


% [Xcart_phi,Ycart_phi] = pol2cart(deg2rad(e_phiphase),e_phimag);
% [Xcart_theta,Ycart_theta] = pol2cart(deg2rad(e_thetaphase),e_thetamag);
% 
% Vcomplex =  (Xcart_phi + Xcart_theta + 1j*(Ycart_phi+Ycart_theta));
% phase_cir = rad2deg(atan2(imag(Vcomplex),real(Vcomplex)));
% V_total = sum(Vcomplex);