% Read HMatrix from Insite
clear,clc;
% close all;
format longEng
restoredefaultpath
%% Information to read WI Output
addpath('..\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\power');
ls_db=0; % Transmission line loss (db)
B=250*10^6;

%% Info about MIMO
Nrx=4;
Ntx=4;
numTx=Ntx;
numRx=Nrx;
rx=4;
Nreceivers=rx;
% 
%% READ H MATRIX FULL RT MIMO
path_folder = '..\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\hmatrix';
[Hfit] = HfitInSite_f(Nrx,Ntx,rx,path_folder);
Hfit = Hfit(:,:,1:rx);

%% Read SNR
addpath('C:\Users\isabe\OneDrive\Documentos\TCC\Outdoor\Scenario3\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\teste');
filename = 'berlin_tcc.noise.t1_1.r2.p2m';
M = dlmread(filename,'', 3, 0);
SNR1= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r3.p2m';
M = dlmread(filename,'', 3, 0);
SNR2= M(:,8);

SNR_db = [SNR1;SNR2]';

addpath('..\..\..\mimo-matlab');
%% 
for i=1:rx
    SE_equal(i) = CvsSNR_EqualPowerAllocation(SNR_db(i),Hfit(:,:,i),1);
    SE_siso(i) = log2(1+10.^(SNR_db(i)/10)); 
end    

%% Capacity
Cequal = SE_equal *2*B;
Csiso = SE_siso *B;

% for i=1:4
% y=[46,169,256,379];
% x(i)= dist_los(y(i));
% end
% 
% 
% figure
% plot(x,Cequal*10^-6,'*');
% hold on
% plot(x,Csiso*10^-6,'*');
% xlabel('Tx-Rx Distance');
% ylabel('Capacity(Mbits/sec)');
% legend('MIMO Full','SISO')
% title('LOS ROUTES');

save('capacity_los_mimo.mat','Cequal','Csiso','SE_equal','SE_siso');
save('snr_db_mimo.mat','SNR_db');
% save('power_mimo.mat','power_rxW');