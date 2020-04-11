<<<<<<< HEAD
% Compare power of 2 different simulations MIMO
close all;
clear,clc;

Nreceivers = 10;
%% 4x4
Nrx = 4;
Ntx = 4;
addpath('60000 MHz\4x4\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_0=RPower_matrix;

addpath('60100 MHz\4x4\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_1=RPower_matrix;

addpath('60200 MHz\4x4\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_2=RPower_matrix;


%% 8x8 
Nrx = 8;
Ntx = 8;
addpath('60000 MHz\8x8\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix8_0=RPower_matrix;

addpath('60100 MHz\8x8\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix8_1=RPower_matrix;

addpath('60200 MHz\8x8\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
=======
% Compare power of 2 different simulations MIMO
close all;
clear,clc;

Nreceivers = 10;
%% 4x4
Nrx = 4;
Ntx = 4;
addpath('60000 MHz\4x4\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_0=RPower_matrix;

addpath('60100 MHz\4x4\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_1=RPower_matrix;

addpath('60200 MHz\4x4\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_2=RPower_matrix;


%% 8x8 
Nrx = 8;
Ntx = 8;
addpath('60000 MHz\8x8\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix8_0=RPower_matrix;

addpath('60100 MHz\8x8\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix8_1=RPower_matrix;

addpath('60200 MHz\8x8\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
RPower_matrix8_2=RPower_matrix;