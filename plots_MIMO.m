<<<<<<< HEAD
clear,clc;
close all;
format longEng
restoredefaultpath

run compare_narrowband.m
%% Error Plot
dif_abs=abs(Hnorm -Hnorm_insite);
dif_per = abs(dif_abs./Hnorm).*100;
if plotall_error ==1
    for j=1:rx
        figure
        bar3(dif_per(:,:,j));
        title(['Rx', num2str(j)]);
    end
end

y_per= squeeze(mean(mean(dif_per,1),2));
y_abs= squeeze(mean(mean(dif_abs,1),2));
yper_sort=y_per(dist_i)
yabs_sort=y_abs(dist_i)
figure
bar(dist_sort,yabs_sort);
xlabel('Distance(m)');
ylabel('Absolute Error');
title('BAR DISTRIBUTION OF THE ERRORS');
legend(num2str(dist_i));

% 'double2strRx: 1, 2, 3, 4');
%% Capacity 
% for 2 Rx's ( 6 and 10 )

SNRvec_dB = [-20:20];

calcType = 1; % calcType = 1: eigenvalues are NOT used for capacity calculation
              % calcType = 2: eigenvalues are used for capacity calculation
figure
H_RT1 = Hnorm_insite(:,:,1);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT1);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT2 = Hnorm_insite(:,:,2);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT2);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT3 = Hnorm_insite(:,:,3);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT3);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT4 = Hnorm_insite(:,:,4);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT4);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT5 = Hnorm_insite(:,:,5);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT5);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT6 = Hnorm_insite(:,:,6);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT6);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

% H_RT7 = Hnorm_insite(:,:,7);              
% [C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT7);
% plot(SNRvec_dB,C,'-.*','LineWidth',1)
% hold on

H_RT8 = Hnorm_insite(:,:,8);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT8);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

save('Hfull.mat','H_RT1','H_RT2','H_RT3','H_RT4',...
    'H_RT5','H_RT6','H_RT7','H_RT8')

Csiso = log2(1+10.^(SNRvec_dB/10));             
plot(SNRvec_dB,Csiso,'y','LineWidth',2)

legend('Rx 1','Rx 2','Rx 3','Rx 4',...
    'Rx 5','Rx 6','Rx 7','Rx 8','SISO');
xlabel('SNR (dB)');
ylabel('Spectral Efficiency (bps\Hz)');
% title('CAPACITY OF THE MIMO CHANNEL USING');
saveas(gcf,'CAPACITY OF THE MIMO CHANNEL USING FULL RT SIMULATION WITH DS.png');
savefig('CAPACITY OF THE MIMO CHANNEL USING FULL RT SIMULATION WITH DS.fig');
grid on

%% Narrow 
figure
H_narrow1 = Hnorm(:,:,1);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow1,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow2= Hnorm(:,:,2);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow2,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow3 = Hnorm(:,:,3);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow3,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow4= Hnorm(:,:,4);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow4,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow5= Hnorm(:,:,5);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow5,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow6= Hnorm(:,:,6);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow6,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

% H_narrow7= Hnorm(:,:,7);
% [C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow7,1);
% plot(SNRvec_dB,C,'-.o','LineWidth',1)
% hold on

H_narrow8= Hnorm(:,:,8);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow8,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)


save('Hmodel.mat','H_narrow1','H_narrow2','H_narrow3','H_narrow4',...
    'H_narrow5','H_narrow6','H_narrow7','H_narrow8')

Csiso = log2(1+10.^(SNRvec_dB/10));             
plot(SNRvec_dB,Csiso,'y','LineWidth',2)

legend('Rx 1','Rx 2','Rx 3','Rx 4',...
    'Rx 5','Rx 6','Rx 7','Rx 8','SISO');
xlabel('SNR (dB)');
ylabel('Spectral Efficiency (bps\Hz)');
% title('CAPACITY OF THE MIMO CHANNELS');
saveas(gcf,'CAPACITY OF THE MIMO CHANNEL USING SIMPLIFIED RT SIMULATION WITH DS.png');
savefig('CAPACITY OF THE MIMO CHANNEL USING SIMPLIFIED RT SIMULATION WITH DS.fig');
grid on

=======
clear,clc;
close all;
format longEng
restoredefaultpath

run compare_narrowband.m
%% Error Plot
dif_abs=abs(Hnorm -Hnorm_insite);
dif_per = abs(dif_abs./Hnorm).*100;
if plotall_error ==1
    for j=1:rx
        figure
        bar3(dif_per(:,:,j));
        title(['Rx', num2str(j)]);
    end
end

y_per= squeeze(mean(mean(dif_per,1),2));
y_abs= squeeze(mean(mean(dif_abs,1),2));
yper_sort=y_per(dist_i)
yabs_sort=y_abs(dist_i)
figure
bar(dist_sort,yabs_sort);
xlabel('Distance(m)');
ylabel('Absolute Error');
title('BAR DISTRIBUTION OF THE ERRORS');
legend(num2str(dist_i));

% 'double2strRx: 1, 2, 3, 4');
%% Capacity 
% for 2 Rx's ( 6 and 10 )

SNRvec_dB = [-20:20];

calcType = 1; % calcType = 1: eigenvalues are NOT used for capacity calculation
              % calcType = 2: eigenvalues are used for capacity calculation
figure
H_RT1 = Hnorm_insite(:,:,1);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT1);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT2 = Hnorm_insite(:,:,2);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT2);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT3 = Hnorm_insite(:,:,3);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT3);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT4 = Hnorm_insite(:,:,4);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT4);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT5 = Hnorm_insite(:,:,5);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT5);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

H_RT6 = Hnorm_insite(:,:,6);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT6);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

% H_RT7 = Hnorm_insite(:,:,7);              
% [C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT7);
% plot(SNRvec_dB,C,'-.*','LineWidth',1)
% hold on

H_RT8 = Hnorm_insite(:,:,8);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_RT8);
plot(SNRvec_dB,C,'-.*','LineWidth',1)
hold on

save('Hfull.mat','H_RT1','H_RT2','H_RT3','H_RT4',...
    'H_RT5','H_RT6','H_RT7','H_RT8')

Csiso = log2(1+10.^(SNRvec_dB/10));             
plot(SNRvec_dB,Csiso,'y','LineWidth',2)

legend('Rx 1','Rx 2','Rx 3','Rx 4',...
    'Rx 5','Rx 6','Rx 7','Rx 8','SISO');
xlabel('SNR (dB)');
ylabel('Spectral Efficiency (bps\Hz)');
% title('CAPACITY OF THE MIMO CHANNEL USING');
saveas(gcf,'CAPACITY OF THE MIMO CHANNEL USING FULL RT SIMULATION WITH DS.png');
savefig('CAPACITY OF THE MIMO CHANNEL USING FULL RT SIMULATION WITH DS.fig');
grid on

%% Narrow 
figure
H_narrow1 = Hnorm(:,:,1);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow1,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow2= Hnorm(:,:,2);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow2,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow3 = Hnorm(:,:,3);              
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow3,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow4= Hnorm(:,:,4);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow4,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow5= Hnorm(:,:,5);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow5,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

H_narrow6= Hnorm(:,:,6);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow6,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)
hold on

% H_narrow7= Hnorm(:,:,7);
% [C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow7,1);
% plot(SNRvec_dB,C,'-.o','LineWidth',1)
% hold on

H_narrow8= Hnorm(:,:,8);
[C] = CvsSNR_Eigenbeamforming(SNRvec_dB,H_narrow8,1);
plot(SNRvec_dB,C,'-.o','LineWidth',1)


save('Hmodel.mat','H_narrow1','H_narrow2','H_narrow3','H_narrow4',...
    'H_narrow5','H_narrow6','H_narrow7','H_narrow8')

Csiso = log2(1+10.^(SNRvec_dB/10));             
plot(SNRvec_dB,Csiso,'y','LineWidth',2)

legend('Rx 1','Rx 2','Rx 3','Rx 4',...
    'Rx 5','Rx 6','Rx 7','Rx 8','SISO');
xlabel('SNR (dB)');
ylabel('Spectral Efficiency (bps\Hz)');
% title('CAPACITY OF THE MIMO CHANNELS');
saveas(gcf,'CAPACITY OF THE MIMO CHANNEL USING SIMPLIFIED RT SIMULATION WITH DS.png');
savefig('CAPACITY OF THE MIMO CHANNEL USING SIMPLIFIED RT SIMULATION WITH DS.fig');
grid on

>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
restoredefaultpath