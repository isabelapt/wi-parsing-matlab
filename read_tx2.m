n_tx_set =1;      % Number of Transmiter Set
n_routes= 6;    % Number of Routes, in this case same number of Rx set
n_rx_set = n_routes;
spacing = 1.25; % Spacing among receivers of the route
rx_max=247;     % Maximum Number of receivers per route
paths_max=250;   % Number of the maximum paths per receiver

% The Tx position is going to be need to correct distance around corners, NLOS cases
Tx_pos= [106.847536197464606 -87.062795851269811];
%%
% Save these variables
save(strcat('variables_',num2str(project_simulation),'.mat'),'rx_max','spacing',...
	'n_tx_set','n_rx_set','n_routes','paths_max','Tx_pos','project_simulation');

% Add the path where the *.p2m  files are stored
addpath(path_p2m);
run readfiles.m

for i=1:6
    for j=1:n_rx_routes(i)
        if i<3
            if path_int_all(1,j,i)~=0
                path_int_all(:,j,i)= NaN;
                powerphase_deg_all(:,j,i)=NaN;
                time_arrival_all(:,j,i)=NaN;
                powerpaths_dbm_all(:,j,i)=NaN;
                powerpaths_W_all(:,j,i)=NaN;
                %         los_wrong_rx = [los_wrong_rx j];
                %         los_wrong_route =[los_wrong_route i];
            end
        else
            if path_int_all(1,j,i)==0
                path_int_all(:,j,i)=NaN;
                powerphase_deg_all(:,j,i)=NaN;
                time_arrival_all(:,j,i)=NaN;
                powerpaths_dbm_all(:,j,i)=NaN;
                powerpaths_W_all(:,j,i)=NaN;
                
                %         nlos_wrong_rx = [nlos_wrong_rx j];
                %         nlos_wrong_route = [nlos_wrong_route i];
            end
        end
    end
end
save(strcat('results_',num2str(project_simulation),'.mat'),'power_phase_all',...
    'rx_position_all','pl_db_all','delayspread_all','powerphase_deg_all',...
    'time_arrival_all','powerpaths_dbm_all','powerpaths_W_all','rx_paths_all','n_rx_routes','n_maxpath_route',...
    'path_info_all','path_int_all','path_des_all','path_int_position_all');

rmpath(path_p2m);

