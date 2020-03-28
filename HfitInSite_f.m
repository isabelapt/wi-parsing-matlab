function [Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx,path)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%% Conditioning the H matrix fom MIMO InSite
Hfit = zeros(Nrx,Ntx,Nreceivers);

for i=1:Nreceivers
    
    if i>=10
        filename = ['hmatrix.txSet024.txPt001.rxSet029.rxPt0' num2str(i) '.inst001.csv'];
    else
        filename = ['hmatrix.txSet024.txPt001.rxSet029.rxPt00' num2str(i) '.inst001.csv'];
    end
    file = strcat(path,filename);
    Hmatrix = csvread(file,1);
    Hmatrix = Hmatrix(:,2:end);
    
    for k=1:Nrx
        Hfit(k,:,i) = Hmatrix(:,(2*k-1))+1j*Hmatrix(:,2*k);
    end

%     figure
%     imagesc(10*log10(abs(Hfit(:,:,i))))
%     colorbar
%     pause
end
end

