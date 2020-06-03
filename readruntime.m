function [runtime] = readruntime(filename)
fileID = fopen(filename);
C = textscan(fileID,'%s');
A= C{1,1}(end);
formatIn = 'HH:MM:SS.FFF';
data = datevec(A,formatIn);
runtime = [data(4:6)]; % Hour, Minute, Second
end

