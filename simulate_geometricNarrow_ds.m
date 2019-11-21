% Script to simulate a narrowband geometric model
%clear,clc;
% close all;
% format longEng
% restoredefaultpath
% addpath('/home/lasse/Documentos/5GMDATA/mimo-matlab')
%% Information to read WI Output
% load(strcat('results_1.mat'));
% load(strcat('correctdistances_1.mat'));
addpath('/home/lasse/Documentos/MIMO/MIMO-test/SISO')
filename_power = 'SISO.power.t001_02.r001.p2m';
filename_pl='SISO.pl.t001_02.r001.p2m';
filename_spread='SISO.spread.t001_02.r001.p2m';
filename_cir='SISO.cir.t001_02.r001.p2m';
filename_paths = 'SISO.paths.t001_02.r001.p2m';

ls_db=0; % Transmission line loss (db)
B=1*10^6;
npaths = 25;

run read_insite_p2m.m

%% LOS
power_rxW = dbm2W(power_phase,ls_db);
power_rxW(isnan(power_rxW)==1)=[];
powerpaths_W(isnan(power_rxW)==1)=0;
doa_theta= squeeze(path_info(:,4,:));
doa_phi= squeeze(path_info(:,5,:));
dod_theta= squeeze(path_info(:,6,:));
dod_phi= squeeze(path_info(:,7,:));


%% Information to use function to create the model
numRx=4;
numTx=4;
Nrx=numRx;
Ntx=numTx;
normalizedSpacingRx=0.5;
normalizedSpacingTx=0.5;
AoA_az=deg2rad(abs(abs(doa_phi)-90));
AoD_az=deg2rad(abs(abs(dod_phi)-90));
gainMagnitude=sqrt(powerpaths_W);
gainPhase=deg2rad(powerphase_deg);

%% H Matrix Normalization
[path,rx]= size(gainMagnitude);
SE_equal =[];
SE_siso =[];
H=[];

for i=1:rx
    H=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az(:,i), AoD_az(:,i), gainMagnitude(:,i), gainPhase(:,i));
    Hm(:,:,i)=H;
    SNRModel_db= [-20:20];
    for j=1:length(SNRModel_db)
        SE_equal(i,j) = CvsSNR_EqualPowerAllocation(SNRModel_db(j),Hm(:,:,i),1);
        SE_siso(i,j) = log2(1+10.^(SNRModel_db(j)/10));
        Cequal_siso(i,j) = SE_equal(i,j)*2*B;
        Csiso(i,j) = SE_siso(i,j)*2*B;
    end
end

save('capacity_los_model_ds.mat','Cequal_siso','Csiso','H')