function [CIR_matrix] = CIRInSite_f(Nreceivers,Nrx,Ntx)
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
                filename = ['cir.txSet001.txPt001.rxSet002.rxPt0' num2str(i) '.txEl00' num2str(j) '.rxEl00' num2str(n) '.inst001.csv'];
            else
                filename = ['cir.txSet001.txPt001.rxSet002.rxPt00' num2str(i) '.txEl00' num2str(j) '.rxEl00' num2str(n) '.inst001.csv'];
            end
            CIR =  importdata(filename,',',1);
            if length(CIR.data) < 250
                CIR_matrix(1:length(CIR.data),:,k) =CIR.data;
                a=length(CIR.data)+1;
                b=250-length(CIR.data);
                r=k;
                CIR_matrix(a:b,:,k) = NaN;
            else
                CIR_matrix(:,:,k) =CIR.data;
            end
        end
    end
end

% end

