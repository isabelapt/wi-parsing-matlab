function [powerpaths_dbm,timearrival_sec,powerphase_deg] =paths_power_phase(rx,filename)
% Usar outro p2m para analisar a potencia de cada raio (ex:cir) e a fase
% filename = 'model.cir.t001_01.r002.p2m';
delimiterIn = ' ';
headerlinesIn = 3; % Numero de Linhas para ignorar
A=importdata(filename,delimiterIn,headerlinesIn);
k=1;

rx_paths= zeros(1,rx);
rx_paths(1)= A.data(1,2);

headerlinesIn = 4; % Numero de Linhas para ignorar
A=importdata(filename,delimiterIn,headerlinesIn);

for i=1:rx % Numero de pontos receptores
    for j=1:rx_paths(i)
        powerphase_deg(j,i)=A.data(k,2);  % Fase em deg
        timearrival_sec(j,i)=A.data(k,3);  % Time of arrival em seg
        powerpaths_dbm(j,i)=A.data(k,4);  % Potencia em dBm
        k=k+1;
    end
    if k >length(A.data)
        break
    end
    rx_paths(i+1)= A.data(k,2);
    k=k+1;
end
 
end

