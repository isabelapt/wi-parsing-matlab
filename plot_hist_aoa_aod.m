    figure
for i=1:15
    subplot(3,5,i)
    hist(AoA_el(:,i));
end

    figure
for i=1:15
    subplot(3,5,i)
    hist(AoA_az(:,i)) 
end

    figure
for i=1:15
    subplot(3,5,i)
    hist(AoA_az_new(:,i)) 
end

%     figure
% for i=1:15
%     subplot(3,5,i)
%     hist(AoD_el(:,i))    
% end
% 
%     figure
% for i=1:15
% 
%     subplot(3,5,i)
%     hist(AoD_az(:,i))    
% end
