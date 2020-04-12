% Analysis of intereactions
% For Tx1
load('results_1.mat');

path_des_nlos_3 = path_des_all{1,3};
path_des_nlos_4 = path_des_all{1,4};
path_des_nlos_5 = path_des_all{1,5};
path_des_nlos_6 = path_des_all{1,6};

if_nlos3=zeros(250,n_rx_routes(3));
if_nlos4=zeros(250,n_rx_routes(4));
if_nlos5=zeros(250,n_rx_routes(5));
if_nlos6=zeros(250,n_rx_routes(6));

a=[];
b=[];
c=[];
d=[];

for i=1:n_rx_routes(3)
a=contains(path_des_nlos_3(1:rx_paths_all(i,3),i),'-D-');
if_nlos3(1:length(a),i)=a;
n_nlos3 = sum(if_nlos3);
end

for i=1:n_rx_routes(4)
b = contains(path_des_nlos_4(1:rx_paths_all(i,4),i),'-D-');
if_nlos4(1:length(b),i)=b;
n_nlos4 = sum(if_nlos4);
end

for i=1:n_rx_routes(5)
c= contains(path_des_nlos_5(1:rx_paths_all(i,5),i),'-D-');
if_nlos5(1:length(c),i)=c;
n_nlos5 = sum(if_nlos5);
end

for i=1:n_rx_routes(6)
d = contains(path_des_nlos_6(1:rx_paths_all(i,6),i),'-D-');
if_nlos6(1:length(d),i)=d;
n_nlos6 = sum(if_nlos6);
end

save('paths_diffractions_1.mat','n_nlos3','n_nlos4','n_nlos5','n_nlos6');

% For Tx2
load('results_2.mat');

path_des_nlos_3 = path_des_all{1,3};
path_des_nlos_4 = path_des_all{1,4};
path_des_nlos_5 = path_des_all{1,5};
path_des_nlos_6 = path_des_all{1,6};

if_nlos3=zeros(250,n_rx_routes(3));
if_nlos4=zeros(250,n_rx_routes(4));
if_nlos5=zeros(250,n_rx_routes(5));
if_nlos6=zeros(250,n_rx_routes(6));

a=[];
b=[];
c=[];
d=[];

for i=1:n_rx_routes(3)
a=contains(path_des_nlos_3(1:rx_paths_all(i,3),i),'-D-');
if_nlos3(1:length(a),i)=a;
end

for i=1:n_rx_routes(4)
b = contains(path_des_nlos_4(1:rx_paths_all(i,4),i),'-D-');
if_nlos4(1:length(b),i)=b;
end

for i=1:n_rx_routes(5)
c= contains(path_des_nlos_5(1:rx_paths_all(i,5),i),'-D-');
if_nlos5(1:length(c),i)=c;
end

for i=1:n_rx_routes(6)
d = contains(path_des_nlos_6(1:rx_paths_all(i,6),i),'-D-');
if_nlos6(1:length(d),i)=d;
end

save('paths_diffractions_2.mat','n_nlos3','n_nlos4','n_nlos5','n_nlos6')