<<<<<<< HEAD
% Pl_d0 = 10*log10((4*pi*d0_m/lamda)^2); %Free space path loss at d0 in dB
% 
% % if d0_m =1 
% Pl_d0 = 20*log10(f_MHz)-28;

% Free space path loss
Pl_fs = 33.44 + 20*log10(d0_km) + 20*log10(f_MHz);

%% Modelos ITU-R P.1238
% Pl = Pl_d0 + N*log10(d_m/d0_m) + Lf(n);

% Considering the d0_m =1
% d_m=1:40;

% For indoor Corridor at 2.1GHz
Lf_n=0;
Pl_ituc = 20*log10(f_MHz) + 17*log10(d_m) + Lf_n -28;

% For indoor Office at 5.8 GHz
Lf_n=0;
Pl_ituo = 20*log10(f_MHz) + 24*log10(d_m) + Lf_n -28;

% Path Loss model with N from measurements
Pl_itux3d= 20*log10(f_MHz) + 10*n_loss*log10(d_m) - 28 ; % n dados simulados 

% Modelo proposto por regressão
mpsimulados = a4 + b4*10*log10(d) + 20*log10(f_MHz);  % modelo regressao 

%Graficos
figure
plot (d_m,Pl_m,'.-k','markersize',20); hold on; %medidos
plot (d_m,Pl_in,'-.m','linewidth',2); hold on; % Simulados
plot (d_m,Pl_ituc,'-b','linewidth',2); hold on; %n itu corredor
plot (d_m,Pl_ituo,'-c','linewidth',2); hold on; %n itu escritorio
plot (d_m,Pl_itux3d,'-g','linewidth',2); hold on; % n itu dados simulados 
plot (d_m,mpsimulados,'-.g','linewidth',2); hold on; % modelo regressao 
grid on;
% axis ([0 40 48 93])
ylabel('Path Loss (dB)')
xlabel('Distance (m)')
legend ('Measured Data','Simulated Data','ITU-R.1238-9 (N corridor)','ITU-R.1238-9 (N office)',...
    'ITU-R.1238-9 (N from simulation)','Proposed Model based on simulated data')

%% RMS
rms1=erms_f(Pl_m,Pl_in)
rms2=erms_f(Pl_m,Pl_ituc)
rms3=erms_f(Pl_m,Pl_ituo)
rms4=erms_f(Pl_m,Pl_itux3d)
rms5=erms_f(Pl_m,mpsimulados)


=======
% Pl_d0 = 10*log10((4*pi*d0_m/lamda)^2); %Free space path loss at d0 in dB
% 
% % if d0_m =1 
% Pl_d0 = 20*log10(f_MHz)-28;

% Free space path loss
Pl_fs = 33.44 + 20*log10(d0_km) + 20*log10(f_MHz);

%% Modelos ITU-R P.1238
% Pl = Pl_d0 + N*log10(d_m/d0_m) + Lf(n);

% Considering the d0_m =1
% d_m=1:40;

% For indoor Corridor at 2.1GHz
Lf_n=0;
Pl_ituc = 20*log10(f_MHz) + 17*log10(d_m) + Lf_n -28;

% For indoor Office at 5.8 GHz
Lf_n=0;
Pl_ituo = 20*log10(f_MHz) + 24*log10(d_m) + Lf_n -28;

% Path Loss model with N from measurements
Pl_itux3d= 20*log10(f_MHz) + 10*n_loss*log10(d_m) - 28 ; % n dados simulados 

% Modelo proposto por regressão
mpsimulados = a4 + b4*10*log10(d) + 20*log10(f_MHz);  % modelo regressao 

%Graficos
figure
plot (d_m,Pl_m,'.-k','markersize',20); hold on; %medidos
plot (d_m,Pl_in,'-.m','linewidth',2); hold on; % Simulados
plot (d_m,Pl_ituc,'-b','linewidth',2); hold on; %n itu corredor
plot (d_m,Pl_ituo,'-c','linewidth',2); hold on; %n itu escritorio
plot (d_m,Pl_itux3d,'-g','linewidth',2); hold on; % n itu dados simulados 
plot (d_m,mpsimulados,'-.g','linewidth',2); hold on; % modelo regressao 
grid on;
% axis ([0 40 48 93])
ylabel('Path Loss (dB)')
xlabel('Distance (m)')
legend ('Measured Data','Simulated Data','ITU-R.1238-9 (N corridor)','ITU-R.1238-9 (N office)',...
    'ITU-R.1238-9 (N from simulation)','Proposed Model based on simulated data')

%% RMS
rms1=erms_f(Pl_m,Pl_in)
rms2=erms_f(Pl_m,Pl_ituc)
rms3=erms_f(Pl_m,Pl_ituo)
rms4=erms_f(Pl_m,Pl_itux3d)
rms5=erms_f(Pl_m,mpsimulados)


>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
