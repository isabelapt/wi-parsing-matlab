% Plot NMSE %
clear,clc;
main_path = 'D:\Users\isabela\Documents\SISO2MIMO\Scenario1\';
path_mimo = fullfile(main_path,'mimo@2GHz','Tx@P1');
n_ula = [4,8,12,16,24,32,64];

for i = 1: length(n_ula)
    str = fullfile(path_mimo,strcat('ULA', num2str(n_ula(i))));
    load(strcat(str,'.mat'))
    nmse_ula(:,i) = error_H; % Nrx points x N of ULA array configuration 
end
