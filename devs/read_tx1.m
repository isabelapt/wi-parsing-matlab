<<<<<<< HEAD
% n_tx_set =1;       % Number of Transmiter Set
% n_routes= 6;       % Number of Routes, in this case same number of Rx set
% n_rx_set = n_routes;
% spacing = 1.25;    % Spacing among receivers of the route
% rx_max=210;        % Maximum Number of receivers per route, in all routes
% paths_max=250;     % Number of the maximum paths per receiver
% 
% % The Tx position is going to be need to correct distance around corners, NLOS cases
% Tx_pos= [228.374517868435220 -103.816602192616386];
%%
% Save these variables
save(strcat('variables_',num2str(project_simulation),'.mat'),'rx_max','spacing',...
    'n_tx_set','n_rx_set','n_routes','paths_max','Tx_pos','project_simulation');
% Add the path where the *.p2m  files are stored
addpath(path_p2m);
run readfiles.m
save(strcat('results_',num2str(project_simulation),'.mat'),'power_phase_all',...
    'rx_position_all','pl_db_all','delayspread_all','powerphase_deg_all',...
    'time_arrival_all','powerpaths_dbm_all','powerpaths_W_all','rx_paths_all','n_rx_routes','n_maxpath_route',...
    'path_info_all','path_int_all','path_des_all','path_int_position_all');

=======
% n_tx_set =1;       % Number of Transmiter Set
% n_routes= 6;       % Number of Routes, in this case same number of Rx set
% n_rx_set = n_routes;
% spacing = 1.25;    % Spacing among receivers of the route
% rx_max=210;        % Maximum Number of receivers per route, in all routes
% paths_max=250;     % Number of the maximum paths per receiver
% 
% % The Tx position is going to be need to correct distance around corners, NLOS cases
% Tx_pos= [228.374517868435220 -103.816602192616386];
%%
% Save these variables
save(strcat('variables_',num2str(project_simulation),'.mat'),'rx_max','spacing',...
    'n_tx_set','n_rx_set','n_routes','paths_max','Tx_pos','project_simulation');
% Add the path where the *.p2m  files are stored
addpath(path_p2m);
run readfiles.m
save(strcat('results_',num2str(project_simulation),'.mat'),'power_phase_all',...
    'rx_position_all','pl_db_all','delayspread_all','powerphase_deg_all',...
    'time_arrival_all','powerpaths_dbm_all','powerpaths_W_all','rx_paths_all','n_rx_routes','n_maxpath_route',...
    'path_info_all','path_int_all','path_des_all','path_int_position_all');

>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
rmpath(path_p2m);