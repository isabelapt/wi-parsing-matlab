<<<<<<< HEAD
function [delayspread_insite] = ds_insite(filename_spread)
col =6;
fileID = fopen(filename_spread);
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
delayspread_insite=B(:,6);
end

=======
function [delayspread_insite] = ds_insite(filename_spread)
col =6;
fileID = fopen(filename_spread);
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
delayspread_insite=B(:,6);
end

>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
