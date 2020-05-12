function[angle_y] = correctangles_wi(angle_x)
for i=1:length(angle_x)
    if angle_x(i) > 90
        angle_y(i) = angle_x(i) - 90;
    else
        angle_y(i) = 90 - angle_x(i);       
    end
end
end


