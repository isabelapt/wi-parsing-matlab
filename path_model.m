%% The path loss exponent model 
d0_model= 5; % Reference distance
n_los_model=2.2;
pl_los_d0_model = 82.04;
n_nlos_model=3.26;
pl_nlos_d0_model = 80.4;

[pl_los_d_model,pl_nlos_d_model] = path_function_model(dist_los_plot,dist_nlos_plot,...
    d0_model,n_los_model,pl_los_d0_model,n_nlos_model,pl_nlos_d0_model);