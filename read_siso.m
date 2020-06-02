%% Read SISO outputs %%



read_insite_p2m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate H Narrowband and Normalize using frobernius
% Geometric Narrowband Channel
normalizedSpacingTx =0.5;
normalizedSpacingRx=0.5;
time_arrival =  squeeze(path_info(:,3,:));
delay = exp(-1j*2*pi*fo*time_arrival);
paths_gain = sqrt(powerpaths_W./inputpower_W);
phase_cir = deg2rad(phasepaths_deg);
complexGains = paths_gain .* exp(-1j*phase_cir);
AoA_el = squeeze(path_info(:,4,:));
AoA_az = squeeze(path_info(:,5,:));
AoD_el = squeeze(path_info(:,6,:));
AoD_az = squeeze(path_info(:,7,:));


% The angle difference among x axis and ula axis
delta_axis = 135;

for i=1:rx
    H_ula(:,:,i)=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az(:,i),AoD_az(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i),delta_axis);    
end

noise_out = dbm2W(noise_pd,0) * BW;

% Calculate SNR AND SINR
noise_total = W2dbm(noise_out,0) + noiseFigure;
interference_total = uni_interf;
SNR = power_phase(:,1) - noise_total; 
SINR = SNR;


% Read Outputs from Communication System
path_comm = strcat(path,'system\');
filename_noise = strcat(path_comm,project_name,'.noise.','t1_31.r29',end_name);
noise = dlmread(filename_noise ,'',2,0);
interference_db = noise(:,6);
noise_db = noise(:,7);
SNR_db_siso = noise(:,8);
SINR_db_siso = noise(:,10);

% Capacity WI %bit/sec
C_siso_WI= BW*log2(1+10.^(SINR_db_siso/10)); 
SE_siso_WI = C_siso_WI/BW;
