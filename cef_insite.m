function [e_phimag, e_phiphase,e_thetamag, e_thetaphase, ...
     e_xmag,e_xphase,e_ymag,e_yphase,e_zmag,e_zphase,V_path,rx_paths,path_max_rx] =cef_insite(rx,filename_cef)
format long
rx_paths=[];
fileID = fopen(filename_cef);
C = textscan(fileID,'%s');
A=C{1,1}(56:length(C{1,1}),1);
A=str2double(A);
rx_paths(1)= A(2,1);
end_v(1) =rx_paths(1)*11+2;
rx_matrix = zeros(end_v(1),rx);
rx_matrix(:,1)= A(1:end_v(1),1);

for i=2:rx
    rx_paths(i)= A(end_v(i-1)+2,1);
    end_v(i) =(end_v(i-1)+rx_paths(i)*11+2);
    rx_matrix(1:length(A(end_v(i-1)+1:end_v(i),1)),i)= A(end_v(i-1)+1:end_v(i),1);
end

d=ones(length(rx_matrix),1)*11;
for i=1:rx
    a=4;
    for j=1:max(rx_paths)
        e_phimag(j,i) = rx_matrix(a,i); % E_phi mag(V/m)
        e_phiphase(j,i) = rx_matrix(a+1,i);% E_phi phase(deg)
        e_thetamag(j,i) = rx_matrix(a+2,i);% E_theta mag(V/m)
        e_thetaphase(j,i) = rx_matrix(a+3,i);% E_theta phase(deg)
        e_xmag(j,i) = rx_matrix(a+4,i);% E_x mag(V/m)
        e_xphase(j,i) = rx_matrix(a+5,i);% E_x phase(deg)
        e_ymag(j,i) = rx_matrix(a+6,i);% E_y mag(V/m)
        e_yphase(j,i) = rx_matrix(a+7,i);% E_y phase(deg)
        e_zmag(j,i) = rx_matrix(a+8,i);% E_z mag(V/m)
        e_zphase(j,i) = rx_matrix(a+9,i);% E_z phase(deg)
        a=a+d(j);
    end
end
path_max_rx = max(rx_paths);

[Xcart_phi,Ycart_phi] = pol2cart(deg2rad(e_phiphase),e_phimag);
[Xcart_theta,Ycart_theta] = pol2cart(deg2rad(e_thetaphase),e_thetamag);

V_path =  (Xcart_phi + Xcart_theta + 1j*(Ycart_phi+Ycart_theta));
end

