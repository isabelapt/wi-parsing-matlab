function [Power_matrix,Phase_matrix,PathGain_matrix] = MIMOPower_insite(Nrx,...
    Ntx,path,txSet,rxSet)
%% Conditioning the Received Power fom MIMO InSite to Nt x Nr Matrix

for i=1:Ntx
    for j=1:Nrx
        filename =  strcat('power.txSet',txSet,'.txPt001.rxSet',rxSet,...
            '.txEl00', num2str(i),'.rxEl00', num2str(j),'.inst001.csv');
        file = fullfile(path,filename);
        Power =  csvread(file,1);
        Power_matrix(i,j) = Power(:,2);
        Phase_matrix(i,j) = Power(:,3);
        PathGain_matrix(i,j)= Power(:,5);       
    end
end
Power_matrix = W2dbm(Power_matrix);
end