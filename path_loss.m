<<<<<<< HEAD
%% MODEL
[pl_los_d_model,pl_nlos_d_model,n_los_model,n_nlos_model] = path_function_model(dist_los_plot,dist_nlos_plot);
% [pl_los_d_model,n_los_model]  = path_function_model(dist_los_plot);%,dist_nlos_plot);
%% LOS SET PLOT :The Route 1 & 2 are considered LOS PATHS
pl_db_los =pl_db_all(:,1:2);
pl_db_los=[pl_db_all(1:n_rx_routes(1,1),1)' pl_db_all(1:n_rx_routes(1,2),2)'];
pl_db_los_plot = pl_db_los(dist_los_i);

% RMSE
rms_path_los=erms_f(pl_los_d_model(dist_los_i),pl_db_los_plot);

% Find N
[do_los, index_min_los]=min(dist_los_plot);
pl_do_los=pl_db_los_plot(index_min_los);
d_los=dist_los_plot(dist_los_i);
pl_d_los =pl_db_los_plot;
N_pathloss_los = n_exponent(pl_do_los,pl_d_los,do_los,d_los);
pl_los_simulation= pl_do_los + 10 *N_pathloss_los* log10(d_los/do_los);

figure
semilogx(dist_los_plot,pl_los_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on


hold on 
semilogx(d_los,pl_los_simulation,'bd-');
hold on
semilogx(dist_los_plot_new,pl_db_los_plot,'ro');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('LOS path loss-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_los_model)),strcat('n-simulated:',num2str(N_pathloss_los)),'simulated');
saveas(gcf,strcat('LOS path loss-',num2str(project_simulation),'.png'));
savefig(strcat('LOS path loss-',num2str(project_simulation),'.fig'));

%% LOS ROUTE PLOT
figure
semilogx(dist_los_plot,pl_los_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_los,pl_los_simulation,'bd-');
hold on
semilogx(dist(1,:),pl_db_all(:,1),'ro');
hold on
semilogx(dist(2,:),pl_db_all(:,2),'mo');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('LOS path loss-','Routes-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_los_model)),strcat('n-simulated:',num2str(N_pathloss_los)),'Route1','Route2');
saveas(gcf,strcat('LOS path loss-','Routes-',num2str(project_simulation),'.png'));
savefig(strcat('LOS path loss-','Routes-',num2str(project_simulation),'.fig'));

%% NLOS PLOT : The Route 3:6 are considered NLOS PATHS
pl_db_nlos =pl_db_all(:,3:6);
pl_db_nlos=[pl_db_nlos(1:n_rx_routes(1,3),1)' pl_db_nlos(1:n_rx_routes(1,4),2)' ...
   pl_db_nlos(1:n_rx_routes(1,5),3)' pl_db_nlos(1:n_rx_routes(1,6),4)'];
pl_db_nlos_plot = pl_db_nlos(dist_nlos_i);

% RMSE
rms_path_nlos=erms_f(pl_nlos_d_model(dist_nlos_i),pl_db_nlos_plot);

% Find N
[do_nlos, index_min_nlos]=min(dist_nlos_plot);
pl_do_nlos=pl_db_nlos_plot(index_min_nlos);
d_nlos=dist_nlos_plot(dist_nlos_i);
pl_d_nlos =pl_db_nlos_plot;
N_pathloss_nlos = n_exponent(pl_do_nlos,pl_d_nlos,do_nlos,d_nlos);
pl_nlos_simulation= pl_do_nlos + 10 *N_pathloss_nlos* log10(d_nlos/do_nlos);



figure
semilogx(dist_nlos_plot,pl_nlos_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_nlos,pl_nlos_simulation,'bd-');
hold on
semilogx(dist_nlos_plot_new,pl_db_nlos_plot,'ro');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('nLOS path loss-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_nlos_model)),strcat('n-simulated:',num2str(N_pathloss_nlos )),'simulated');
saveas(gcf,strcat('nLOS path loss-',num2str(project_simulation),'.png'));
savefig(strcat('nLOS path loss-',num2str(project_simulation),'.fig'));

%% NLOS ROUTE PLOT
figure
semilogx(dist_nlos_plot,pl_nlos_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_nlos,pl_nlos_simulation,'bd-');
hold on
semilogx(dist(3,:),pl_db_all(:,3),'ro');
hold on
semilogx(dist(4,:),pl_db_all(:,4),'mo');
hold on
semilogx(dist(5,:),pl_db_all(:,5),'bo');
hold on
semilogx(dist(6,:),pl_db_all(:,6),'go');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('nLOS path loss-','Routes-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_nlos_model)),strcat('n-simulated:',num2str(N_pathloss_nlos )),'Route3','Route4','Route5','Route6');
saveas(gcf,strcat('nLOS path loss-','Routes-',num2str(project_simulation),'.png'));
savefig(strcat('nLOS path loss-','Routes-',num2str(project_simulation),'.fig'));

save(strcat('pathloss_',num2str(project_simulation),'.mat'),'pl_db_los','pl_db_los_plot'...
=======
%% MODEL
[pl_los_d_model,pl_nlos_d_model,n_los_model,n_nlos_model] = path_function_model(dist_los_plot,dist_nlos_plot);
% [pl_los_d_model,n_los_model]  = path_function_model(dist_los_plot);%,dist_nlos_plot);
%% LOS SET PLOT :The Route 1 & 2 are considered LOS PATHS
pl_db_los =pl_db_all(:,1:2);
pl_db_los=[pl_db_all(1:n_rx_routes(1,1),1)' pl_db_all(1:n_rx_routes(1,2),2)'];
pl_db_los_plot = pl_db_los(dist_los_i);

% RMSE
rms_path_los=erms_f(pl_los_d_model(dist_los_i),pl_db_los_plot);

% Find N
[do_los, index_min_los]=min(dist_los_plot);
pl_do_los=pl_db_los_plot(index_min_los);
d_los=dist_los_plot(dist_los_i);
pl_d_los =pl_db_los_plot;
N_pathloss_los = n_exponent(pl_do_los,pl_d_los,do_los,d_los);
pl_los_simulation= pl_do_los + 10 *N_pathloss_los* log10(d_los/do_los);

figure
semilogx(dist_los_plot,pl_los_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on


hold on 
semilogx(d_los,pl_los_simulation,'bd-');
hold on
semilogx(dist_los_plot_new,pl_db_los_plot,'ro');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('LOS path loss-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_los_model)),strcat('n-simulated:',num2str(N_pathloss_los)),'simulated');
saveas(gcf,strcat('LOS path loss-',num2str(project_simulation),'.png'));
savefig(strcat('LOS path loss-',num2str(project_simulation),'.fig'));

%% LOS ROUTE PLOT
figure
semilogx(dist_los_plot,pl_los_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_los,pl_los_simulation,'bd-');
hold on
semilogx(dist(1,:),pl_db_all(:,1),'ro');
hold on
semilogx(dist(2,:),pl_db_all(:,2),'mo');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('LOS path loss-','Routes-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_los_model)),strcat('n-simulated:',num2str(N_pathloss_los)),'Route1','Route2');
saveas(gcf,strcat('LOS path loss-','Routes-',num2str(project_simulation),'.png'));
savefig(strcat('LOS path loss-','Routes-',num2str(project_simulation),'.fig'));

%% NLOS PLOT : The Route 3:6 are considered NLOS PATHS
pl_db_nlos =pl_db_all(:,3:6);
pl_db_nlos=[pl_db_nlos(1:n_rx_routes(1,3),1)' pl_db_nlos(1:n_rx_routes(1,4),2)' ...
   pl_db_nlos(1:n_rx_routes(1,5),3)' pl_db_nlos(1:n_rx_routes(1,6),4)'];
pl_db_nlos_plot = pl_db_nlos(dist_nlos_i);

% RMSE
rms_path_nlos=erms_f(pl_nlos_d_model(dist_nlos_i),pl_db_nlos_plot);

% Find N
[do_nlos, index_min_nlos]=min(dist_nlos_plot);
pl_do_nlos=pl_db_nlos_plot(index_min_nlos);
d_nlos=dist_nlos_plot(dist_nlos_i);
pl_d_nlos =pl_db_nlos_plot;
N_pathloss_nlos = n_exponent(pl_do_nlos,pl_d_nlos,do_nlos,d_nlos);
pl_nlos_simulation= pl_do_nlos + 10 *N_pathloss_nlos* log10(d_nlos/do_nlos);



figure
semilogx(dist_nlos_plot,pl_nlos_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_nlos,pl_nlos_simulation,'bd-');
hold on
semilogx(dist_nlos_plot_new,pl_db_nlos_plot,'ro');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('nLOS path loss-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_nlos_model)),strcat('n-simulated:',num2str(N_pathloss_nlos )),'simulated');
saveas(gcf,strcat('nLOS path loss-',num2str(project_simulation),'.png'));
savefig(strcat('nLOS path loss-',num2str(project_simulation),'.fig'));

%% NLOS ROUTE PLOT
figure
semilogx(dist_nlos_plot,pl_nlos_d_model,'m');
axis([3 300 60 250]);
set (gca,'Ydir','reverse')
grid on
hold on 
semilogx(d_nlos,pl_nlos_simulation,'bd-');
hold on
semilogx(dist(3,:),pl_db_all(:,3),'ro');
hold on
semilogx(dist(4,:),pl_db_all(:,4),'mo');
hold on
semilogx(dist(5,:),pl_db_all(:,5),'bo');
hold on
semilogx(dist(6,:),pl_db_all(:,6),'go');
grid on
xlabel('Tx-Rx distance(m)');
ylabel('Path loss (dB)');
title(strcat('nLOS path loss-','Routes-',num2str(project_simulation)));
legend(strcat('n-measured:',num2str(n_nlos_model)),strcat('n-simulated:',num2str(N_pathloss_nlos )),'Route3','Route4','Route5','Route6');
saveas(gcf,strcat('nLOS path loss-','Routes-',num2str(project_simulation),'.png'));
savefig(strcat('nLOS path loss-','Routes-',num2str(project_simulation),'.fig'));

save(strcat('pathloss_',num2str(project_simulation),'.mat'),'pl_db_los','pl_db_los_plot'...
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
    ,'rms_path_los','pl_db_nlos','pl_db_nlos_plot','rms_path_nlos');