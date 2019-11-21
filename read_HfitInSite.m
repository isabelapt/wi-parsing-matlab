% Compare H matrix of 2 different simulations MIMO
close all;
clear,clc;
Nreceivers = 10;

%% 4x4
Nrx = 4;
Ntx = 4;
addpath('..\60000 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_0=Hfit;

addpath('..\60100 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_1=Hfit;

addpath('..\60200 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_2=Hfit;

addpath('..\60300 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_3=Hfit;

addpath('..\60400 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_4=Hfit;

addpath('..\60500 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_5=Hfit;

addpath('..\60600 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_6=Hfit;

addpath('..\60700 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_7=Hfit;

addpath('..\60800 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_8=Hfit;

addpath('..\60900 MHz\4x4\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit4_9=Hfit;

Hfit_4Full = cat(3,Hfit4_0,Hfit4_1,Hfit4_2,Hfit4_3,Hfit4_4,Hfit4_5,Hfit4_6,Hfit4_7,Hfit4_8,Hfit4_9);
close all;

%% 8x8 
Nrx = 8;
Ntx = 8;
addpath('..\60000 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_0=Hfit;

addpath('..\60100 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_1=Hfit;

addpath('..\60200 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_2=Hfit;

addpath('..\60300 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_3=Hfit;

addpath('..\60400 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_4=Hfit;

addpath('..\60500 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_5=Hfit;

addpath('..\60600 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_6=Hfit;

addpath('..\60700 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_7=Hfit;

addpath('..\60800 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_8=Hfit;

addpath('..\60900 MHz\8x8\hmatrix');
[Hfit] = HfitInSite_f(Nreceivers,Nrx,Ntx);
Hfit8_9=Hfit;

Hfit_8Full = cat(3,Hfit8_0,Hfit8_1,Hfit8_2,Hfit8_3,Hfit8_4,Hfit8_5,Hfit8_6,Hfit8_7,Hfit8_8,Hfit8_9);
close all;