function UnitSpatialSignature = estimate_phasecir(phase_cir, phase_diff,...
    numAntennaElements)
for n =1:numAntennaElements
phase_cir(n) = (n-1)*phase_diff;
if phase_cir(n) > 180
    phase_cir(n) = phase_cir(n) - 360;
else
    continue
end
end
UnitSpatialSignature = (1/sqrt(numAntennaElements))* exp(1j*deg2rad(phase_cir)); %normalize to have unitary norm
UnitSpatialSignature = UnitSpatialSignature(:); %make it a column vector
end

