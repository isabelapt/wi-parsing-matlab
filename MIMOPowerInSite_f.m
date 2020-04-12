function [Power_tx_rx_set,Phase_tx_rx_set] = MIMOPowerInSite_f(Nrx,Ntx,rx_routes,MIMOpath_power)
%% ------------------------------------------------- %%
%% Conditioning the H matrix fom MIMO InSite
% Hfit = zeros(Nrx,Ntx,rx);
% Considering that first set is Tx
% It works to maximum 900 Receivers
%% ------------------------------------------------- %%
addpath(MIMOpath_power);
set=2;

Power_tx_rx =[];
Phase_tx_rx =[];
for tx =1:Ntx
    Power_rx =[];
    Phase_rx =[];
    for rx =1:Nrx
        filename_power = strcat('power.txSet001.txPt001.rxSet00',num2str(set),'.txEl00',num2str(tx),'.rxEl00',num2str(rx),'.inst001.csv');
        Power = csvread(filename_power,1,1);
        Power_rx = [Power_rx Power(:,1)];
        Phase_rx = [Phase_rx Power(:,2)];
    end
    Power_tx_rx = [Power_tx_rx Power_rx];
    Phase_tx_rx = [Phase_tx_rx Phase_rx];
end
Power_tx_rx_set(1:rx_routes(set-1),:,set-1) = Power_tx_rx;
Phase_tx_rx_set(1:rx_routes(set-1),:,set-1) = Phase_tx_rx;
end