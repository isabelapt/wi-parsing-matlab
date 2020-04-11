<<<<<<< HEAD
% Script to read SNR from Communication Analysis
clear,clc;
close all;
format longEng
% comm_folder = 'C:\Users\isabe\OneDrive\Documentos\TCC\Outdoor\Scenario3\Material_2\Teste4_comds\Tx1\study_x3D\teste';
% addpath(comm_folder)
% filename_noise=strcat(project_name,'.noise.t1_1.r',num2str(route),end_name);

filename = 'berlin_tcc.noise.t1_1.r2.p2m';

M = dlmread(filename,'', 2, 0);
=======
% Script to read SNR from Communication Analysis
clear,clc;
close all;
format longEng
% comm_folder = 'C:\Users\isabe\OneDrive\Documentos\TCC\Outdoor\Scenario3\Material_2\Teste4_comds\Tx1\study_x3D\teste';
% addpath(comm_folder)
% filename_noise=strcat(project_name,'.noise.t1_1.r',num2str(route),end_name);

filename = 'berlin_tcc.noise.t1_1.r2.p2m';

M = dlmread(filename,'', 2, 0);
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
SNR= M(:,8);