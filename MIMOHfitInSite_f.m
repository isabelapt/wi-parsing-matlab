function [Hfit] = MIMOHfitInSite_f(Nrx,Ntx,rx_routes,MIMOpath_hmatrix)
%% ------------------------------------------------- %%
%% Conditioning the H matrix fom MIMO InSite
% Hfit = zeros(Nrx,Ntx,rx);
% Considering that first set is Tx
% It works to maximum 900 Receivers
%% ------------------------------------------------- %%
addpath(MIMOpath_hmatrix)
set=2; 
for i=1:rx_routes(set-1)
    if i<10
        filename = strcat('hmatrix.txSet001.txPt001.rxSet00',num2str(set),'.rxPt00',num2str(i),'.inst001.csv');
    elseif i<100
        filename = strcat('hmatrix.txSet001.txPt001.rxSet00',num2str(set),'.rxPt0',num2str(i),'.inst001.csv');
    else
        filename = strcat('hmatrix.txSet001.txPt001.rxSet00',num2str(set),'.rxPt',num2str(i),'.inst001.csv');
    end

Hmatrix = csvread(filename,1,1);

% Transforming to complex double matrix
for k=1:Ntx
        Hfit(:,k,i) = Hmatrix(:,(2*k-1))+1j*Hmatrix(:,2*k);
end
end
end
