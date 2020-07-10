%% Read MIMO Outputs %%
file_time  =  fullfile(path_mimo,strcat(project_name,'.study.diag'));

% Read H-Matrix.csv %
hmatrix_path = fullfile(path,'hmatrix');

Hinsite_NtNr_all = [];
Hinsite_NrNt_all = [];

Power_MIMOpaths_all = [];
Phase_MIMOpaths_all = [];
TimeofArrival_MIMOpaths_all = [];

% for i = 1:2
i =1;
[Hinsite_NtNr,Hinsite_NrNt] = Hmatrix_insite(numRxpoints(i),numRx,numTx,...
    hmatrix_path,txSet,rxSet(i));

Hinsite_NtNr_all = cat(3,Hinsite_NtNr_all, Hinsite_NtNr);
Hinsite_NrNt_all = cat(3,Hinsite_NrNt_all, Hinsite_NrNt);

% Read CIR.csv %
% Npaths x (numTx*numRx*numRxpoints)
cir_path = fullfile(path,'cir');
[Power_MIMOpaths, Phase_MIMOpaths, TimeofArrival_MIMOpaths]  = MIMOCir_insite(numRxpoints(i),numRx,numTx,...
    cir_path, txSet,rxSet(i));

Power_MIMOpaths_all = cat(2,Power_MIMOpaths_all,Power_MIMOpaths);
Phase_MIMOpaths_all = cat(2,Power_MIMOpaths_all,Phase_MIMOpaths);
TimeofArrival_MIMOpaths_all = cat(2,Power_MIMOpaths_all,TimeofArrival_MIMOpaths);
% end

Phase_MIMOpaths_deg_all = rad2deg(Phase_MIMOpaths_all);


for i = 1:numRxpoints
    for p = 1:rx_paths(i)
        m=0;
        for j = 1:numTx
            for k = 1:numRx
                m = m+1;
                Phase_MIMOpaths_deg_new(k,j,p,i)  = Phase_MIMOpaths_deg_all(p,m);
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
% file =  fullfile(path_mimo,folder,strcat(project_name,'.studyarea.diag'));
[runtime_mimo] = readruntime(file_time); % Hour Minute Second