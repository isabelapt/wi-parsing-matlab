function[angle_new] = correctangles_wi(angle_wi,delta_axis)
angle_new = - delta_axis + angle_wi;
for i = 1:length(angle_new)
if angle_new(i) > 180
    angle_new(i)  = -2*180 - angle_new(i) ;
elseif angle_new(i) < -180
    angle_new(i)  = 2*180 + angle_new(i) ;
end
angle_new = angle_new(:);
end



