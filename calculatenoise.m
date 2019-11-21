function [noise_W] = calculatenoise(npd,B)
npd_W = 10.^((npd - 30) ./ 10); 

N_W= npd_W *B;

N_dbm= 10.* log10(N_W) + 30 ;

Noise_fig_db = 3;

% If SISO 
N_dbm_total= N_dbm+Noise_fig_db;

noise_W = 10.^((N_dbm_total - 30) ./ 10);
end

% If MIMO