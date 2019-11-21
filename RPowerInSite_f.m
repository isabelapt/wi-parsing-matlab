function [RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx)
%% Conditioning the Received Power fom MIMO InSite
format shortE
format compact

t=Nrx*Ntx;
RPower_matrix = zeros(Nreceivers,2,t);
k=0;

for i=1:Ntx
    for j=1:Nrx
    k=k+1;
    filename = ['power.txSet001.txPt001.rxSet002.txEl00' num2str(i) '.rxEl00' num2str(j) '.inst001.csv'];
    RPower =  importdata(filename,',', 1);
    RPower_matrix(:,:,k) = RPower.data(:,:);
    end
end
end

