function [phasepaths_deg_all_2] = selectpaths(nRx,nPaths,path_des,phasepaths_deg_all_2)
for i=1:nRx
    for j=1:nPaths
        c = contains(path_des{j,i},'D');
        if c == 1
            phasepaths_deg_all_2(j,i) = NaN;
        end
    end
end
end

