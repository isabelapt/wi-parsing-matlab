<<<<<<< HEAD
function [ output_args ] = paths_interactions(rx,filename)
delimiterIn = ' ';
headerlinesIn = 19; % Numero de Linhas para ignorar
A=importdata(filename,delimiterIn,headerlinesIn);
k=1;

rx_paths= zeros(1,rx);
rx_paths(1)= A.data(1,2);
rx_interaction(1)= A.data(1,8);

headerlinesIn = 3; % Numero de Linhas para ignorar
A=importdata(filename,delimiterIn,headerlinesIn);

for i=1:rx % Numero de pontos receptores
    for j=1:rx_paths(i)
        arrival_phi(j,i)=A.data(k,2);  
        arrival_theta(j,i)=A.data(k,3); 
        k=k+1;
    end
    if k >length(A.data)
        break
    end
    rx_paths(i+1)= A.data(k,2);
    k=k+1;
end
end

=======
function [ output_args ] = paths_interactions(rx,filename)
delimiterIn = ' ';
headerlinesIn = 19; % Numero de Linhas para ignorar
A=importdata(filename,delimiterIn,headerlinesIn);
k=1;

rx_paths= zeros(1,rx);
rx_paths(1)= A.data(1,2);
rx_interaction(1)= A.data(1,8);

headerlinesIn = 3; % Numero de Linhas para ignorar
A=importdata(filename,delimiterIn,headerlinesIn);

for i=1:rx % Numero de pontos receptores
    for j=1:rx_paths(i)
        arrival_phi(j,i)=A.data(k,2);  
        arrival_theta(j,i)=A.data(k,3); 
        k=k+1;
    end
    if k >length(A.data)
        break
    end
    rx_paths(i+1)= A.data(k,2);
    k=k+1;
end
end

>>>>>>> c3970b7ade8c41edae3c2d31b4de015a4f85b8ec
