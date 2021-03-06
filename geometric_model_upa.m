normalizedSpacingTx =0.5; normalizedSpacingRx=0.5;

if total_array_input == 1
    paths_gain = sqrt(powerpaths_W./inputpower_W);
else
    paths_gain = sqrt(powerpaths_W); % TODO
end
%% FROM SISO SIMULATION %%
phase_cir = deg2rad(phasepaths_deg);
complexGains = paths_gain .* exp(1j*-phase_cir);

% Correct angles to start from the specific ULA axis
AoA_az_new = correctangles_wi(AoA_az,delta_axis_rx);
AoD_az_new = correctangles_wi(AoD_az,delta_axis_tx);

AoD_az_new = 180 - abs(AoD_az_new); %% ?????

%% MODEL
for i=1:numRxpoints
 for i=1:numRxpoints
    H_UPA(:,:,i)=narrowbandUPAsMIMOChannel(numTx1,numTx2,numRx1,numRx2, normalizedSpacingTx,...
        normalizedSpacingRx,AoA_az_new(:,i),AoD_az_new(:,i),AoA_el(:,i),AoD_el(:,i),...
        complexGains(:,i));    
end  
end