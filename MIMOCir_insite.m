function [CIR_matrix] = MIMOCir_insite(Nreceivers,Nrx,Ntx,path,txSet,rxSet)
%% Conditioning the Complex Impulse Response fom MIMO InSite
% CIR FILES %
% <Path Id>,<Source Id>,<Received Power (W)>,...
% <Phase (radians)>,<Time of Arrival (s)>

k=0;
for i=1:Nreceivers
    for j=1:Ntx
        for n=1:Nrx
             k=k+1;
            if i>=10
                filename =  strcat('cir.txSet',txSet,'.txPt001.rxSet',rxSet,...
                    '.rxPt0', num2str(i),'.txEl00', num2str(j),'.rxEl00', num2str(n),'.inst001.csv');
            else
                filename =  strcat('cir.txSet',txSet,'.txPt001.rxSet',rxSet,...
                    '.rxPt00', num2str(i),'.txEl00', num2str(j),'.rxEl00', num2str(n),'.inst001.csv');
            end
            file = fullfile(path,filename);
            CIR =  csvread(file,1);
            [r,c] = size(CIR);
            if  r < 250
                CIR_matrix(1:r,:,k) = CIR;
            else
                CIR_matrix(:,:,k)= CIR;
            end
        end
    end
end