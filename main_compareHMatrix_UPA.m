clear,clc;
% Add  mimo-toolbox path
% https://gitlab.lasse.ufpa.br/software/mimo-toolbox
addpath(genpath('../mimo-toolbox/'))

% % Add wi-parsing path
% % https://github.com/isabelapt/wi-parsing-matlab
% addpath(genpath('../wi-parsing-matlab/'))

%%%%%%%%%%%%%%%%%%%%%%%% Project Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
c= 3*10^8;                                  % Ligth Speed (m/s)
fo=2*10^9;                                  % Carrier Frequency (Hz)
lambda = c/fo;
BW = 20e06;                                 % Bandwidth (Hz)]
inputpower_dbm = 0;                         % Input Transmit Power (dB)
inputpower_W = dbm2W(inputpower_dbm);       % Input Transmit Power (W)
noiseFigure = 3;                            % Noise figure (in dB)
ls_db =0;                                   % Transmission Loss
noise_pd = -174;                            % dBm/Hz
uni_interf = -250;                          % dBm
paths_max=250;                              % Number of the maximum paths per receiver
total_array_input = 1;                      % Input Power is distributed among Tx elements (1) or not (0)

% Project Folder Name %
test_n = 'Test#13';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Read MIMO Output %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Number of Elements in Tx UPA axis 1%
numTx1 = 8; 
% Number of Elements in Tx UPA axis 2%
numTx2 = 8; 

% Number of Elements in Rx UPA axis 1%
numRx1 = 1; 
% Number of Elements in Rx UPA axis 2%
numRx2 = 1; 

path = fullfile(pwd,test_n,'sweden_mimo','studyarea');
rx=1;
txSet = '031';
rxSet = '029';

numRx = numRx1*numRx2;
numTx = numTx1*numTx2;

% Read H-Matrix.csv %
hmatrix_path = fullfile(path,'hmatrix');
[Hinsite_NrNt] = Hmatrix_insite(rx,numRx,numTx,hmatrix_path,txSet,rxSet);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read SISO Outputs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
project_name = 'test_siso';
txrxset ='t001_31.';
rx_set= 'r029';
end_name ='.p2m';

path = fullfile(pwd,test_n,'sweden_siso','studyarea');
filename_power=fullfile(path,strcat(project_name,'.power.',txrxset,rx_set,end_name));
filename_cir =fullfile(path,strcat(project_name,'.cir.',txrxset,rx_set,end_name));
filename_paths =fullfile(path,strcat(project_name,'.paths.',txrxset,rx_set,end_name));

[time_arrival,powerpaths_dbm,phasepaths_deg,rx_paths,path_max_rx]= cir_insite(rx,paths_max,filename_cir);
[rx_matrix,path_int,path_info,path_des,path_int_position] = paths_insite(rx,filename_paths,rx_paths,path_max_rx);

powerpaths_W = dbm2W(powerpaths_dbm);

%  Generate H Narrowband Channel based on Geometric Model
normalizedSpacingTx =0.5;
normalizedSpacingRx=0.5;
paths_gain = sqrt(powerpaths_W./inputpower_W);
phase_cir = deg2rad(phasepaths_deg);
complexGains = paths_gain .* exp(-1j*phase_cir);
AoA_el = squeeze(path_info(:,4,:));
AoA_az = squeeze(path_info(:,5,:));
AoD_el = squeeze(path_info(:,6,:));
AoD_az = squeeze(path_info(:,7,:));

% Correct angles to start from the specific UPA azimuth axis
delta_axis = 90; % The angle difference among x axis and UPA azimuth axis
AoA_az_new = correctangles_wi(AoA_az,delta_axis);
AoD_az_new = correctangles_wi(AoD_az,delta_axis);

% AoA_az_new =AoA_az;
% AoD_az_new = AoD_az;


for i=1:rx
    H_upa(:,:,i)=narrowbandUPAsMIMOChannel(numTx1,numTx2,numRx1,numRx2, normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i));    
end

% Show NMSE error comparing both H-Matrix

error_abs = nmse(abs(H_upa),abs(Hinsite_NrNt))
error_phase  = nmse(angle(H_upa),angle(Hinsite_NrNt))

error_H = nmse(H_upa,Hinsite_NrNt)