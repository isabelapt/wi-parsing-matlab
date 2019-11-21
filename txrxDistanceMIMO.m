%% LOS ROUTES
spacing_full=37.5;
spacing_model=1.25;

addpath('../Material_2/Teste4_comds/results');
% addpath('..\Material_2\Teste4_comds\results');
load(strcat('correctdistances_1.mat'));

% For route 1 
dist_losMIMO1(1)=dist_los(1);
for rx=2:rx_routes(1)
    dist_losMIMO1(rx) = dist_losMIMO1(1)+(spacing_full*(rx-1));
end

% For route 2
dist_losMIMO2(1)=dist_los(210+1);
for rx=2:rx_routes(2)
    dist_losMIMO2(rx) = sqrt(dist_losMIMO2(1)^2 + (spacing_full*(rx-1))^2);
end



