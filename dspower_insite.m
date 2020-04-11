<<<<<<< HEAD
function [ds_power_insite] = dspower_insite(filename_dspower)
delimiterIn = '\t';
headerlinesIn = 2; % Numero de Linhas para ignorar
A=importdata(filename_dspower,delimiterIn,headerlinesIn);
ds_power_file=A.data(:,:);
end

=======
function [ds_power_insite] = dspower_insite(filename_dspower)
delimiterIn = '\t';
headerlinesIn = 2; % Numero de Linhas para ignorar
A=importdata(filename_dspower,delimiterIn,headerlinesIn);
ds_power_file=A.data(:,:);
end

>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
