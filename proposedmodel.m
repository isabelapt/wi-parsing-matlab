<<<<<<< HEAD
%Ajuste Modelo Proposto

d = 1:length(PRx_in);  %distancia = tamanho do vetor de dados

iury2 = -25.7363 + 10*2.6304*log10(d_m) + 20*log10(f_MHz); % modelo Iury 5.2

m_itu = (20*log10(f_MHz)) + (24*log10(d_m)) - 28 ; % modelo do ITU

m_mk = Pl_d0 +10*12.848*log10(d);% ------modelo Keenan e Motley------

% LRx10_2 = PTx - PRx_in + GTx + GRx -2*Ls_db; %insite

LRx10_2 = PTx - PRx_in - Ls_db; %insite

% residuo_2 = LRx10_2 - 20*log10(f_MHz)+ 28; %original

residuo_2 = LRx10_2 - 20*log10(f_MHz); %original

[a4,b4,t4,z4] = log_tend1(d, residuo_2, length(LRx10_2));

mp = a4 + b4*10*log10(d) + 20*log10(f_MHz) ; %modelo modificado

%RMS, erro absoluto e desvio padrão -> modelo iury MODIFICADO
rms_mp = sqrt(mean((LRx10_2' - mp).^2))
rms_iury = sqrt(mean((LRx10_2' - iury2).^2))
rms_itu = sqrt(mean((LRx10_2' - m_itu).^2))

figure ;
plot (d,residuo_2, '*r');hold on
plot (d,z4, '-*g');
xlabel ('Distância (m)');
ylabel ('Perda (dB)'); 
title('Cálculo dos Resíduos')

figure ;
plot(d, LRx10_2,'*k'); hold on;
plot(d, mp,'m'); hold on;
plot(d, iury2,'r'); hold on;
plot(d, m_itu, 'g'); hold on;
% plot(d, m_mk, '-k');
legend ('Perda Medida', 'Modelo Proposto', 'Modelo Iury', 'Modelo ITU')%,'Modelo K&M')
xlabel ('Distância (m)');
ylabel ('Perda (dB)'); 
title('Comparação entre modelos')
=======
%Ajuste Modelo Proposto

d = 1:length(PRx_in);  %distancia = tamanho do vetor de dados

iury2 = -25.7363 + 10*2.6304*log10(d_m) + 20*log10(f_MHz); % modelo Iury 5.2

m_itu = (20*log10(f_MHz)) + (24*log10(d_m)) - 28 ; % modelo do ITU

m_mk = Pl_d0 +10*12.848*log10(d);% ------modelo Keenan e Motley------

% LRx10_2 = PTx - PRx_in + GTx + GRx -2*Ls_db; %insite

LRx10_2 = PTx - PRx_in - Ls_db; %insite

% residuo_2 = LRx10_2 - 20*log10(f_MHz)+ 28; %original

residuo_2 = LRx10_2 - 20*log10(f_MHz); %original

[a4,b4,t4,z4] = log_tend1(d, residuo_2, length(LRx10_2));

mp = a4 + b4*10*log10(d) + 20*log10(f_MHz) ; %modelo modificado

%RMS, erro absoluto e desvio padrão -> modelo iury MODIFICADO
rms_mp = sqrt(mean((LRx10_2' - mp).^2))
rms_iury = sqrt(mean((LRx10_2' - iury2).^2))
rms_itu = sqrt(mean((LRx10_2' - m_itu).^2))

figure ;
plot (d,residuo_2, '*r');hold on
plot (d,z4, '-*g');
xlabel ('Distância (m)');
ylabel ('Perda (dB)'); 
title('Cálculo dos Resíduos')

figure ;
plot(d, LRx10_2,'*k'); hold on;
plot(d, mp,'m'); hold on;
plot(d, iury2,'r'); hold on;
plot(d, m_itu, 'g'); hold on;
% plot(d, m_mk, '-k');
legend ('Perda Medida', 'Modelo Proposto', 'Modelo Iury', 'Modelo ITU')%,'Modelo K&M')
xlabel ('Distância (m)');
ylabel ('Perda (dB)'); 
title('Comparação entre modelos')
>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
