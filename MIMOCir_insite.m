function [CIR_matrix] = MIMOCir_insite(Nreceivers,Nrx,Ntx,path)
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
                filename = ['cir.txSet031.txPt001.rxSet029.rxPt0' num2str(i) '.txEl00' num2str(j) '.rxEl00' num2str(n) '.inst001.csv'];
            else
                filename = ['cir.txSet031.txPt001.rxSet029.rxPt00' num2str(i) '.txEl00' num2str(j) '.rxEl00' num2str(n) '.inst001.csv'];
            end
            file = strcat(path,filename);
            CIR =  csvread(file,1);
            [r,c] = size(CIR);
            if  r < 250
                CIR_matrix(1:r,:,k) = CIR;
%                 a=r+1;
%                 b=250;
% %                 r=k;
%                 CIR_matrix(a:b,:) = NaN;
            else
                CIR_matrix(:,:,k)= CIR;
            end
        end
    end
end

% end

