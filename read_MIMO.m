% Read Hmatrix for one simulation narrowband MIMO
close all;
clear,clc;
Nreceivers = 10;

%% 4x4
Nrx = 4;
Ntx = 4;
addpath('..\NarrowBand\60000 MHz_MIMO\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_0=Hfit;

addpath('..\NarrowBand\60000 MHz_MIMO\power');
[RPower_matrix] = RPowerInSite_f( Nreceivers,Nrx,Ntx);
RPower_matrix4_0=RPower_matrix;

addpath('..\NarrowBand\60000 MHz_MIMO\cir');
[CIR_matrix] = CIRInSite_f(Nreceivers,Nrx,Ntx);
CIR_matrix4_0=CIR_matrix;

