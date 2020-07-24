for i =1:numRxpoints
    for j = 1:rx_paths(i)
a= powerpaths_W_all(j,i);
powerpaths_W_all_2(j,i) = a(~isnan(a));
b = phasepaths_deg_all(j,i);
phasepaths_deg_all_2(j,i) = b(~isnan(b));
    end
end

if total_array_input == 1
    paths_gain = sqrt(powerpaths_W_all_2./inputpower_W);
else
    paths_gain = sqrt(powerpaths_W_all_2); % TODO
end


% Ignore Paths With Diffraction % 
% [c] = selectpaths(numRxpoints,path_max_rx, path_des,phasepaths_deg_all_2);
% 
% for i =1:numRxpoints
%     d = c(:,i);
%     paths_gain_woD(:,i) = d(~isnan(d));
%     phasepaths_deg_all_woD(:,i) = d(~isnan(d));
%     AoA_az(:,i) = d(~isnan(d));
%     AoA_el(:,i) = d(~isnan(d));
%     AoD_az(:,i) = d(~isnan(d));
%     AoD_el(:,i) = d(~isnan(d));
% end

%% FROM SISO SIMULATION %%
phase_cir = deg2rad(phasepaths_deg_all_2);
complexGains = paths_gain .* exp(-1j*phase_cir);
phase_cp = rad2deg(angle(complexGains));


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
    [H_ULA(:,:,i)]=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i));
    
    [H_ULA_2(:,:,i)]=narrowbandULAsMIMOChannel_v2(numTx,numRx,normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i),array_ula_size,lambda,txrx_distance(i));
end