% Route length

% Number of Rx per Condition
% LOS Routes
nrx_los = n_rx_routes(1,1)+n_rx_routes(1,2);
% NLOS Routes
nrx_plotlos = n_rx_routes(1,3)+n_rx_routes(1,4)+n_rx_routes(1,5)+n_rx_routes(1,6);

dist=[];
dist_plot=[];

Rx_editpoints_routes =[4 4 3 3 2 2];

Rx_editpoints =[Rx1_pos;Rx2_pos;Rx3_pos;Rx4_pos;Rx5_pos;Rx6_pos];