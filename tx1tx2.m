load('results_1.mat');
load('correctdistances_1.mat');
load('pathloss_1.mat');
load('ccdf_rmsdelay_1.mat');
load('results_th1.mat');
load('Kfactor_1.mat');

pl_los_tx1 = pl_db_los;
pl_nlos_tx1 = pl_db_nlos;

dist_los_tx1 = dist_los;
dist_nlos_tx1 = dist_nlos;

pl_los_tx1_plot = pl_db_los_plot;
pl_nlos_tx1_plot = pl_db_nlos_plot;

dist_los_tx1_plot = dist_los_plot; 
dist_nlos_tx1_plot = dist_nlos_plot;

dist_los_tx1_plot_th = dist_los_tx1_plot(vec_los);
dist_nlos_tx1_plot_th = dist_nlos_tx1_plot(vec_nlos);

delayspread_los_tx1_th = delayspread_los_plot_new;
delayspread_nlos_tx1_th = delayspread_nlos_plot_new;

delayspread_los_tx1=delayspread_los;
delayspread_nlos_tx1=delayspread_nlos;

Kfactor_tx1 = KfactorLOS_db;
%%
load('results_2.mat');
load('correctdistances_2.mat');
load('pathloss_2.mat');
load('ccdf_rmsdelay_2.mat');
load('results_th2.mat');
load('Kfactor_2.mat');

pl_los_tx2 = pl_db_los;
pl_nlos_tx2 = pl_db_nlos;

dist_los_tx2 = dist_los;
dist_nlos_tx2 = dist_nlos;

pl_los_tx2_plot = pl_db_los_plot;
pl_nlos_tx2_plot = pl_db_nlos_plot;

dist_los_tx2_plot = dist_los_plot; 
dist_nlos_tx2_plot = dist_nlos_plot;

dist_los_tx2_plot_th = dist_los_tx2_plot(vec_los);
dist_nlos_tx2_plot_th = dist_nlos_tx2_plot(vec_nlos);

delayspread_los_tx2_th  = delayspread_los_plot_new;
delayspread_nlos_tx2_th  = delayspread_nlos_plot_new;

delayspread_los_tx2=delayspread_los;
delayspread_nlos_tx2=delayspread_nlos;

Kfactor_tx2 = KfactorLOS_db;
%% Join results 
pl_los_tx1tx2 = [pl_los_tx1 pl_los_tx2];
pl_nlos_tx1tx2 = [pl_nlos_tx1 pl_nlos_tx2];

dist_los_tx1tx2 = [dist_los_tx1 dist_los_tx2];
dist_nlos_tx1tx2 = [dist_nlos_tx1 dist_nlos_tx2];

pl_los_tx1tx2_plot = [pl_los_tx1_plot pl_los_tx2_plot];
pl_nlos_tx1tx2_plot = [pl_nlos_tx1_plot pl_nlos_tx2_plot];

dist_los_tx1tx2_plot = [dist_los_tx1_plot dist_los_tx2_plot];
dist_nlos_tx1tx2_plot = [dist_nlos_tx1_plot dist_nlos_tx2_plot];

dist_los_tx1tx2_plot_th = [dist_los_tx1_plot_th dist_los_tx2_plot_th];
dist_nlos_tx1tx2_plot_th = [dist_nlos_tx1_plot_th dist_nlos_tx2_plot_th];

delayspread_los_tx1tx2_th  = [delayspread_los_tx1_th  delayspread_los_tx2_th];
delayspread_nlos_tx1tx2_th  = [delayspread_nlos_tx1_th delayspread_nlos_tx2_th];

delayspread_los_tx1tx2 = [delayspread_los_tx1 delayspread_los_tx2];

Kfactor_tx1_tx2 = [Kfactor_tx1 Kfactor_tx2];

%% Model
[pl_los_d_model,pl_nlos_d_model,n_los_model,n_nlos_model] = path_function_model(dist_los_tx1tx2_plot,...
    dist_nlos_tx1tx2_plot);

%% LOS 
% Find N
[do_los_tx1tx2, index_min_los_tx1tx2]=min(dist_los_tx1tx2_plot);
pl_do_los_tx1tx2=pl_los_tx1tx2_plot(index_min_los_tx1tx2);
d_los_tx1tx2=dist_los_tx1tx2_plot;
pl_d_los_tx1tx2 =pl_los_tx1tx2_plot;

% RMSE
rms_path_los_general=erms_f(pl_los_d_model,pl_d_los_tx1tx2);

N_pathloss_los_tx1tx2 = n_exponent(pl_do_los_tx1tx2,pl_d_los_tx1tx2,do_los_tx1tx2,d_los_tx1tx2);

pl_los_simulation_tx1tx2= pl_do_los_tx1tx2 + 10 *N_pathloss_los_tx1tx2* log10(d_los_tx1tx2/do_los_tx1tx2);

figure
semilogx(dist_los_tx1tx2_plot,pl_los_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_los_tx1tx2,pl_los_simulation_tx1tx2,'bd-');
hold on
semilogx(dist_los_tx1tx2_plot,pl_los_tx1tx2_plot,'ro');
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('LOS path loss'));
legend(strcat('n-theorical:',num2str(n_los_model)),strcat('n-simulated:',num2str(N_pathloss_los_tx1tx2)),'simulated');
saveas(gcf,strcat('LOS path loss','.png'));
savefig(strcat('LOS path loss','.fig'));
%% NLOS 
% Find N
[do_nlos_tx1tx2, index_min_nlos_tx1tx2]=min(dist_nlos_tx1tx2_plot);
pl_do_nlos_tx1tx2=pl_nlos_tx1tx2_plot(index_min_nlos_tx1tx2);
d_nlos_tx1tx2=dist_nlos_tx1tx2_plot;
pl_d_nlos_tx1tx2 =pl_nlos_tx1tx2_plot;

% RMSE
rms_path_nlos_general=erms_f(pl_nlos_d_model,pl_d_nlos_tx1tx2);

N_pathloss_nlos_tx1tx2 = n_exponent(pl_do_nlos_tx1tx2,pl_d_nlos_tx1tx2,do_nlos_tx1tx2,d_nlos_tx1tx2);

pl_nlos_simulation_tx1tx2= pl_do_nlos_tx1tx2 + 10 *N_pathloss_nlos_tx1tx2* log10(d_nlos_tx1tx2/do_nlos_tx1tx2);

figure
semilogx(dist_nlos_tx1tx2_plot,pl_nlos_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_nlos_tx1tx2,pl_nlos_simulation_tx1tx2,'bd-');
hold on
semilogx(dist_nlos_tx1tx2_plot,pl_nlos_tx1tx2_plot,'ro');
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('nLOS path loss'));
legend(strcat('n-theorical:',num2str(n_nlos_model)),strcat('n-simulated:',num2str(N_pathloss_nlos_tx1tx2)),'simulated');
saveas(gcf,strcat('nLOS path loss','.png'));
savefig(strcat('nLOS path loss','.fig'));

save(strcat('pathloss_general.mat'),'dist_nlos_tx1tx2_plot','pl_nlos_tx1tx2_plot',...
    'dist_los_tx1tx2_plot','pl_los_tx1tx2_plot','rms_path_los_general','rms_path_nlos_general');


%% Complementary Cumulative Density Function LOS SCENARIO %%
%% First chop the values below the threashold
figure
plot(sort(delayspread_los_tx1tx2_th), linspace(1-1/length(delayspread_los_tx1tx2_th), 0, length(delayspread_los_tx1tx2_th)),'linewidth',2);
grid on
xlabel('(ns)');
ylabel('Probability');
title(strcat('CCDF of RMS delay spread - LOS SCENARIO'));
saveas(gcf,strcat('CCDF LOS SCENARIO -','.png'));
savefig(strcat('CCDF LOS SCENARIO -','.fig'));

%% Complementary Cumulative Density Function NLOS SCENARIO %%
%% First chop the values below the threashold
figure
plot(sort(delayspread_nlos_tx1tx2_th), linspace(1-1/length(delayspread_nlos_tx1tx2_th), 0, length(delayspread_nlos_tx1tx2_th)),'linewidth',2);
grid on
xlabel('(ns)');
ylabel('Probability');
title(strcat('CCDF of RMS delay spread - NLOS SCENARIO'));
saveas(gcf,'CCDF NLOS SCENARIO.png');
savefig('CCDF NLOS SCENARIO.fig');

%% RMS delay vs Distance
figure 
plot(dist_los_tx1tx2_plot_th,delayspread_los_tx1tx2_th,'or')
xlim([0 100])
grid on
xlabel('Tx-Rx Distance(m)');
ylabel('RMS Delay Spread (ns)');
title('RMS delay spread vs LOS Distance');
saveas(gcf,'RMS delay spread-LOS Distance.png');
savefig('RMS delay spread-LOS Distance.fig');

% %% PLot K factor
% % Remove Nan Values
% nan_kfactor =isnan(Kfactor_tx1_tx2);
% Kfactor_tx1_tx2(nan_kfactor)=[];
% 
% [dist_los_tx1tx2_sort dist_los_i] = sort(dist_los_tx1tx2);
% 
% Kfactor_tx1_tx2_sort= Kfactor_tx1_tx2(dist_los_i);
% 
% figure
% plot(dist_los_tx1tx2_sort,Kfactor_tx1_tx2_sort,'linewidth',2);
% grid on
% xlabel('Tx-Rx Distance(m)');
% ylabel('K-factor(dB)');
% % title('RMS delay spread vs LOS Distance');
% saveas(gcf,'Kfactor_outdoor.png');
% savefig('Kfactor_outdoor.fig');