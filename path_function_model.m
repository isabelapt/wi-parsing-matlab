function [pl_los_d_model,pl_nlos_d_model,n_los_model,n_nlos_model] = path_function_model(dist_los_plot,dist_nlos_plot)
%  function [pl_los_d_model,n_los_model] = path_function_model(dist_los_plot);%,dist_nlos_plot) 
d0_model= 5; % Reference distance
n_los_model=2.2;
pl_los_d0_model = 82.04;
n_nlos_model=3.26;
pl_nlos_d0_model = 80.4;

pl_los_d_model = pl_los_d0_model + 10 *n_los_model* log10(dist_los_plot/d0_model);
pl_nlos_d_model = pl_nlos_d0_model + 10 *n_nlos_model* log10(dist_nlos_plot/d0_model);
end
