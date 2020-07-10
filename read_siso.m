%% Read SISO outputs %%
time_arrival_all = [];
powerpaths_dbm_all = [];
phasepaths_deg_all = [];
path_int_all = [];
path_info_all = [];
path_des_all = [];
path_int_position_all = [];

i = 1;
% filename_power(i)=fullfile(path,strcat(project_name,'.power.',txrxset,rx_set(i),'.p2m'));
filename_cir(i) =fullfile(path,strcat(project_name,'.cir.',txrxset,rx_set(i),'.p2m'));
filename_paths(i) =fullfile(path,strcat(project_name,'.paths.',txrxset,rx_set(i),'.p2m'));

[time_arrival,powerpaths_dbm,phasepaths_deg,rx_paths,path_max_rx]= cir_insite(numRxpoints(i),...
    paths_max,filename_cir(i));
[rx_matrix,path_int,path_info,path_des,path_int_position] = paths_insite(numRxpoints(i),...
    filename_paths(i),rx_paths,path_max_rx);

time_arrival_all = [time_arrival_all, time_arrival(:,1:numRxpoints(i))];
powerpaths_dbm_all = [powerpaths_dbm_all, powerpaths_dbm(:,1:numRxpoints(i))];
phasepaths_deg_all = [phasepaths_deg_all, phasepaths_deg(:,1:numRxpoints(i))];
path_int_all = [path_int_all, path_int(:,1:numRxpoints(i))];
path_des_all = [path_des_all, path_des(:,1:numRxpoints(i))];
path_int_position_all = cat(3,path_int_position_all, path_int_position(:,:,1:numRxpoints(i)));
path_info_all = cat(3,path_info_all, path_info(:,:,1:numRxpoints(i)));
% end

% Paths Power
powerpaths_W_all = dbm2W(powerpaths_dbm_all);

% Calculate the distance between the last interaction point and receiver
for i = 1:numRxpoints
    for j = 1:rx_paths(i)
        end_int(:,j,i) = [4,5,6] + path_int_all(j,i)*3;
        last_int(:,j,i) = end_int(:,j,i)-3;
        a = path_int_position_all(j,end_int(:,j,i),i);
        b = path_int_position_all(j,last_int(:,j,i),i);
        D(j,i) = vecnorm(a - b, 2, 2);
    end
end

% % Plot Histograms
% plot_hist_dist 
% plot_hist_aoa_aod


% Angle of arrival and departure (azimuth and elevation) per path
AoA_el = squeeze(path_info_all(:,4,:));
AoA_az = squeeze(path_info_all(:,5,:));
AoD_el = squeeze(path_info_all(:,6,:));
AoD_az = squeeze(path_info_all(:,7,:));

% Read Simulation Time
file_time  =  fullfile(path_siso,strcat(project_name,'.study.diag'));
[runtime_siso] = readruntime(file_time); % Hour Minute Second

% read_insite_p2m
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Generate H Narrowband and Normalize using frobernius
% % Geometric Narrowband Channel
% normalizedSpacingTx =0.5;
% normalizedSpacingRx=0.5;
% time_arrival =  squeeze(path_info(:,3,:));
% delay = exp(-1j*2*pi*fo*time_arrival);
% paths_gain = sqrt(powerpaths_W./inputpower_W);
% phase_cir = deg2rad(phasepaths_deg);
% complexGains = paths_gain .* exp(-1j*phase_cir);
% AoA_el = squeeze(path_info(:,4,:));
% AoA_az = squeeze(path_info(:,5,:));
% AoD_el = squeeze(path_info(:,6,:));
% AoD_az = squeeze(path_info(:,7,:));
% 
% 
% % The angle difference among x axis and ula axis
% delta_axis = 135;
% 
% for i=1:rx
%     H_ula(:,:,i)=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
%         normalizedSpacingRx,AoA_az(:,i),AoD_az(:,i),AoA_el(:,i),AoD_el(:,i),...
%         complexGains(:,i),delta_axis);    
% end
% 
% noise_out = dbm2W(noise_pd,0) * BW;
% 
% % Calculate SNR AND SINR
% noise_total = W2dbm(noise_out,0) + noiseFigure;
% interference_total = uni_interf;
% SNR = power_phase(:,1) - noise_total; 
% SINR = SNR;
% 
% 
% % Read Outputs from Communication System
% path_comm = strcat(path,'system\');
% filename_noise = strcat(path_comm,project_name,'.noise.','t1_31.r29',end_name);
% noise = dlmread(filename_noise ,'',2,0);
% interference_db = noise(:,6);
% noise_db = noise(:,7);
% SNR_db_siso = noise(:,8);
% SINR_db_siso = noise(:,10);
% 
% % Capacity WI %bit/sec
% C_siso_WI= BW*log2(1+10.^(SINR_db_siso/10)); 
% SE_siso_WI = C_siso_WI/BW;
