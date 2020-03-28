% Script to simulate a narrowband geometric model
% clear,clc;
% close all;
% format longEng
% restoredefaultpath
% addpath('/home/lasse/Documentos/5GMDATA/mimo-matlab')
%% Information to read WI Output
addpath('../Material_2/Teste4_comds/results');
% addpath('..\Material_2\Teste4_comds\results');
load(strcat('results_1.mat'));
load(strcat('correctdistances_1.mat'));
Nroute=4; % NLOS Routes
ls_db=0; % Transmission line loss (db)
B=250*10^6;

%% NLOS 
power_rxdbM = squeeze(power_phase_all(:,1,3:6));

power_rxW = squeeze(dbm2W(power_phase_all(:,1,3:6),ls_db));
power_rxW = [power_rxW(:,1); power_rxW(:,2); power_rxW(:,3); power_rxW(:,4)]';
power_rxW(isnan(power_rxW)==1)=[];

powerpaths_W = powerpaths_W_all(:,:,3:6);
powerpaths_W = [powerpaths_W(:,1:n_rx_routes(3),1) powerpaths_W(:,1:n_rx_routes(4),2) ...
    powerpaths_W(:,1:n_rx_routes(5),3) powerpaths_W(:,1:n_rx_routes(6),4)];
powerpaths_W(isnan(powerpaths_W)==1)=0;

powerphase_deg = powerphase_deg_all(:,:,3:6);
powerphase_deg = [powerphase_deg(:,1:n_rx_routes(3),1) powerphase_deg(:,1:n_rx_routes(4),2) ...
    powerphase_deg(:,1:n_rx_routes(5),3) powerphase_deg(:,1:n_rx_routes(6),4)];
powerphase_deg(isnan(powerphase_deg)==1)=0;

% doa_theta= squeeze(path_info_all(:,4,:,3:6));
% doa_theta=[doa_theta(:,:,1) doa_theta(:,:,2) doa_theta(:,:,3) doa_theta(:,:,4)];

doa_phi= squeeze(path_info_all(:,5,:,3:6));
doa_phi=[doa_phi(:,1:n_rx_routes(3),1) doa_phi(:,1:n_rx_routes(4),2) ...
    doa_phi(:,1:n_rx_routes(5),3) doa_phi(:,1:n_rx_routes(6),4)];
doa_phi(isnan(doa_phi)==1)=0;

% dod_theta= squeeze(path_info_all(:,6,:,3:6));
% dod_theta=[dod_theta(:,:,1) dod_theta(:,:,2) dod_theta(:,:,3) dod_theta(:,:,4)];

dod_phi= squeeze(path_info_all(:,7,:,3:6));
dod_phi=[dod_phi(:,1:n_rx_routes(3),1) dod_phi(:,1:n_rx_routes(4),2) ...
    dod_phi(:,1:n_rx_routes(5),3) dod_phi(:,1:n_rx_routes(6),4)];
dod_phi(isnan(dod_phi)==1)=0;

rx = n_rx_routes(3) +  n_rx_routes(4)+ n_rx_routes(5) +  n_rx_routes(6);

[distlos_sort,distlos_i]=sort(dist_nlos);
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
% filename = 'berlin_tcc.noise.t1_1.r4.p2m';
% M = dlmread(filename,'', 2, 0);
% SNR1= M(:,8);
% filename = 'berlin_tcc.noise.t1_1.r5.p2m';
% M = dlmread(filename,'', 2, 0);
% SNR2= M(:,8);
% filename = 'berlin_tcc.noise.t1_1.r6.p2m';
% M = dlmread(filename,'', 2, 0);
% SNR3= M(:,8);
% filename = 'berlin_tcc.noise.t1_1.r7.p2m';
% M = dlmread(filename,'', 2, 0);
% SNR4= M(:,8);
% 
% SNR_db = [SNR1;SNR2;SNR3;SNR4]';

% %% Calculate SNR
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
a=find(Csiso==0);
Csiso(a)=NaN;

figure
plot(dist_nlos,Cequal*10^-6,'*');
hold on
plot(dist_nlos,Csiso*10^-6,'*');
grid on
xlabel('Tx-Rx Distance');
ylabel('Capacity (Mbits/sec)');
legend('MIMO Geometric Model','SISO');
title('Capacity for NLOS Routes');
saveas(gcf,'capacitymimomodel_siso_nlos_wds.png');
savefig('capacitymimomodel_siso_nlos_wds.fig');

% figure
% subplot(2,2,1)
% plot(dist_nlos(1:96),Cequal(1:96)*10^-6,'*');
% hold on
% plot(dist_nlos(1:96),Csiso(1:96)*10^-6,'*');
% grid on
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Geometric Model - ROUTE 3','SISO - ROUTE 3');
% title('Capacity for NLOS Routes 3');
% saveas(gcf,'capacitymimomodel_siso_los_wods_3.png');
% savefig('capacitymimomodel_siso_los_wods_3.fig');
% 
% subplot(2,2,2)
% plot(dist_nlos(97:183),Cequal(97:183)*10^-6,'*');
% hold on
% plot(dist_nlos(97:183),Csiso(97:183)*10^-6,'*');
% grid on
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Geometric Model - ROUTE 4','SISO - ROUTE 4');
% title('Capacity for NLOS Routes 4');
% saveas(gcf,'capacitymimomodel_siso_los_wods_4.png');
% savefig('capacitymimomodel_siso_los_wods_4.fig');
% 
% subplot(2,2,3)
% plot(dist_nlos(184:247),Cequal(184:247)*10^-6,'*');
% hold on
% plot(dist_nlos(184:247),Csiso(184:247)*10^-6,'*');
% grid on
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Geometric Model - ROUTE 5','SISO - ROUTE 5');
% title('Capacity for NLOS Routes 5');
% saveas(gcf,'capacitymimomodel_siso_los_wods_5.png');
% savefig('capacitymimomodel_siso_los_wods_5.fig');
% 
% 
% subplot(2,2,4)
% plot(dist_nlos(248:309),Cequal(248:309)*10^-6,'*');
% hold on
% plot(dist_nlos(248:309),Csiso(248:309)*10^-6,'*');
% grid on
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Geometric Model - ROUTE 6','SISO - ROUTE 6');
% title('Capacity for NLOS Routes 6');
% saveas(gcf,'capacitymimomodel_siso_los_wods_6.png');
% savefig('capacitymimomodel_siso_los_wods_6.fig');

save('capacity_nlos_model_ds.mat','Cequal','Csiso','MimoModel_rxW','Hnorm','Fnorm','Hm');
