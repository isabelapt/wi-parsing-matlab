%% Complementary Cumulative Density Function LOS SCENARIO %%
%% First chop the values below the threashold
power_all_los  = [power_phase_all(:,1,1)' power_phase_all(:,1,2)'];

% Get the values about the determined distance
power_all_los_plot = power_all_los(dist_los_i);

% Remove de Nan values
power_all_los_plot_t =isnan (power_all_los_plot);
power_all_los_plot_i = find(power_all_los_plot_t==0);
power_all_los_plot= power_all_los_plot(power_all_los_plot_i);

% Threashold
vec_los =[];
for i = 1:length(power_all_los_plot)
if power_all_los_plot(i) > min(power_all_los_plot)- (threshold)
    vec_los=[vec_los i];
end
end

power_all_los_new = power_all_los_plot(vec_los);

delayspread_all_los = delayspread_all(:,1:2);
delayspread_all_los=delayspread_all_los./10^-9;
delayspread_los = [delayspread_all_los(:,1)' delayspread_all_los(:,2)'];

% Values of the distance range 
delayspread_los_plot = delayspread_los(dist_los_i);

% Remove de Nan values
delayspread_los_t =isnan (delayspread_los_plot);
delayspread_los_i = find(delayspread_los_t==0);
delayspread_los_plot = delayspread_los_plot(delayspread_los_i);

delayspread_los_plot_new = delayspread_los_plot(vec_los);
% delayspread_los_plot_new = delayspread_los;

a=sort(delayspread_los_plot_new);
b=linspace(1-1/length(delayspread_los_plot_new),0,length(delayspread_los_plot_new));

figure
plot(a,b,'linewidth',2)
% xlim([0 60])
% xticks(0:10:60)
grid on
xlabel('(ns)');
ylabel('Probability');
title(strcat('CCDF of RMS delay spread - LOS SCENARIO - ',num2str(project_simulation)));
saveas(gcf,strcat('CCDF LOS SCENARIO -',num2str(project_simulation),'.png'));
savefig(strcat('CCDF LOS SCENARIO -',num2str(project_simulation),'.fig'));

%% Complementary Cumulative Density Function NLOS SCENARIO %%
%% First chop the values below the threashold
power_all_nlos  = [power_phase_all(:,1,3)' power_phase_all(:,1,4)'...
    power_phase_all(:,1,5)' power_phase_all(:,1,6)'];

% Get the values about the determined distance
power_all_nlos_plot = power_all_nlos(dist_nlos_i);

% Remove de Nan values
power_all_nlos_plot_t =isnan (power_all_nlos_plot);
power_all_nlos_plot_i = find(power_all_nlos_plot_t==0);
power_all_nlos_plot= power_all_nlos_plot(power_all_nlos_plot_i);

% Threashold
vec_nlos =[];
for i = 1:length(power_all_nlos_plot)
if power_all_nlos_plot(i) > min(power_all_nlos_plot)- (threshold)
    vec_nlos=[vec_nlos i];
end
end

power_all_nlos_new = power_all_nlos_plot(vec_nlos);

delayspread_all_nlos = delayspread_all(:,3:6);
delayspread_all_nlos=delayspread_all_nlos./10^-9;
delayspread_nlos= [delayspread_all_nlos(:,1)' delayspread_all_nlos(:,2)'...
    delayspread_all_nlos(:,3)' delayspread_all_nlos(:,4)'];

% Values of the distance range 
delayspread_nlos_plot = delayspread_nlos(dist_nlos_i);

% Remove de Nan values
delayspread_nlos_t =isnan (delayspread_nlos_plot);
delayspread_nlos_i = find(delayspread_nlos_t==0);
delayspread_nlos_plot = delayspread_nlos_plot(delayspread_nlos_i);

delayspread_nlos_plot_new = delayspread_nlos_plot(vec_nlos);
% delayspread_nlos_plot_new = delayspread_los;

c=sort(delayspread_nlos_plot_new);
d=linspace(1-1/length(delayspread_nlos_plot_new),0,length(delayspread_nlos_plot_new));

figure
plot(c,d,'linewidth',2);
grid on
xlabel('(ns)');
ylabel('Probability');
title(strcat('CCDF of RMS delay spread - NLOS SCENARIO - ',num2str(project_simulation)));
saveas(gcf,strcat('CCDF NLOS SCENARIO -',num2str(project_simulation),'.png'));
savefig(strcat('CCDF NLOS SCENARIO -',num2str(project_simulation),'.fig'));
% 
save(strcat('ccdf_rmsdelay_',num2str(project_simulation),'.mat'),'delayspread_los_plot_new',...
    'delayspread_los','delayspread_nlos_plot_new','delayspread_nlos');