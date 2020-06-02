%% Plot of RMS Delay Spread Vs TXRX Distance
figure 
plot(dist_los_plot(vec_los),delayspread_los_plot_new,'or')
% xlim([0 100])
grid on
xlabel('Tx-Rx Distance(m)');
ylabel('RMS Delay Spread (ns)');
title(strcat('RMS delay spread vs LOS Distance - ',num2str(project_simulation)));
saveas(gcf,strcat('RMS delay spread-LOS Distance',num2str(project_simulation),'.png'));
savefig(strcat('RMS delay spread-LOS Distance',num2str(project_simulation),'.fig'));
