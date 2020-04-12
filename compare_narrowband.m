clear,clc;
close all;
format longEng
restoredefaultpath
project_simulation =1;

%% 
% addpath('..\Material_2\Teste4_comds\results');
addpath('../../Material_2/Teste4_comds/results');
load(strcat('results_1.mat'));
load(strcat('correctdistances_1.mat'));
Nroute=2;
rx=4; % Receivers
rx1=[46 169];rx2=[46 169];%;rx3=33;rx4=33;rx5=35;rx6=35; 

ls_db=0; % Transmission line loss (db)
shouldShowDebugPlots=1; % To plot (1) or not (0)
plotall_error =1;

run rx_points.m
save('rx_notmimo1.mat','powerpaths_dbm','timearrival_sec','powerphase_deg',...
    'doa_theta','doa_phi','dod_theta','doa_phi','dist');

powerpaths_W = dbm2W(powerpaths_dbm,ls_db);
[dist_sort,dist_i]=sort(dist);

numRx=4;
numTx=4;
Nrx=numRx;
Ntx=numTx;
normalizedSpacingRx=0.5;
normalizedSpacingTx=0.5;
AoA_az=deg2rad(doa_phi);
AoD_az=deg2rad(dod_phi);
gainMagnitude=powerpaths_W;
gainPhase=deg2rad(powerphase_deg);

%% FULL RT MIMO
addpath('../Material_2_MIMO/Teste4_comds/Tx1/study_x3D/hmatrix');
% addpath('..\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\hmatrix');
Nreceivers=rx;
[Hfit] = HfitInSite_f2(Nroute,Nrx,Ntx,rx);
Hfit = Hfit(:,:,1:4);

addpath('../../../mimo-matlab');
% addpath('..\..\..\mimo-matlab');
%% H Matrix Normalization
for i=1:rx
H=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
    normalizedSpacingRx,AoA_az(:,i), AoD_az(:,i), gainMagnitude(:,i), gainPhase(:,i));
    Hm(:,:,i)=H;
    Fnorm = norm(Hm(:,:,i),'fro');
    Hnorm = sqrt(Ntx*Nrx)*Hm/Fnorm;
    
    Fnorm_insite = norm(Hfit(:,:,i),'fro');
    Hnorm_insite = sqrt(Ntx*Nrx)*Hfit/Fnorm_insite;
end


%% Error Plot
dif_abs=abs(Hnorm -Hnorm_insite);
dif_per = abs(dif_abs./Hnorm).*100;
if plotall_error ==1
    for j=1:rx
        figure
        bar3(dif_per(:,:,j));
        title(['Rx', num2str(j)]);
    end
end

y_per= squeeze(mean(mean(dif_per,1),2));
y_abs= squeeze(mean(mean(dif_abs,1),2));
yper_sort=y_per(dist_i);
yabs_sort=y_abs(dist_i);
figure
bar(dist_sort,yper_sort);
xlabel('Distance(m)');
ylabel('Error (%)');
title('BAR DISTRIBUTION OF THE ERRORS');
legend(num2str(dist_i));

% 'double2strRx: 1, 2, 3, 4');
%% Capacity 
% for 2 Rx's ( 6 and 10 )

SNRvec_dB = [-20:20];

calcType = 1; % calcType = 1: eigenvalues are NOT used for capacity calculation
              % calcType = 2: eigenvalues are used for capacity calculation
figure
H_RT = Hnorm_insite(:,:,1);              
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_RT,1);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT = Hnorm_insite(:,:,2);
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_RT,1);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT = Hnorm_insite(:,:,3);              
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_RT,1);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT = Hnorm_insite(:,:,4);
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_RT,1);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
% hold on

legend('Rx 1','Rx 2','Rx 3','Rx 4');
xlabel('SNR (dB)');
ylabel('Spectral Efficiency (bps\Hz)');
% title('CAPACITY OF THE MIMO CHANNEL USING');
grid on

figure
H_narrow = Hnorm(:,:,1);              
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_narrow,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow= Hnorm(:,:,2);
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_narrow,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow = Hnorm(:,:,3);              
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_narrow,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow= Hnorm(:,:,4);
[C] = CvsSNR_EqualPowerAllocation(SNRvec_dB,H_narrow,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

legend('Rx 1','Rx 2','Rx 3','Rx 4');
xlabel('SNR (dB)');
ylabel('Spectral Efficiency (bps\Hz)');
% title('CAPACITY OF THE MIMO CHANNELS');
grid on

figure
Csiso = log2(1+10.^(SNRvec_dB/10));             
plot(SNRvec_dB,Csiso,'y','LineWidth',2)