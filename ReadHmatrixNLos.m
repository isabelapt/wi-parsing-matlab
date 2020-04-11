<<<<<<< HEAD
% Read HMatrix from Insite
clear,clc;
close all;
format longEng
restoredefaultpath
%% Information to read WI Output
addpath('..\Material_2\Teste4_comds\results');
load(strcat('results_1.mat'));
load(strcat('correctdistances_1.mat'));
Nroute=4; % LOS Routes
ls_db=0; % Transmission line loss (db)
B=250*10^6;

%% FULL RT MIMO
path_folder = '..\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\hmatrix';
Nrx=4;
Ntx=4;
numTx=Ntx;
numRx=Nrx;
rx=4;
Nroute=2;
Nreceivers=rx;
[Hfit] = HfitInSite_f(Nroute,Nrx,Ntx,rx,path_folder);
Hfit = Hfit(:,:,1:rx);

%% Read SNR
addpath('C:\Users\isabe\OneDrive\Documentos\TCC\Outdoor\Scenario3\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\teste');
filename = 'berlin_tcc.noise.t1_1.r4.p2m';
M = dlmread(filename,'', 3, 0);
SNR1= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r5.p2m';
M = dlmread(filename,'', 3, 0);
SNR2= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r6.p2m';
M = dlmread(filename,'', 3, 0);
SNR3= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r7.p2m';
M = dlmread(filename,'', 3, 0);
SNR4= M(:,8);

SNR_db = [SNR1;SNR2;SNR3;SNR4]';

addpath('..\..\..\mimo-matlab');
%% 
for i=1:rx
    SE_equal(i) = CvsSNR_EqualPowerAllocation(SNR_db(i),Hfit(:,:,i),1);
    SE_siso(i) = log2(1+10.^(SNR_db(i)/10)); 
end    

%% Capacity
Cequal = SE_equal *2*B;
Csiso = SE_siso *B;

for i=1:4
y=[33,129,218,282];
x(i)= dist_los(y(i));
end


figure
plot(x,Cequal*10^-6,'*');
hold on
plot(x,Csiso*10^-6,'*');
xlabel('Tx-Rx Distance');
ylabel('Capacity(Mbits/sec)');
legend('MIMO Geometric Model','SISO')
title('NLOS ROUTES');
=======
% Read HMatrix from Insite
clear,clc;
close all;
format longEng
restoredefaultpath
%% Information to read WI Output
addpath('..\Material_2\Teste4_comds\results');
load(strcat('results_1.mat'));
load(strcat('correctdistances_1.mat'));
Nroute=4; % LOS Routes
ls_db=0; % Transmission line loss (db)
B=250*10^6;

%% FULL RT MIMO
path_folder = '..\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\hmatrix';
Nrx=4;
Ntx=4;
numTx=Ntx;
numRx=Nrx;
rx=4;
Nroute=2;
Nreceivers=rx;
[Hfit] = HfitInSite_f(Nroute,Nrx,Ntx,rx,path_folder);
Hfit = Hfit(:,:,1:rx);

%% Read SNR
addpath('C:\Users\isabe\OneDrive\Documentos\TCC\Outdoor\Scenario3\Material_2_MIMO\Teste4_comds\Tx1\study_x3D\teste');
filename = 'berlin_tcc.noise.t1_1.r4.p2m';
M = dlmread(filename,'', 3, 0);
SNR1= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r5.p2m';
M = dlmread(filename,'', 3, 0);
SNR2= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r6.p2m';
M = dlmread(filename,'', 3, 0);
SNR3= M(:,8);
filename = 'berlin_tcc.noise.t1_1.r7.p2m';
M = dlmread(filename,'', 3, 0);
SNR4= M(:,8);

SNR_db = [SNR1;SNR2;SNR3;SNR4]';

addpath('..\..\..\mimo-matlab');
%% 
for i=1:rx
    SE_equal(i) = CvsSNR_EqualPowerAllocation(SNR_db(i),Hfit(:,:,i),1);
    SE_siso(i) = log2(1+10.^(SNR_db(i)/10)); 
end    

%% Capacity
Cequal = SE_equal *2*B;
Csiso = SE_siso *B;

for i=1:4
y=[33,129,218,282];
x(i)= dist_los(y(i));
end


figure
plot(x,Cequal*10^-6,'*');
hold on
plot(x,Csiso*10^-6,'*');
xlabel('Tx-Rx Distance');
ylabel('Capacity(Mbits/sec)');
legend('MIMO Geometric Model','SISO')
title('NLOS ROUTES');
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
