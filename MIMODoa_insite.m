function [DOA_matrix] = MIMODoa_insite(Nreceivers,Nrx,Ntx,path)
% Conditioning the Complex Impulse Response fom MIMO InSite
% Nreceivers = 10;
% Nrx = 4;
% Ntx = 4;
% addpath('..\NarrowBand\60000 MHz_MIMO\cir');
format shortE
format compact
k=0;

for i=1:Nreceivers
    for j=1:Ntx
        for n=1:Nrx
             k=k+1;
            if i>=10
                filename = ['angles.txSet031.txPt001.rxSet029.rxPt0' num2str(i) '.txEl00' num2str(j) '.rxEl00' num2str(n) '.csv'];
            else
                filename = ['angles.txSet031.txPt001.rxSet029.rxPt00' num2str(i) '.txEl00' num2str(j) '.rxEl00' num2str(n) '.csv'];
            end
            file = strcat(path,filename);
            DOA =  csvread(file,1);
            if length(DOA) < 250
                DOA_matrix(1:length(DOA),:) =DOA;
                a=length(DOA)+1;
                b=250-length(DOA);
                r=k;
                DOA_matrix(a:b,:) = NaN;
            else
                DOA_matrix(:,:,k)=DOA;
            end
        end
    end
end

% end

