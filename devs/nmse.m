function [NMSE] = nmse(Hsiso,Hmimo)
deltaH = (Hmimo - Hsiso);
deltaH_norm = norm(deltaH,'fro');
Hmimo_norm = norm(Hmimo,'fro');
NMSE = deltaH_norm/Hmimo_norm;
end

