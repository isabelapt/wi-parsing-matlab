%% Read MIMO Outputs %%

%%
txSet = '001';
rxSet = '002';

path = fullfile(path_mimo,folder,'studyarea');

% Read H-Matrix.csv %
hmatrix_path = fullfile(path,'hmatrix');
[Hinsite_NtNr,Hinsite_NrNt] = Hmatrix_insite(numRxpoints,numRx,numTx,...
    hmatrix_path,txSet,rxSet);

% Read CIR.csv %
% Npaths x (numTx*numRx*numRxpoints)
cir_path = fullfile(path,'cir');
[Power_MIMOpaths, Phase_MIMOpaths, TimeofArrival_MIMOpaths]  = MIMOCir_insite(numRxpoints,numRx,numTx,...
    cir_path, txSet,rxSet);

Phase_MIMOpaths_deg = rad2deg(Phase_MIMOpaths);

for p = 1:paths_max
    for i = 1: numRxpoints
        m=0;
        for j = 1:numTx
            for k = 1:numRx
                m = m+1;
                Phase_MIMOpaths_deg_new(k,j,p,i)  = Phase_MIMOpaths_deg(p,m);
            end
            phasediff_elements_rx(:,j,p,i) = rad2deg(angdiff(deg2rad(Phase_MIMOpaths_deg_new(:,j,p,i))));
            phasediff_elements_rx2(:,j,p,i)= rad2deg(angdiff(deg2rad(phasediff_elements_rx(:,j,p,i))));
        end
%         a = exp(1j*deg2rad(Phase_MIMOpaths_deg_new(:,:,p,i)));
%         b = exp(-1j*deg2rad(Phase_MIMOpaths_deg_new(1,1,p,i)));
%         phasediff_elements(:,:,p,i) = rad2deg(angle(a*b));
    end
end

% Read Simulation Time
file =  fullfile(path_mimo,folder,strcat(project_name,'.studyarea.diag'));
[runtime_mimo] = readruntime(file); % Hour Minute Second