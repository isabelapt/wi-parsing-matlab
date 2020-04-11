function [pl_db_insite] = pldb_insite(filename_pl)
header =6;
fileID = fopen(filename_pl);
C = textscan(fileID,'%s');
A=C{1,1}(22:length(C{1,1}),1);
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
pl_db_insite=B(:,6);
fclose('all');
end

