function [Power_MIMOpaths, Phase_MIMOpaths, TimeofArrival_MIMOpaths] = MIMOCir_insite(Nreceivers,Nrx,Ntx,path,txSet,rxSet)
%% Conditioning the Complex Impulse Response fom MIMO InSite
% CIR FILES %
% <Path Id>,<Source Id>,<Received Power (W)>,...
% <Phase (radians)>,<Time of Arrival (s)>

k=0;
for i=1:Nreceivers
    if i>=10
        filename =  strcat('cir.txSet',txSet,'.txPt001.rxSet',rxSet,...
            '.rxPt0', num2str(i));
        %                 ,'.txEl00', num2str(j),'.rxEl00', num2str(n),'.inst001.csv');
    else
        filename =  strcat('cir.txSet',txSet,'.txPt001.rxSet',rxSet,...
            '.rxPt00', num2str(i));
        %                 ,'.txEl00', num2str(j),'.rxEl00', num2str(n),'.inst001.csv');
    end
    
    for j=1:Ntx
        if j >=10
            filename1 =  strcat(filename,'.txEl0', num2str(j));
            %                 ,'.rxEl0', num2str(n),'.inst001.csv');
        else
            filename1 =  strcat(filename,'.txEl00', num2str(j));
            %                 ,'.rxEl00', num2str(n),'.inst001.csv');
        end
        for n=1:Nrx
            k=k+1;
            if n >=10
                filename2 =  strcat(filename1,'.rxEl0', num2str(n),'.inst001.csv');
            else
                filename2 =  strcat(filename1,'.rxEl00', num2str(n),'.inst001.csv');
            end
            
            file = fullfile(path,filename2);
            CIR =  csvread(file,1);
            [r,c] = size(CIR);
            if  r < 250
                Power_MIMOpaths(1:r,k) = CIR(:,3);
                Phase_MIMOpaths(1:r,k) = CIR(:,4);
                TimeofArrival_MIMOpaths(1:r,k) =CIR(:,5);
            else
                Power_MIMOpaths(:,k) = CIR(:,3);
                Phase_MIMOpaths(:,k) = CIR(:,4);
                TimeofArrival_MIMOpaths(:,k) =CIR(:,5);
            end
        end
    end
end