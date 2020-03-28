%% Delay Spread
% Root mean square (rms) delay spread as the second moment of APDPs
% Taken at the same location at 68 m Tx-Rx
threshold = -50;
txrx_distance = 68;
ls_db=0;
format short 

[c1,index1] = min(abs(txrx_distance-dist_los(1:n_rx_routes(1,1))));
[c2,index2] = min(abs(txrx_distance-dist_los(n_rx_routes(1,1)+1:end)));
rx_t1 = index1;
rx_t2 = index2;

%% Path delay of rx_t1
route = 1;
legenda1 = strcat('PDP-',num2str(tx_set),'-',a,'-','Route','1-','Rx',' ',num2str(rx_t1));

delay_index=[];

t_arrival_index = time_arrival_all(:,rx_t1,route);
power_paths_index = powerpaths_dbm_all(:,rx_t1,route);

[t_arrival_index_sort  I_tx1]=sort(t_arrival_index');
power_paths_index_sort_dbm = power_paths_index(I_tx1)';
power_paths_index_sort_W= dbm2W(power_paths_index_sort_dbm,ls_db);

delay_index(1)= 0;
normalized_power_paths_dbm_tx1=10.*log10(power_paths_index_sort_W/max(power_paths_index_sort_W));

for i = 2:250
delay_index(i) = (t_arrival_index_sort(1,i) - t_arrival_index_sort(1,1));
end

delay_index_ns_tx1 =delay_index./10^-9;

%% Path interaction of the rx_t1
path_des_tx1=path_des_all{1,1}(:,rx_t1);
path_des_tx1_sort = path_des_tx1(I_tx1);

%% Plot for rx_t1
figure
plot(delay_index_ns_tx1,normalized_power_paths_dbm_tx1,'.b','markersize',15);hold on;
lpx40=length(delay_index_ns_tx1);
for n=1:length(delay_index_ns_tx1)
plot([delay_index_ns_tx1(n),delay_index_ns_tx1(n)],[normalized_power_paths_dbm_tx1(n),threshold],'b-'); hold on;
end
grid on;
axis([0 300 threshold 0])
xlabel('Excess Delay (ns)');
ylabel('Normalized power (dB)');
title(legenda1);
saveas(gcf,strcat(legenda1,'.png'));
savefig(strcat(legenda1,'.fig'));

%% %% Path delay of rx_t2 
route = 2;
legenda2=strcat('PDP-',num2str(tx_set),'-',a,'-','Route','2-','Rx',' ',num2str(rx_t2));
delay_index=[];

t_arrival_index = time_arrival_all(:,rx_t2,route);
power_paths_index = powerpaths_dbm_all(:,rx_t2,route);

[t_arrival_index_sort  I_tx2]=sort(t_arrival_index');
power_paths_index_sort_dbm = power_paths_index(I_tx2)';
power_paths_index_sort_W= dbm2W(power_paths_index_sort_dbm,ls_db);

delay_index(1)= 0;
normalized_power_paths_dbm_tx2=10.*log10(power_paths_index_sort_W/max(power_paths_index_sort_W));

for i = 2:250
delay_index(i) = (t_arrival_index_sort(1,i) - t_arrival_index_sort(1,1));
end

delay_index_ns_tx2 =delay_index./10^-9;

%% Path interaction of the rx_t2
path_des_tx2=path_des_all{1,2}(:,rx_t2);
path_des_tx2_sort = path_des_tx2(I_tx2);

%% Plot for rx_t2
figure
plot(delay_index_ns_tx2,normalized_power_paths_dbm_tx2,'.b','markersize',15);hold on;
lpx40=length(delay_index_ns_tx2);
for n=1:length(delay_index_ns_tx2)
plot([delay_index_ns_tx2(n),delay_index_ns_tx2(n)],[normalized_power_paths_dbm_tx2(n),threshold],'b-'); hold on;
end
grid on;
axis([0 300 threshold 0])
xlabel('Excess Delay (ns)');
ylabel('Normalized power (dB)');
title(legenda2);
saveas(gcf,strcat(legenda2,'.png'));
savefig(strcat(legenda2,'.fig'));

%% Organize Info by delay sort
info_tx1=path_info_all(:,:,rx_t1,1);
info_tx1_sort =info_tx1(I_tx1,:);

info_tx2=path_info_all(:,:,rx_t2,1);
info_tx2_sort =info_tx1(I_tx2,:);

path_int_position_tx1=path_int_position_all{1,1}(:,rx_t1);
path_position_tx1_sort =path_int_position_tx1(I_tx1,:);

path_int_position_tx2=path_int_position_all{1,2}(:,rx_t2);
path_position_tx2_sort =path_int_position_tx1(I_tx2,:);


