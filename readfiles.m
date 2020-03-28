% function readfiles(project_name,txrxset,rx_set,end_name,n_tx_set,n_rx_set)% Initialize the vectors/matrices with no elements

% Variables related with receiver
rx_position_all = []; % Nrx x 3 x n_routes (3 - xyz)
power_phase_all = []; % Nrx x 2 x n_routes (2 - Power, Phase)
pl_db_all = [];       % Nrx x n_routes
delayspread_all = []; % Nrx x n_routes
rx_paths_all = [];    % Nrx x n_routes

% Variables related with receiver/paths
powerphase_deg_all=[];
time_arrival_all=[];
powerpaths_dbm_all=[];
powerpaths_W_all=[];
path_info_all=[];
path_int_all=[];
path_des_all=[];
path_int_position_all=[];

% In this project each rx set is a route with n receivers

 for rx_set= n_tx_set+1:n_rx_set+1
    filename_power=strcat(project_name,'.power.',txrxset,num2str(rx_set),end_name);
    filename_pl=strcat(project_name,'.pl.',txrxset,num2str(rx_set),end_name);
    filename_spread=strcat(project_name,'.spread.',txrxset,num2str(rx_set),end_name);
    filename_cir = strcat(project_name,'.cir.',txrxset,num2str(rx_set),end_name);
    filename_paths = strcat(project_name,'.paths.',txrxset,num2str(rx_set),end_name);
    
    
    %% Script to read files from InSite Output
    if exist(filename_power, 'file')
        run read_insite_p2m.m
        n_rx_routes(rx_set-1) = rx; % rx from read_insite_p2m
        n_maxpath_route(rx_set-1) = path_max_rx; % rx from read_insite_p2m
        
        
        %     If that route has less than rx_max that would be zero
        if rx == rx_max
            % Results per receiver
            rx_position_all(:,1:3,rx_set-1)= rx_position;
            power_phase_all(:,1:2,rx_set-1)= power_phase;
            pl_db_all(:,rx_set-1) = pl_db;
            delayspread_all(:,rx_set-1) = delayspread;
            rx_paths_all(:,rx_set-1) = rx_paths;
            
            % Results per path
            powerphase_deg_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=powerphase_deg;
            time_arrival_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=time_arrival;
            powerpaths_dbm_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=powerpaths_dbm;
            powerpaths_W_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=powerpaths_W;
            path_info_all(1:n_maxpath_route(rx_set-1),:,:,rx_set-1)= path_info; %path, info, rx, route
            path_int_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)= path_int;
            path_des_all{rx_set-1}(1:n_maxpath_route(rx_set-1),:)=path_des;
            path_int_position_all{rx_set-1}(1:n_maxpath_route(rx_set-1),:,:)=path_int_position;
        else
            %if rx < rx_max
            % Results per receiver
            rx_position(length(rx_position)+1:rx_max,:) = NaN;
            power_phase(length(power_phase)+1:rx_max,:) = NaN;
            pl_db(length(pl_db)+1:rx_max) = NaN ;
            delayspread(length(delayspread)+1:rx_max) = NaN ;
            rx_paths(length(rx_paths)+1:rx_max) = NaN;
            
            % Results per path
            powerphase_deg(:,length(powerphase_deg(1,:))+1:rx_max)=NaN;
            time_arrival(:,length(time_arrival(1,:))+1:rx_max)=NaN;
            powerpaths_dbm(:,length(powerpaths_dbm(1,:))+1:rx_max)=NaN;
            powerpaths_W(:,length(powerpaths_W(1,:))+1:rx_max)=NaN;
            path_info(:,:,length(path_info(1,:,:))+1:rx_max)= NaN;
            path_int(:,length(path_int(1,:))+1:rx_max)=NaN;
            %             path_des(n_maxpath_route(rx_set-1)+1:rx_max,:)=NaN;
            %             path_int(n_maxpath_route(rx_set-1)+1:rx_max,:,:)=NaN;
            
            
            % Results per receiver
            rx_position_all(:,:,rx_set-1)= rx_position;
            power_phase_all(:,:,rx_set-1)= power_phase;
            pl_db_all(:,rx_set-1) = pl_db;
            delayspread_all(:,rx_set-1) = delayspread;
            rx_paths_all(:,rx_set-1)= rx_paths;
            
            % Results per path
            powerphase_deg_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=powerphase_deg;
            time_arrival_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=time_arrival;
            powerpaths_dbm_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=powerpaths_dbm;
            powerpaths_W_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)=powerpaths_W;
            path_info_all(1:n_maxpath_route(rx_set-1),:,:,rx_set-1)= path_info;
            path_int_all(1:n_maxpath_route(rx_set-1),:,rx_set-1)= path_int;
            path_des_all{rx_set-1}=path_des(:,:);
            path_int_position_all{rx_set-1}=path_int_position(:,:);
        end
    end
 end
% end