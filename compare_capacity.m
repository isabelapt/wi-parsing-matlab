% Compare Capacity
clear,clc;
close all;

% Add path of the mimo toolbox of Prof.Aldebaro
addpath('/home/lasse/Documentos/5GMDATA/mimo-matlab')

%% Compare FULL MIMO with MIMO Estimation from SISO
run read_MIMOoutput.m
load('capacity_mimo.mat');

run simulate_geometricNarrow_ds.m
load('capacity_los_model_ds.mat');

SNR =[-20:20];
rx_route_index = [1 5 10 15 20 25 30 35];

for i = 1:length(rx_route_index)
figure
plot(SNR,Cequal_mimo(i,:)*10^-6,'-x')
hold on
plot(SNR,Cequal_siso(i,:)*10^-6,':')
legend ('Equal Power Allocation - FULL MIMO','Equal Power Allocation - FROM SISO');
title (strcat('COMPARISON METHODS - RX ',num2str(rx_route_index(i))));
grid on
end
