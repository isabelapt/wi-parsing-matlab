function H=narrowbandULAsMIMOChannel(numTx,numRx,normalizedSpacingTx,...
    normalizedSpacingRx,AoA_az,AoD_az,AoA_el,AoD_el,complexGains)
%Using information from each ray (that can be obtained from the
%complex impulse response and path file generated by InSite, NYUSIM, etc.),
%compute the H matrix using the geometric channel model.
%All angles are in radian and gains in Watts in linear scale (not dB).
%Assumes ULA. The elevation angles are not taken in account.
%As in Tse's book, the AoA and AoD are between the ray and the line
%formed by the ULA (not with its normal).
%Normalized spacing is the distance among antenna elements divided by the
%wavelength.
%delta_axis is the angle difference among x axis and ula axis
%General case which includes elevation angle 
%"Directional Beamforming for Millimeter-WaveMIMO Systems"  
%cos(azimuth) ---> sin(elevation)cos(azimuth)
%See 6.6 from Antenna Theory Analysis and Design - Balanis 
%Wireless InSite: Azimuth[-pi,pi] Elevation[0,pi]

L=length(complexGains); % number of rays

% Array factor for ULA at XY plane
SteeringVectorRx= sin(deg2rad(AoA_el)).*cos(deg2rad(AoA_az));
SteeringVectorTx= sin(deg2rad(AoD_el)).*cos(deg2rad(AoD_az));

H=zeros(numRx,numTx); %initialize
for thisPath=1:L  
    txsignature=unitSpatialSignature(SteeringVectorTx(thisPath),normalizedSpacingTx,numTx);
    rxsignature=unitSpatialSignature(SteeringVectorRx(thisPath),normalizedSpacingRx,numRx);    
    %Eq. (7.56) in Tse's book but not incorporating the phase
    %Note the Hermitian operator ' changes the signs of angles in Tx
    newH(:,:,thisPath)=sqrt(numRx*numTx)*complexGains(thisPath)*(rxsignature*txsignature');
    H= H + newH(:,:,thisPath);    
    %There is only one non-zero SVD for a single ray, and two for
    %properly spaced two rays
    %[~,singularValues,~]=svd(H);
    %diag(singularValues)
end
end