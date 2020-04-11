function [Power_matrix,Phase_matrix,PathGain_matrix] = MIMOPower_insite(Nreceivers,Nrx,Ntx,path)
%% Conditioning the Received Power fom MIMO InSite
t=Nrx*Ntx;
% RPower_matrix = zeros(Nreceivers,2,t);
% k=0;

for i=1:Ntx
    for j=1:Nrx
%         k=k+1;
        filename = ['power.txSet031.txPt001.rxSet029.txEl00' num2str(i) '.rxEl00' num2str(j) '.inst001.csv'];
        file = strcat(path,filename);
        Power =  csvread(file,1);
        Power_matrix(i,j) = Power(:,2);
        Phase_matrix(i,j) = Power(:,3);
        PathGain_matrix(i,j)= Power(:,5);
        
    end
end
Power_matrix = W2dbm(Power_matrix,0);
end
% addpath(MIMOpath_power);
% set=2;
%
% Power_tx_rx =[];
% Phase_tx_rx =[];
% for tx =1:Ntx
%     Power_rx =[];
%     Phase_rx =[];
%     for rx =1:Nrx
%         filename_power = strcat('power.txSet001.txPt001.rxSet00',num2str(set),'.txEl00',num2str(tx),'.rxEl00',num2str(rx),'.inst001.csv');
%         Power = csvread(filename_power,1,1);
%         Power_rx = [Power_rx Power(:,1)];
%         Phase_rx = [Phase_rx Power(:,2)];
%     end
%     Power_tx_rx = [Power_tx_rx Power_rx];
%     Phase_tx_rx = [Phase_tx_rx Phase_rx];
% end
% Power_tx_rx_set(1:rx_routes(set-1),:,set-1) = Power_tx_rx;
% Phase_tx_rx_set(1:rx_routes(set-1),:,set-1) = Phase_tx_rx;
