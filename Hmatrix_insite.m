function [Hfit_ntnr, Hfit_nrnt] = Hmatrix_insite(Nreceivers,Nrx,Ntx,path,txSet,rxSet)
%% Read CSV file and fit the values in H-Matrix Ntr x Nrt
%% Conditioning the H matrix fom MIMO InSite
% Hfit = zeros(Ntx,Nrx,Nreceivers);

for i=1:Nreceivers    
    if i>=10
        filename =  strcat('hmatrix.txSet',txSet,'.txPt001.rxSet',rxSet,...
            '.rxPt0', num2str(i),'.inst001.csv');
    else
        filename =  strcat('hmatrix.txSet',txSet,'.txPt001.rxSet',rxSet,...
            '.rxPt00', num2str(i),'.inst001.csv');
    end
    file = fullfile(path,filename);
    Hmatrix = csvread(file,1);
    Hmatrix = Hmatrix(:,2:end);
    
    for k=1:Ntx
        for j = 1:Nrx
        Hfit_ntnr(k,j,i) = Hmatrix(k,(2*j-1))+1j*Hmatrix(k,2*j);
        %Hfit(k,:,i) = Hmatrix(:,(2*k-1))+1j*Hmatrix(:,2*k);
        end
    end
    Hfit_nrnt(:,:,i) =  Hfit_ntnr(:,:,i).';
end
end

