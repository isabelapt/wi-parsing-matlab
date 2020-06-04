clear,clc;
tic
% Add  mimo-toolbox path
% https://gitlab.lasse.ufpa.br/software/mimo-toolbox
addpath(genpath('../mimo-toolbox/'))

%%%%%%%%%%%%%%%%%%%%%%%% Project Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
c= 3*10^8;                                  % Ligth Speed (m/s)
fo = 2*10^9;                                  % Carrier Frequency (Hz)
BW = 20e06;                                 % Bandwidth (Hz)]
inputpower_dbm = 0;                         % Input Transmit Power (dB)

%

inputpower_W = dbm2W(inputpower_dbm);       % Input Transmit Power (W)
noiseFigure = 3;                            % Noise figure (in dB)
ls_db =0;                                   % Transmission Loss
noise_pd = -174;                            % dBm/Hz
uni_interf = -250;                          % dBm
paths_max=250;                              % maximum number of the paths per receiver

% Number os Tx and Rx Points
numTxpoints = 1;
numRxpoints = 5;

%% Main paths of directory results
main_path = 'C:\Users\isabe\OneDrive\Documentos\LASSE\SISO2MIMO\Scenario1\';
path_siso = fullfile(main_path,'siso@2GHz','Tx@P1');
path_mimo = fullfile(main_path,'mimo@2GHz','Tx@P1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read SISO Outputs %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
read_siso

save_mat = fullfile(path_siso,'runtime_siso.mat');

save(save_mat,'runtime_siso');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Read MIMO Output %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MIMO Parameters %%
project_name = 'test_mimo';
folder = 'ULA16';
save_mat = fullfile(path_mimo,strcat(folder,'.mat'));

% Number of Elements in ULA axis %
numTx =16; 
numRx =16;

read_mimo

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate H Narrowband Channel based on Geometric Model %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters %%
delta_axis_rx = 90;                         % The angle difference among x 
                                            % axis and ula axis
                                            
delta_axis_tx = 90;                         % The angle difference among x 
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
for i =1 :numRxpoints
% error_abs(i) = nmse(abs(H_ULA(:,:,i)),abs(Hinsite_NrNt(:,:,i)));
% error_phase(i)  = nmse(angle(H_ULA(:,:,i)),angle(Hinsite_NrNt(:,:,i)));
error_H(i) = nmse(H_ULA(:,:,i),Hinsite_NrNt(:,:,i));
end

%% SAVE %%
save(save_mat,'exec_time','runtime_mimo','H_ULA', 'Hinsite_NrNt', 'error_H');

%% SEE error_nmse_ula.m