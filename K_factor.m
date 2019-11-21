%% Calculate K factor
format long
%% LOS SCENARIO
%% K Factor per receiver
% Considering the path of the shortest delay as LOS
time_arrival_los_1 = squeeze(path_info_all(:,3,:,1));
time_arrival_los_2 = squeeze(path_info_all(:,3,:,2));

% time_arrival_dominant =[];
time_arrival_los = [time_arrival_los_1 time_arrival_los_2];

% Find the first ray 
[short_time_los i_short_time_los] = min(time_arrival_los);

% Find the corresponding power
powerpaths_dbm_dominant1 = powerpaths_dbm_all(:,:,1);
powerpaths_dbm_dominant2 = powerpaths_dbm_all(:,:,2);

% powerpaths_dbm_dominant =[];
powerpaths_dbm_dominant = [powerpaths_dbm_dominant1  powerpaths_dbm_dominant2];

for i=1:length(short_time_los)
short_powerdbm_dominant(1,i) = powerpaths_dbm_all(i_short_time_los(i),i);
short_powerW_dominant(1,i) = dbm2W(short_powerdbm_dominant(1,i));
end

i_scattering_time =[];
% Find the scattering components
for j=1:length(short_powerW_dominant)
    a = 1:i_short_time_los(j)-1;
    b = i_short_time_los(j)+1:250;
    i_scattering_time(:,j) =  [a b]; 
    powerdbm_scattering(:,j) = powerpaths_dbm_all(i_scattering_time(:,j),j);
    powerW_scattering(:,j) = dbm2W (powerdbm_scattering(:,j));
end

% powerdbm_scattering = powerpaths_dbm_dominant (i_scattering_time);
% powerW_scattering = dbm2W (powerdbm_scattering);

sum_powerW_scattering = sum(powerW_scattering);
KfactorLOS = short_powerW_dominant./sum_powerW_scattering;
KfactorLOS_db = 10* log10(KfactorLOS);

% %% NLOS SCENARIO
% % Considering the path of the shortest delay as LOS
% time_arrival_dominant_3 = squeeze(path_info_all(:,3,:,3));
% time_arrival_dominant_4 = squeeze(path_info_all(:,3,:,4));
% time_arrival_dominant_5 = squeeze(path_info_all(:,3,:,5));
% time_arrival_dominant_6 = squeeze(path_info_all(:,3,:,6));
% 
% time_arrival_dominant =[];
% time_arrival_dominant = [time_arrival_dominant_3 time_arrival_dominant_4 ...
%     time_arrival_dominant_5 time_arrival_dominant_6];
% 
% % Find the first ray 
% [short_time i_short_time] = min(time_arrival_dominant);
% 
% % Find the corresponding power
% powerpaths_dbm_dominant3 = powerpaths_dbm_all(:,:,3);
% powerpaths_dbm_dominant4 = powerpaths_dbm_all(:,:,4);
% powerpaths_dbm_dominant5 = powerpaths_dbm_all(:,:,5);
% powerpaths_dbm_dominant6 = powerpaths_dbm_all(:,:,6);
% 
% powerpaths_dbm_dominant =[];
% powerpaths_dbm_dominant = [powerpaths_dbm_dominant3  powerpaths_dbm_dominant4 ...
%     powerpaths_dbm_dominant5  powerpaths_dbm_dominant6];
% 
% short_powerdbm_dominant = powerpaths_dbm_dominant (i_short_time);
% short_powerW_dominant = dbm2W(short_powerdbm_dominant);
% 
% % Find the scattering components
% for j=1:length(short_powerW_dominant)
%     a = 1:i_short_time(j)-1;
%     b = i_short_time(j)+1:250;
%     i_scattering_time(:,j) =  [a b];       
% end
% 
% powerdbm_scattering = powerpaths_dbm_dominant (i_scattering_time);
% powerW_scattering = dbm2W (powerdbm_scattering);
% 
% sum_powerW_scattering = sum(powerW_scattering);
% KfactorNLOS = short_powerW_dominant./sum_powerW_scattering;
% KfactorNLOS_db = 10* log10(KfactorNLOS);

% [dist_los_sort dist_los_i] = sort(dist_los);
% 
% K_factorLOS = K_factorLOS(dist_los_i);
% K_factorLOS_db = K_factorLOS_dB(dist_los_i);
    
save(strcat('Kfactor_',num2str(project_simulation),'.mat'),'KfactorLOS','KfactorLOS_db');