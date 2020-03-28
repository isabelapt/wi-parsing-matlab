% Equation 21.2
clear,clc;
fo = 2* 10^9;
lambda =3*10 ^8/ fo;
no = 377;
path_results="C:\Users\isabe\OneDrive\Documentos\LASSE\CellFree_Modelling\Projects\cellfreebig\studyarea\";

UE = 1;
rx=100;
beta = 1;

C = (lambda^2 * beta )/(8*pi*no);

for i = 1:1
    if i>=10
        filename_cir = strcat(path_results,'cellfreebig','.cir.t0',num2str(i),'_22','.r021','.p2m');
        filename_cef = strcat(path_results,'cellfreebig','.cef.t0',num2str(i),'_22','.r021','.p2m');
        filename_power =strcat(path_results,'cellfreebig','.power.t0',num2str(i),'_22','.r021','.p2m');
    else
        filename_cir = strcat(path_results,'cellfreebig','.cir.t00',num2str(i),'_22','.r021','.p2m');
        filename_cef = strcat(path_results,'cellfreebig','.cef.t00',num2str(i),'_22','.r021','.p2m');
        filename_power = strcat(path_results,'cellfreebig','.power.t00',num2str(i),'_22','.r021','.p2m');
    end
    
    [power_phase,rx,rx_position] = power_insite(filename_power);
    gaindB(1:length(power_phase),i,:)= power_phase(:,1);
    power_W = 10.^((power_phase(:,1) - 30 ) ./ 10);
    phase = power_phase(:,2);
    complexGain(1:length(power_W),:,i) = power_W .* exp(1j * deg2rad(phase));
    
    [time_arrival,powerpaths_dbm,powerphase_deg,rx_paths,path_max_rx] =cir_insite(rx,filename_cir);
    powerpaths_W = 10.^((powerpaths_dbm - 30 ) ./ 10);
    
    %% Compare power from insite and calculated
    powerpaths_W(powerpaths_W == 0.001) = 0;
    
    time_arrival_total(1:path_max_rx,1:rx,i) = time_arrival;
    rx_paths_total(i,1:rx) = rx_paths;
    
    [rx_W,rx_phase] =  comparison_power_paths(powerpaths_W,powerphase_deg);
  
%     [e_phimag, e_phiphase,e_thetamag, e_thetaphase, ...
%         e_xmag,e_xphase,e_ymag,e_yphase,e_zmag,e_zphase,rx_paths,path_max_rx] =cef_insite(rx,filename_cef);
%     
    
    
    
end