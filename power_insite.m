function [power_phase,rx,rx_position] = power_insite(filename_power)
header =7;
fileID = fopen(filename_power);
C = textscan(fileID,'%s');
A=C{1,1}(24:length(C{1,1}),1);
A=str2double(A);
rx=length(A)/header;
vec=[1:header:length(A)];
for i=1:rx
    if i<rx
        B(:,i)=A(vec(i):vec(i+1)-1);
    else
        B(:,i)=A(vec(i):vec(i)+header-1);        
    end
end
B=B';
x_pos= B(:,2);
y_pos= B(:,3);
z_pos= B(:,4);
power_dbm=B(:,6);    % Power(dBm)
phase =B(:,7);       % Phase (deg)

power_phase= [power_dbm phase];
rx_position =[x_pos y_pos z_pos];
fclose('all');
end

