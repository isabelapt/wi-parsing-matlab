close all;
clear,clc;
tic
% Add  mimo-toolbox path
% https://gitlab.lasse.ufpa.br/software/mimo-toolbox
addpath(genpath('../mimo-toolbox/'))

%%%%%%%%%%%%%%%%%%%%%%%% Project Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
c= physconst('LightSpeed');                 % Ligth Speed (m/s)
fo = 2e09;                                  % Carrier Frequency (Hz)
BW = 20e06;                                 % Bandwidth (Hz)]
inputpower_dbm = 0;                         % Input Transmit Power (dB)
lambda = c/fo;

%

inputpower_W = dbm2W(inputpower_dbm);       % Input Transmit Power (W)
% noiseFigure = 3;                            % Noise figure (in dB)
% ls_db =0;                                   % Transmission Loss
% noise_pd = -174;                            % dBm/Hz
% uni_interf = -250;                          % dBm
paths_max=250;                              % maximum number of the paths per receiver

% Number os Tx and Rx Points
numTxpoints = 1;
numRxpoints = [11,4]; %

%% Main paths of directory results
main_path = 'C:\Users\isabe\OneDrive\Documentos\LASSE\SISO2MIMO\Scenario2\';
path_siso = fullfile(main_path,'ULA_Y','siso@2GHz');
path_mimo = fullfile(main_path,'ULA_Y','mimo@2GHz');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read SISO Outputs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
project_name = 'box';
txrxset ='t001_09.';
rx_set= ["r008","r010"];

path = fullfile(path_siso,'study');

read_siso

save_mat = fullfile(path_siso,'runtime_siso.mat');

save(save_mat,'runtime_siso');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Read MIMO Output %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MIMO Parameters %%
project_name = 'box';
% folder = 'ULA64';
% save_mat = fullfile(path_mimo,strcat(folder,'.mat'));

% Number of Elements in ULA axis %
numTx =64; 
numRx =64;

path = fullfile(path_mimo,'study');

txSet = '009';
rxSet = ["008","010"];

read_mimo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate H Narrowband Channel based on Geometric Model %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters %%
delta_axis_rx = 90;                         % The angle difference in degrees among x 
                                            % axis and ula axis
                                            
delta_axis_tx = 90;                         % The angle difference in degrees among x 
                                            % axis and ula axis
                                            
total_array_input = 1;                      % Input Power is distributed among 
                                            % Tx elements (1) or not (0)
                                            
geometric_model_ula

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RESULTS %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store Execution Time
exec_time = toc

% Show NMSE error comparing both H-Matrix

for i =1:15
error_abs(i) = nmse(abs(H_ULA(:,:,i)),abs(Hinsite_NrNt_all(:,:,i)));
error_phase(i)  = nmse(angle(H_ULA(:,:,i)),angle(Hinsite_NrNt_all(:,:,i)));
error_H(i) = nmse(H_ULA(:,:,i),Hinsite_NrNt_all(:,:,i));
end

for i =1:15
error_abs_2(i) = nmse(abs(H_ULA_2(:,:,i)),abs(Hinsite_NrNt_all(:,:,i)));
error_phase_2(i)  = nmse(angle(H_ULA_2(:,:,i)),angle(Hinsite_NrNt_all(:,:,i)));
error_H_2(i) = nmse(H_ULA_2(:,:,i),Hinsite_NrNt_all(:,:,i));
end

%% SAVE %%
save(save_mat,'exec_time','runtime_mimo','H_ULA', 'Hinsite_NrNt', 'error_H');


% %% Capacity 
% [C_ULA] = CvsSNR_EqualPowerAllocation(-20:20,H_ULA(:,:,2),1);
% [C_INSITE] = CvsSNR_EqualPowerAllocation(-20:20,Hinsite_NrNt(:,:,2),1);
% 
% figure
% plot(-20:20,C_ULA,'-.*','LineWidth',1)
% hold on
% plot(-20:20,C_INSITE,'-.*','LineWidth',1)
% title('Rx2')
% legend('SISO','WI')
% 
% [C_ULA] = CvsSNR_EqualPowerAllocation(-20:20,H_ULA(:,:,8),1);
% [C_INSITE] = CvsSNR_EqualPowerAllocation(-20:20,Hinsite_NrNt(:,:,8),1);
% figure
% plot(-20:20,C_ULA,'-.*','LineWidth',1)
% hold on
% plot(-20:20,C_INSITE,'-.*','LineWidth',1)
% title('Rx8')
% legend('SISO','WI')