normalizedSpacingTx =0.5; normalizedSpacingRx=0.5;

if total_array_input == 1
    paths_gain = sqrt(powerpaths_W_all./inputpower_W);
else
    paths_gain = sqrt(powerpaths_W_all); % TODO
end
%% FROM SISO SIMULATION %%
phase_cir = deg2rad(phasepaths_deg_all);
complexGains = paths_gain .* exp(-1j*phase_cir);
phase_cp = rad2deg(angle(complexGains));
delay = exp(-1j*2*pi*fo*time_arrival_all);
phase_delay = rad2deg(angle(delay));

% Correct angles to start from the specific ULA axis
for i =1:15
    AoA_az_new(:,i) = correctangles_wi(AoA_az(:,i),delta_axis_rx);
    AoD_az_new(:,i) = correctangles_wi(AoD_az(:,i),delta_axis_tx);
end

AoD_az_new = 180 - abs(AoD_az_new); %% ?????



array_ula_size = 64;
txrx_distance = D(1,:);

%% MODEL
for i=1:15
    H_ULA(:,:,i)=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i));
    
    H_ULA_2(:,:,i)=narrowbandULAsMIMOChannel_v2(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i),array_ula_size,lambda,txrx_distance(i));
end