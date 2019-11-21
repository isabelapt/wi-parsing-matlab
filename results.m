clear,clc;
close all;
load('results_v2.mat')
load('rx_max')
% run correct_distance
%% The path loss exponent model 
d0= 5; % Reference distance
n_los=2.2;
pl_los_d0 = 82.04;
n_nlos=3.26;
pl_nlos_d0 = 80.4;
d=[4:1:200]; % Distance
pl_los_d = pl_los_d0 + 10 *n_los* log10(d/d0);
pl_nlos_d = pl_nlos_d0 + 10 *n_nlos* log10(d/d0);

figure
semilogx(d,pl_los_d);
set (gca,'Ydir','reverse')
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title('LOS path loss');

% The Route 1 & 2 are considered LOS PATHS

% pl_db_insite_los_Tx1 =pl_db_insite_all(1,:,1:2);
% distance_los_Tx1 = distance_all(1,:,1:2);
% 
% pl_db_insite_los_Tx2 =pl_db_insite_all(2,:,1:2);
% distance_los_Tx2 = distance_all(2,:,1:2);
% 
% pl_db_insite_los_Tx1=reshape(pl_db_insite_los_Tx1,[1 length(distance_los_Tx1)]);
% pl_db_insite_los_Tx2=reshape(pl_db_insite_los_Tx2,[1 length(distance_los_Tx2)]);
% hold on
% semilogx(distance_los_Tx_1,pl_db_insite_los_Tx1,'ro');
% hold on 
% semilogx(distance_los_Tx_2,pl_db_insite_los_Tx2,'*g');
% figure
% semilogx(d,pl_los_d);
% set (gca,'Ydir','reverse')
% grid on
% xlabel('Tx-Rx distance(m)');
% ylabel('Path loss (dB)');
% title('LOS path loss');
% 
% % The Route 3:6 are considered NLOS PATHS
% 
% pl_db_insite_los =pl_db_insite_all(:,:,1:2);
% 
% figure
% semilogx(d,pl_nlos_d);
% set (gca,'Ydir','reverse')
% grid on
% xlabel('Tx-Rx distance(m)');
% ylabel('Path loss (dB)');
% title('NLOS path loss');

% The Route 3:6 are considered NLOS PATHS

pl_db_insite_nlos =pl_db_insite_all(:,:,3:6);
% distance_nlos = distance_all(:,:,3:6);
el_nlos = 2*22*4;

% distance_nlos=reshape(distance_nlos,[1 el_nlos]);
pl_db_insite_nlos=reshape(pl_db_insite_nlos,[1 length(distance_nlos)]);


hold on
semilogx(distance_nlos,pl_db_insite_nlos,'ro');

%% Delay Spread
% Root mean square (rms) delay spread as the second moment of APDPs

% Taken at the same location at 68 m Tx-Rx



