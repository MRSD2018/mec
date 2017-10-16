%Render Transformation Matrix
%Displays a unit vector at the matrix transform position.
function Render_Transform(plot, color, H, frameNum, scale) 
  Render_Unit_Vector(plot, color, H(1:3,4), H(1:3,1), strcat('X',frameNum), scale);
  Render_Unit_Vector(plot, color, H(1:3,4), H(1:3,2), strcat('Y',frameNum), scale);
  Render_Unit_Vector(plot, color, H(1:3,4), H(1:3,3), strcat('Z',frameNum), scale);
end