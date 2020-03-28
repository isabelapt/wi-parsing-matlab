% Script to simulate a narrowband geometric model
% clear,clc;
% close all;
% format longEng
% restoredefaultpath
% addpath('/home/lasse/Documentos/5GMDATA/mimo-matlab')
%% Information to read WI Output
addpath('../SISO_simulation/results');
load(strcat('results_1.mat'));
load(strcat('correctdistances_1.mat'));
Nroute=2; % LOS Routes
ls_db=0; % Transmission line loss (db)
B=250*10^6;

%% LOS 
power_rxdbM = squeeze(power_phase_all(:,1,1:2));

power_rxW = squeeze(dbm2W(power_phase_all(:,1,1:2),ls_db));
power_rxW = [power_rxW(:,1); power_rxW(:,2)]';
power_rxW(isnan(power_rxW)==1)=[];

powerpaths_W = powerpaths_W_all(:,:,1:2); 
powerpaths_W = [powerpaths_W(:,1:n_rx_routes(1),1) powerpaths_W(:,1:n_rx_routes(2),2)];
powerpaths_W(isnan(power_rxW)==1)=0;

powerphase_deg = powerphase_deg_all(:,:,1:2);
powerphase_deg = [powerphase_deg(:,1:n_rx_routes(1),1) powerphase_deg(:,1:n_rx_routes(2),2)];

% doa_theta= squeeze(path_info_all(:,4,:,1:2));
% doa_theta=[doa_theta(:,:,1) doa_theta(:,:,2)];

doa_phi= squeeze(path_info_all(:,5,:,1:2));
doa_phi=[doa_phi(:,1:n_rx_routes(1),1) doa_phi(:,1:n_rx_routes(2),2)];

% dod_theta= squeeze(path_info_all(:,6,:,1:2));
% dod_theta=[dod_theta(:,:,1) dod_theta(:,:,2)];

dod_phi= squeeze(path_info_all(:,7,:,1:2));
dod_phi=[dod_phi(:,1:n_rx_routes(1),1) dod_phi(:,1:n_rx_routes(2),2)];

rx = n_rx_routes(1) +  n_rx_routes(2);

[distlos_sort,distlos_i]=sort(dist_los);

%% Information to use function to create the model
numRx=4;
numTx=4;
Nrx=numRx;
Ntx=numTx;
normalizedSpacingRx=0.5;
normalizedSpacingTx=0.5;
AoA_az=deg2rad(abs(doa_phi-90));
AoD_az=deg2rad(abs(dod_phi-90));
gainMagnitude=powerpaths_W;
gainPhase=deg2rad(powerphase_deg);

%% Read SNR
% addpath('C:\Users\isabe\OneDrive\Documentos\TCC\Outdoor\Scenario3\Material_2\Teste4_comds\Tx1\study_x3D\teste');
% filename = 'berlin_tcc.noise.t1_1.r2.p2m';
% M = dlmread(filename,'', 2, 0);
% SNR1= M(:,8);
% filename = 'berlin_tcc.noise.t1_1.r3.p2m';
% M = dlmread(filename,'', 2, 0);
% SNR2= M(:,8);
% 
% SNR_db = [SNR1;SNR2]';

% % Calculate SNR
% npd = -174; % dbm/Hz % Noise Power Density
% B=250*10^6; %Hz
% [noise_W] = calculatenoise(npd,B);
% 
% SNR_db =10*log10(power_rxW/noise_W);

addpath('..\..\..\mimo-matlab');
%% H Matrix Normalization
[li co]= size(gainMagnitude);
SE_equal =[];
SE_siso =[];
H=[];

for i=1:co
    H=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az(:,i), AoD_az(:,i), gainMagnitude(:,i), gainPhase(:,i));
    Hm(:,:,i)=H;
    Fnorm(i) = norm(Hm(:,:,i),'fro');    
    Hnorm= sqrt(Ntx*Nrx)* Hm/Fnorm(i); 
    MimoModel_rxW(i) = Fnorm(i);
    MimoModel_rxdBm(i) = 10.* log10(MimoModel_rxW(i)) + 30 ;
    SNRModel_db(i) = MimoModel_rxdBm(i) - (-87);       
    SE_equal(i) = CvsSNR_EqualPowerAllocation(SNRModel_db(i),Hnorm(:,:,i),1);
    SE_siso(i) = log2(1+10.^(SNRModel_db(i)/10));             
end    
%% Capacity
Cequal = SE_equal *2*B;
Csiso = SE_siso *B;

figure
plot(dist_los,Cequal*10^-6,'*');
hold on
plot(dist_los,Csiso*10^-6,'*');
grid on
xlabel('Tx-Rx Distance');
ylabel('Capacity(Mbits/sec)');
legend('MIMO Geometric Model','SISO');
title('Capacity for LOS Routes');
saveas(gcf,'capacitymimomodel_siso_los_wods.png');
savefig('capacitymimomodel_siso_los_wods.fig');

% 
% figure
% subplot(1,2,1)
% plot(dist_los(1:210),Cequal(1:210)*10^-6,'*');
% hold on
% plot(dist_los(1:210),Csiso(1:210)*10^-6,'*');
% grid on
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Geometric Model - ROUTE 1','SISO - ROUTE 1');
% title('Capacity for LOS Routes 1');
% saveas(gcf,'capacitymimomodel_siso_los_wods_1.png');
% savefig('capacitymimomodel_siso_los_wods_1.fig');
% 
% subplot(1,2,2)
% plot(dist_los(211:420),Cequal(211:420)*10^-6,'*');
% hold on
% plot(dist_los(211:420),Csiso(211:420)*10^-6,'*');
% grid on
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Geometric Model - ROUTE 2','SISO - ROUTE 2');
% title('Capacity for LOS Routes 2');
% saveas(gcf,'capacitymimomodel_siso_los_wods_2.png');
% savefig('capacitymimomodel_siso_los_wods_2.fig');

save('capacity_los_model.mat','Cequal','Csiso','MimoModel_rxW','Hnorm','Fnorm','Hm');
