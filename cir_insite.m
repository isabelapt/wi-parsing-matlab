function [time_arrival,powerpaths_dbm,powerphase_deg,rx_paths,path_max_rx ] =cir_insite(rx,filename_cir)
rx_paths=[];
fileID = fopen(filename_cir);
C = textscan(fileID,'%s');
A=C{1,1}(44:length(C{1,1}),1);
A=str2double(A);
rx_paths(1)= A(3,1); % Number of paths of the first receiver
end_v(1) =rx_paths(1)*4+3; % Data from first receiver ends
rx_matrix = zeros(end_v(1),rx);
rx_matrix(:,1)= A(1:end_v(1),1);

for i=2:rx
    rx_paths(i)= A(end_v(i-1)+2,1);
    end_v(i) =(end_v(i-1)+rx_paths(i)*4+2);
    rx_matrix(1:length(A(end_v(i-1)+1:end_v(i),1)),i)= A(end_v(i-1)+1:end_v(i),1);
end

d=ones(length(rx_matrix),1)*4;
for i=1:rx
    a=0;
    for j=1:rx_paths(i)
        a=d(j)+a;
        powerphase_deg(j,i)=rx_matrix(a,i);  % Fase em deg
        time_arrival(j,i)=rx_matrix(a+1,i);    % Time arrival em segundos
        powerpaths_dbm(j,i)=rx_matrix(a+2,i);  % Potencia em dBm
    end
    for j=rx_paths(i)+1:25
        a=d(j)+a;
        powerphase_deg(j,i)=NaN;  % Fase em deg
        time_arrival(j,i)=NaN;    % Time arrival em segundos
        powerpaths_dbm(j,i)=NaN;  % Potencia em dBm
    end
end
path_max_rx = max(rx_paths);
end

