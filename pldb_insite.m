function [pl_db_insite] = pldb_insite(filename_pl)
col =6;
fileID = fopen(filename_pl);
C = textscan(fileID,'%s');
A=C{1,1}(23:length(C{1,1}),1);
A=str2double(A);
rx=length(A)/col;
vec=[1:col:length(A)];
for i=1:rx
    if i<rx
        B(:,i)=A(vec(i):vec(i+1)-1);
    else
        B(:,i)=A(vec(i):vec(i)+col-1);        
    end
end
B=B';
pl_db_insite=B(:,6);
end

