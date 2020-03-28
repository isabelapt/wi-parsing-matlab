% Tutorial to read files from INSITE using MATLAB
% 1-
project_name = 'teste';

% What are the output files going to be read ?

% Received Power
%tag_power = '.power.';
% Path Loss
%tag_pl = '.pl.';
% Delay Spread
%tag_delayspread = '.spread.';
% Complex Impulse Responde
%tag_cir = '.cir.';
% Paths
%tag_paths = '.paths.';

% How is the set of Tx and Rx
txrxset = 't001_01.r00'

% Number of Rx set(s)

rx_set = 2;

% Format file 
end_name = '.p2m'

% Filenames 

filename_power=strcat(project_name,'.power.',txrxset,num2str(rx_set),end_name);
filename_pl=strcat(project_name,'.pl.',txrxset,num2str(rx_set),end_name);
filename_spread=strcat(project_name,'.spread',txrxset,num2str(rx_set),end_name);
filename_cir = strcat(project_name,'.cir.',txrxset,,num2str(rx_set),end_name);
filename_paths = strcat(project_name,'.paths.',txrxset,num2str(rx_set),end_name);



