function [angle] = correct_diffphase_element(AoA,array_ula_size,...
    normalizedSpacing,lambda,d_1)

aa_size = [2:array_ula_size]';
% Law of cosines
for n_d = 1:array_ula_size-1
    d_calc(:,n_d) = sqrt(d_1^2+((aa_size(n_d)-1).*normalizedSpacing.*lambda).^2 - ...
        2.*d_1.*(aa_size(n_d)-1).*normalizedSpacing.*lambda.*cosd(AoA));
    
%     d_approx(:,n_d) = d_1 + (aa_size(n_d)-1).*normalizedSpacing.*lambda.*cos(AoA);
    
    cos_phi_int(:,n_d) = (((aa_size(n_d)-1).*normalizedSpacing.*lambda).^2 + d_calc(:,n_d).^2 - d_1^2 )./...
        (2*(aa_size(n_d)-1).*normalizedSpacing.*lambda.*d_calc(:,n_d));
end

%Adjust the calculated angles to have the same signal as the original AoA
if (AoA >= 0) && (AoA <= 180)
    AoA_calc_deg = acosd(cos_phi_int);
elseif (AoA <= 0) && (AoA >= -180)
    AoA_calc_deg = -acosd(cos_phi_int);
end

angle = [deg2rad(AoA) deg2rad(AoA_calc_deg)]; 
end

