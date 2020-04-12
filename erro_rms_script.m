clear,clc;
% Script para calcular o ERRO RMS LOS
u=pl_los_d_model;
v=pl_db_los_plot;

z=erms_f(pl_los_d_model,pl_db_los_plot);

x=dist_los_plot;
figure
plot(x,u,'ro');
hold on
plot(x,v,'bo');
title('RMSE')
