for i =1:numRxpoints
a= powerpaths_W_all(:,i);
powerpaths_W_all_2(:,i) = a(~isnan(a));
b = phasepaths_deg_all(:,i);
phasepaths_deg_all_2(:,i) = b(~isnan(b));
end

if total_array_input == 1
    paths_gain = sqrt(powerpaths_W_all_2./inputpower_W);
else
    paths_gain = sqrt(powerpaths_W_all_2); % TODO
end
%% FROM SISO SIMULATION %%
phase_cir = deg2rad(phasepaths_deg_all_2);
complexGains = paths_gain .* exp(-1j*phase_cir);
phase_cp = rad2deg(angle(complexGains));
delay = exp(-1j*2*pi*fo*time_arrival_all);
phase_delay = rad2deg(angle(delay));


% Correct angles to start from the specific ULA axis
for i = 1:numRxpoints
    AoA_az_new(:,i) = correctangles_wi(AoA_az(:,i),0);
    AoD_az_new(:,i) = correctangles_wi(AoD_az(:,i),0);
end

AoD_az_new = 180 - abs(AoD_az_new); %% ?????

array_ula_size = 64;
txrx_distance = D(1,:);

%% MODEL
for i=1:numRxpoints
    H_ULA(:,:,i)=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i));
    
    H_ULA_2(:,:,i)=narrowbandULAsMIMOChannel_v2(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i),array_ula_size,lambda,txrx_distance(i));
end