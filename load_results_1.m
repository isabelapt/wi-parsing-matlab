load('variables_1.mat');
load('results_semds_tx1.mat');
pl_insite_semds_tx1 = pl_db_insite_all;
rx_paths_semds_tx1 = rx_paths_all;
time_arrival_semds_tx1 = time_arrival_all;
a='Sem DS';
run TxRx_distance.m 
run path_loss.m
run delay_spread.m
run ccdf.m
run rms_txrx.m
save('pl_insite_semds_tx1.mat','pl_db_insite_los_plot','pl_db_insite_nlos_plot','delay_index_ns_tx1',...
    'normalized_power_paths_dbm_tx1','delay_index_ns_tx2','normalized_power_paths_dbm_tx2','path_des_tx1_sort',...
    'path_des_tx2_sort','rx_t1','rx_t2','I_tx1','I_tx2','info_tx1_sort','info_tx2_sort','path_position_tx1_sort',...
    'path_position_tx2_sort');
save('distance_1.mat','dist_los','dist_nlos','dist_los_i','dist_nlos_i','dist_los_n','dist_nlos_n');
save('n_insite_1.mat','n_los_insite','n_nlos_insite');