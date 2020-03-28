clear,clc;
close all;
format longEng
restoredefaultpath
load('capacity_los_model_ds.mat');
MimoModel_rxW_ds = MimoModel_rxW;
load('capacity_los_model.mat');
MimoModel_rxW_nds = MimoModel_rxW;