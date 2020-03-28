%% Calculations %%
% Project Parameters %
%c= 3*10^8;    % Ligth Speed ( m/s )5
%fo=60*10^9;   % Carrier Frerx_setuency ( Hz )
%paths_max=250;   % Number of the maximum paths per receiver
%pt_dbm=15;    % Transmitter Power
%ls_db =0;     % Transmission Line Loss
%gt_max=-0.7;   % dbi
%gr_max=-0.7;   % dbi
%ds_enable = 0; % 0 disable, 1 enable

% Project simulation 
project_simulation = 1;

tx_set =1;      % Number of Transmiter Set
n_routes= 6;    % Number of Routes, in this case same number of Rx set
n_rx_set = n_routes; 
spacing = 1.25; % Spacing among receivers of the route
rx_max=210;     % Maximum Number of receivers per route
paths_max=250;   % Number of the maximum paths per receiver

% The Tx position is going to be need to correct distance around corners, NLOS cases
% Tx_pos= [228.374517868435220 -103.816602192616386]; 

project_name = 'berlin_tcc';
txrxset = 't001_01.r00';
end_name = '.p2m';

%%

% Save these variables
save(strcat('variables_',num2str(project_simulation),'.mat'),'rx_max','spacing','tx_set','n_routes','paths_max','Tx_pos','project_simulation');

% Add the path where the *.p2m  files are stored
addpath(path_p2m);
run readfiles.m


