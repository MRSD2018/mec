%Render Vector
%Displays a vector at the specified position and direction
function Render_Transform(plot, color, Origin, Dir, letter, scale) 
  UnitDir = Dir./norm(Dir);
  OrthDirection = [0;0;1]-UnitDir*dot(UnitDir, [0;0;1]);
  if norm(OrthDirection) == 0
    UnitOrth = [1;0;0];
  else
    UnitOrth = OrthDirection./norm(OrthDirection);
  end
  PerpOrth = cross(UnitDir, UnitOrth);
  UnitDir = UnitDir*scale;
  PerpOrth = PerpOrth*scale;
  UnitOrth = UnitOrth*scale;
  Points = [Origin, Origin + Dir];
  FillPoints = [Origin + Dir, Origin + Dir - 0.2*UnitDir+0.07*UnitOrth, ... 
                 Origin + Dir - 0.2*UnitDir - 0.07*UnitOrth, Origin + Dir];
  FillPoints2 = [Origin + Dir, Origin + Dir - 0.2*UnitDir+0.07*PerpOrth, ... 
               Origin + Dir - 0.2*UnitDir-0.07*PerpOrth, Origin + Dir];
  figure(plot);
  hold on;
  h = plot3(Points(1,:), Points(2,:), Points(3,:), color);
  set(h(1),'linewidth',2);
  fill3(FillPoints(1,:), FillPoints(2,:), FillPoints(3,:), color);
  fill3(FillPoints2(1,:), FillPoints2(2,:), FillPoints2(3,:), color);
  hold off;
  Render_Letter(plot, color, Origin + Dir - 0.2*UnitDir + 0.2*PerpOrth, letter) 
end