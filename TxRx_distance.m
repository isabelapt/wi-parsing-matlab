%% Calculate the distance

% Number of Rx per Condition
% LOS Routes
nrx_los = n_rx_routes(1,1)+n_rx_routes(1,2);
% NLOS Routes
nrx_plotlos = n_rx_routes(1,3)+n_rx_routes(1,4)+n_rx_routes(1,5)+n_rx_routes(1,6);

dist=[];
dist_plot=[];

Rx_editpoints_routes =[4 4 3 3 2 2];
Rx_editpoints =[Rx1_pos;Rx2_pos;Rx3_pos;Rx4_pos;Rx5_pos;Rx6_pos];
c=1;
for j=1:n_routes
    if n_rx_routes(1,j)~=0
        Tx=repmat(Tx_pos,n_rx_routes(1,j),1);
        if j<3 % for LOS
            for k = 1: n_rx_routes(1,j)
                Rx(k,:) =Rx_editpoints(c,1:2);
                dist(j,1)= norm(Tx(1,:) - Rx(k,:));
                dist(j,k+1)= dist(j,k)+ spacing;
                if rx_position_all(k,1:2,j) == Rx_editpoints(c+1,1:2)
                    c=c+1;
                end
            end
        else % for NLOS
            %It is calculated the distance from the first rx and then
            %it is add spacing
            for k = 1: n_rx_routes(1,j)
                if rx_position_all(k,1:2,j) == Rx_editpoints(c,1:2)
                    Rx(c,:) =Rx_editpoints(c,1:2);
                    dist(j,1)= norm(Tx(1,:) - Rx(c,:));
                    dist(j,k+1)= dist(j,k)+ spacing;
                end
            end
        end
    else
        continue
    end
end
%% Adequate de Tx-Rx Distance to plot
% LOS 4 - 200 m
% NLOS 4 - 100 m
for j=1:n_routes
    for i=1:rx_max
        if j<3
            if dist(j,i) <4 || dist(j,i) >200
                dist_plot(j,i)= NaN;
            else
                dist_plot(j,i)= dist(j,i);
            end
        else
            if dist(j,i) <4 || dist(j,i) >100
                dist_plot(j,i)= NaN;
            else
                dist_plot(j,i)= dist(j,i);
            end
            
        end
    end
end
dist_los = [dist(1,1:n_rx_routes(1)) dist(2,1:n_rx_routes(2))];
dist_nlos = [dist(3,1:n_rx_routes(3)) dist(4,1:n_rx_routes(4)) dist(5,1:n_rx_routes(5)) dist(6,1:n_rx_routes(6))];

dist_los_plot = [dist_plot(1,1:n_rx_routes(1)) dist_plot(2,1:n_rx_routes(2))];
dist_nlos_plot = [dist_plot(3,1:n_rx_routes(3)) dist_plot(4,1:n_rx_routes(4)) dist_plot(5,1:n_rx_routes(5)) dist_plot(6,1:n_rx_routes(6))];

dist_los_plot_t =isnan (dist_los_plot);
dist_nlos_plot_t =isnan (dist_nlos_plot);

dist_los_i = find(dist_los_plot_t==0);
dist_nlos_i = find(dist_nlos_plot_t==0);

dist_los_plot_new = dist_los_plot(dist_los_i);
dist_nlos_plot_new = dist_nlos_plot(dist_nlos_i);

save(strcat('correctdistances_',num2str(project_simulation),'.mat'),'dist_los'...
    ,'dist_los_plot','dist_los_i','dist_los_plot_new','dist_nlos','dist_nlos_plot','dist_nlos_i','dist_nlos_plot_new');