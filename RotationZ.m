function Rz = RotationZ(theta)
%Rotation about Z
 Rz = [ cosd(theta) -sind(theta) 0 0; sind(theta) cosd(theta) 0 0;0 0 1 0;0 0 0 1];
end
