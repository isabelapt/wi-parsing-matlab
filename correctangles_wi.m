function[angle_y] = correctangles_wi(angle_x)
if angle_x <= 90
    angle_y = angle_x;
else        
    angle_y = 180-angle_x;
end
end


