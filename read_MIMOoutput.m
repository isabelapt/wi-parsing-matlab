<<<<<<< HEAD
% Read HMatrix from Insite
% clear,clc;
% close all;
% format longEng
% restoredefaultpath
function [power_rxdBm,Hfit]=read_MIMOoutput(Nrx,Ntx,rx_routes,MIMOpath_power,MIMOpath_hmatrix)
% MIMOpath_power = '/home/lasse/Documentos/MIMO/MIMO-test/MIMO/power';
% MIMOpath_hmatrix = '/home/lasse/Documentos/MIMO/MIMO-test/MIMO/hmatrix';
rx=rx_routes;

%% READ POWER FULL RT MIMO
% [Power_tx_rx_set ,Phase_tx_rx_set] = MIMOPowerInSite_f(Nrx,Ntx,rx_routes,MIMOpath_power);
% 
% power_rx=[];
% 
% % Total Power with phase
% for j=1:rx
%     [power_rx(j),phase_rx(j)]=sum_power_phase(Power_tx_rx_set(j,:),Phase_tx_rx_set(j,:));
% end
% 
% power_rxdBm= 10.* log10(power_rx) + 30;


%% READ H MATRIX FULL RT MIMO

% SE_equal =[];
% SE_siso =[];
Hfit=[];
[Hfit] = MIMOHfitInSite_f(Nrx,Ntx,rx_routes,MIMOpath_hmatrix);
end


% addpath('/home/lasse/Documentos/5GMDATA/mimo-matlab')
% 
% for i=1:sum(rx_routes)
%     SNRFull_db= [-20:20];
%     for j=1:length(SNRFull_db)
%         SE_equal(i,j) = CvsSNR_EqualPowerAllocation(SNRFull_db(j),Hfit(:,:,i),1);
%         SE_siso(i,j) = log2(1+10.^(SNRFull_db(i)/10));
%         Cequal_mimo(i,j) = SE_equal(i,j)*2*B;
%         Csiso(i,j) = SE_siso(i,j)*2*B;
%     end
% end
% 
=======
% Read HMatrix from Insite
% clear,clc;
% close all;
% format longEng
% restoredefaultpath
function [power_rxdBm,Hfit]=read_MIMOoutput(Nrx,Ntx,rx_routes,MIMOpath_power,MIMOpath_hmatrix)
% MIMOpath_power = '/home/lasse/Documentos/MIMO/MIMO-test/MIMO/power';
% MIMOpath_hmatrix = '/home/lasse/Documentos/MIMO/MIMO-test/MIMO/hmatrix';
rx=rx_routes;

%% READ POWER FULL RT MIMO
% [Power_tx_rx_set ,Phase_tx_rx_set] = MIMOPowerInSite_f(Nrx,Ntx,rx_routes,MIMOpath_power);
% 
% power_rx=[];
% 
% % Total Power with phase
% for j=1:rx
%     [power_rx(j),phase_rx(j)]=sum_power_phase(Power_tx_rx_set(j,:),Phase_tx_rx_set(j,:));
% end
% 
% power_rxdBm= 10.* log10(power_rx) + 30;


%% READ H MATRIX FULL RT MIMO

% SE_equal =[];
% SE_siso =[];
Hfit=[];
[Hfit] = MIMOHfitInSite_f(Nrx,Ntx,rx_routes,MIMOpath_hmatrix);
end


% addpath('/home/lasse/Documentos/5GMDATA/mimo-matlab')
% 
% for i=1:sum(rx_routes)
%     SNRFull_db= [-20:20];
%     for j=1:length(SNRFull_db)
%         SE_equal(i,j) = CvsSNR_EqualPowerAllocation(SNRFull_db(j),Hfit(:,:,i),1);
%         SE_siso(i,j) = log2(1+10.^(SNRFull_db(i)/10));
%         Cequal_mimo(i,j) = SE_equal(i,j)*2*B;
%         Csiso(i,j) = SE_siso(i,j)*2*B;
%     end
% end
% 
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
% save('capacity_mimo.mat','Cequal_mimo','Csiso');