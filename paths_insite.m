function [rx_matrix,path_int,path_info,path_des,path_int_position] = paths_insite(rx,filename_paths,rx_paths,path_max_rx)
% # <number of receiver points>
% # <receiver point number> <number of paths for this point>
% #	rx pt summary:
% #	<received power (dBm)>
% #	<mean time of arrival (sec)>
% #	<delay spread (sec)>
% #		path summary:
% #		<path number>
% #		<total interactions for path> (not including Tx and Rx)
% #		<received power(dBm)>
% #		<phase(deg)>
% #		<time of arrival(sec)>
% #		<arrival theta(deg)>
% #		<arrival phi(deg)>
% #		<departure theta(deg)>
% #		<departure phi(deg)>
% #			interactions summary:
% #			<interaction description> (Tx:transmitter, Rx:receiver, T:transmission, R:reflection, D:diffraction)
% #			<cartesian locations of interactions> (including Tx and Rx)
fileID = fopen(filename_paths);
C = textscan(fileID,'%s');
A=C{1,1}(108:length(C{1,1}),1);

path_int_position(1:path_max_rx,:,1:rx)=0;
path_int(1:path_max_rx,1:rx)=0;
path_info(1:path_max_rx,1:7,1:rx)=0;

% Rx Information
for m=1:rx
    if m==1
        inicio_rx(m)=1;
    else
        inicio_rx(m)=end_v(n)+1;
    end
    if rx_paths(m)~=0
        % Path Information
        for n=1:rx_paths(m)
            B=str2double((A(inicio_rx(m):inicio_rx(m)+4))');
            rx_number(m)=B(1);
            rx_paths(m)= B(2);
            rx_matrix(m,:) = B(1:5);
            if n==1
                inicio_path(n)=inicio_rx(m)+5;
            else
                inicio_path(n)=end_v(n-1)+1;
            end
            D = str2double(A(inicio_path(n):inicio_path(n)+8))';
            path_number(n,m)=D(1);
            path_int(n,m) =D(2);
            path_info(n,:,m)=D(3:9);
            path_des(n,m)= A(inicio_path(n)+9)';
            h(n) = 3*(2+path_int(n,m));
            end_v(n) = inicio_path(n)+h(n)+9;
            path_int_position(n,1:length(str2double(A(inicio_path(n)+10:end_v(n),1))'),m) = str2double(A(inicio_path(n)+10:end_v(n),1))';
        end
    else
        B=str2double((A(inicio_rx(m):inicio_rx(m)+1))');
        rx_number(m)=B(1);
        rx_paths(m)= B(2);
        rx_matrix(m,:) = [B(1:2) zeros(1,3)];
        end_v(n) =end_v(n)+2;
    end
end
end
