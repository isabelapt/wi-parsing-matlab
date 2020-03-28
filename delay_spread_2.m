%% Delay Spread
ls_db=0;
format short 
route = 1;
rx_t = 55; % aprox 68 Tx-Rx
delay_index=[];

paths_rx_b =sum(rx_paths_all(1,1:rx_t-1,route));
paths_rx_range =sum(rx_paths_all(1,rx_t,route));

paths_rx_desired = paths_rx_b+1:paths_rx_b+paths_rx_range;

t_arrival_index = cell2mat(time_arrival_all(paths_rx_desired,route));
power_paths_index = cell2mat(power_paths_all(paths_rx_desired,route));

% delay_index(1)= 0;
% normalized_power_paths(1)=0;

[t_arrival_index_sort  I]=sort(t_arrival_index');
power_paths_index_sort_dbm = power_paths_index(I)';
power_paths_index_sort_W= dbm2W(power_paths_index_sort_dbm,ls_db);

delay_index(1)= 0;
normalized_power_paths_dbm=10.*log10(power_paths_index_sort_W/max(power_paths_index_sort_W));
% normalized_power_paths_dbm_2= (power_paths_index_sort_dbm - max(power_paths_index_sort_dbm))./(max(power_paths_index_sort_dbm)-min(power_paths_index_sort_dbm));


for i = 2:paths_rx_range
delay_index(i) = (t_arrival_index_sort(1,i) - t_arrival_index_sort(1,1));
end

delay_index_ns =delay_index./10^-9;

% figure
% plot(delay_index_ns,normalized_power_paths_dbm);
% grid on
% xlabel('Excess Delay (ns)');
% ylabel('Normalized power (dB)');
% title(strcat('PDP-',set,' ',a));


figure
plot(delay_index_ns,normalized_power_paths_dbm,'.b','markersize',15);hold on;
lpx40=length(delay_index_ns);
for n=1:length(delay_index_ns)
plot([delay_index_ns(n),delay_index_ns(n)],[normalized_power_paths_dbm(n),-80],'b-'); hold on;
end
grid on;
axis([0 450 -80 0])
%axis([120 160 -100 -40])
xlabel('Excess Delay (ns)');
ylabel('Normalized power (dB)');
title(strcat('PDP-',set,'-',a,'-','Route 1',rx_t));
saveas(gcf,strcat('PDP-',set,'-',a,'-','Route 1',rx_t,'.png'));
savefig(strcat('PDP-',set,'-',a,'-','Route 1',rx_t,'.fig'));
