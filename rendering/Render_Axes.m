%Render plot axes
%Displays a vector at the origin scaled by a factor.
function Render_Axes(plot, color, scale) 
  Render_Vector(plot, color, [0;0;0], [scale;0;0], 'X', scale/2);
  Render_Vector(plot, color, [0;0;0], [0;scale;0], 'Y', scale/2);
  Render_Vector(plot, color, [0;0;0], [0;0;scale], 'Z', scale/2);
end