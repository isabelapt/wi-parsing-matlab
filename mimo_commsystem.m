% Read Outputs from Communication System
project_name = 'test_mimo';
txrxset ='t001_31.';
rx_set= 'r029';
end_name ='.p2m';

path_comm = strcat(path,'system\');
filename_noise = strcat(path_comm,project_name,'.noise.','t1_31.r29',end_name);
noise_wi = dlmread(filename_noise ,'',3,0);
interference_dbm_wi = noise_wi(:,6);
noise_dbm_wi = noise_wi(:,7);
SNR_db_mimo_wi= noise_wi(:,8);
SINR_db_mimo_wi = noise_wi(:,10);

% Capacity WI %bit/sec
C_mimo_WI= BW*log2(1+10.^(SINR_db_mimo_wi/10)); 
SE_mimo_WI = C_mimo_WI/BW;

%% Communication Systems Output
noise_out_W = dbm2W(noise_pd,0) * BW;

% % Transmit Beamforming using Maximum Ratio Transmission
% for i=1:numRx
%     w_matrix(:,:,i) = Hinsite(:,i)'./abs(Hinsite_NtNr(:,i));
% end

% Receiver Diversity Techniques
% Select Combining
% for i=1:numRx
%     Prx_W(:,i) = (inputpower_W/numTx) * abs(Hinsite_NtNr(:,i)).^2;
% end
% 
% [rx_W,rx_phase] =  sum_power_phase(Prx_W,MIMO_rx_phase_rad);
% 
% Prx_dbm = W2dbm(Prx_W,0);
% noise_dbm = W2dbm(noise_out_W,0)+ noiseFigure;
% interference_dbm  = uni_interf;
% totalpower_mimo = max(rx_W);
% SNR = W2dbm(totalpower_mimo,0) - noise_dbm;
% SINR = 10*log10((totalpower_mimo/(dbm2W(noise_dbm,0)+dbm2W(interference_dbm,0))));


% Equal Gain Combining
% for i=1:numRx
% w(:,i)= exp(1j*angle(Hinsite_NtNr(:,i)));
% x(i)= abs(w(:,i)'*Hinsite_NtNr(:,i));
% abs_hk(i) = sum(abs(Hinsite_NtNr(:,i)));
% end
% 
% Prx_W = (inputpower_W/numTx)* x.^2;
% totalpower_mimo = sum(Prx_W);
% noise_dbm = W2dbm(noise_out_W*numRx,0)+ noiseFigure;
% interference_dbm = uni_interf + 10*log10(numRx);
% SNR = W2dbm(totalpower_mimo,0) - noise_dbm;
% SINR = 10*log10((totalpower_mimo/(dbm2W(noise_dbm,0)+ dbm2W(interference_dbm,0))));

% Maximal Ratio Combining
% abs_hk=0;
% for i=1:numRx
% w(:,i)= exp(1j*angle(Hinsite_NtNr(:,i)));
% abs_hk = sum(abs(Hinsite_NtNr(:,i)).^2) + abs_hk;
% end
% 
% Prx_W = (inputpower_W/numTx)* numRx * abs_hk;
% totalpower_mimo = sum(Prx_W);
% noise_dbm = W2dbm(noise_out_W*numRx,0)+ noiseFigure;
% interference_dbm = uni_interf + 10*log10(numRx);
% SNR = W2dbm(totalpower_mimo,0) - noise_dbm;
% SINR = 10*log10((totalpower_mimo/(dbm2W(noise_dbm,0)+ dbm2W(interference_dbm,0))));
