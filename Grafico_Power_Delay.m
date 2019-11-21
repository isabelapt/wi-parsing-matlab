clear,clc;
close all;
%% Grafico Power Delay Profile %%
rx=40; % Numero de Receptores

% Organizar no excel uma tabela sem cabecalho com o *.cir
filename = 'complex_impulse_response.xlsx';
A = xlsread(filename);
k=2; % Linha que comeca os dados

paths=100;

for i=1:rx % Numero de pontos receptores
   for j=1:paths
       time(j,i)=A(k,3);   % Tempo de resposta em segundos
       power_dbm(j,i)=A(k,4);  % Potencia em dBm
  k=k+1;     
   end
  k=k+1;
end

% pdp= abs(power.^2./time);
% plot(time(:,1),pdp(:,1));
rx=1:40;

% Classificando de forma ascedente de acordo com o tempo
[time I]=sort(time);
power_dbm= power_dbm(I);
power_W = 10.^((power_dbm-30)./10);
pdp_W= power_W;
pdp_dbm = 10*log10(pdp_W)+30;

figure
plot(time(:,1),pdp_dbm(:,1)); % plot para um ponto de recepcao
title('Plot para um ponto de recepcao');
ylabel('Potência(dBm)');
xlabel('Delay(sec)');

z1=ones(paths,40);
for i=1:paths
z2(i,:)=z1(i,:).*z;
end

figure
plot3(z2,time,pdp_dbm);
title('Perfil de Potência e Retardo');
xlabel('Pontos de Recepção');
ylabel('Tempo(sec)');
zlabel('Potência(dBm)');


figure
surfc(z2,time,pdp_dbm);
title('Perfil de Potência e Retardo');
xlabel('Pontos de Recepção');
ylabel('Tempo(seg)');
zlabel('Potência(dBm)');