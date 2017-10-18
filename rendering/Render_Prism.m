%Render Prism
%Displays lines for a prism.
%Face is the points to be rendered as an array of R3
%Depth Vector is a vector to extrude the face by
function Render_Prism(plot, color, Face, DepthVector) 
  faceSize = length(Face(1,:));
  Face(:,faceSize+1)=Face(:,1);
  backFace = Face+DepthVector;
  figure(plot);
  hold on;
  plot3(Face(1,:), Face(2,:), Face(3,:), color);
  plot3(backFace(1,:), backFace(2,:), backFace(3,:), color);
  for i=1:faceSize
     plot3([Face(1,i),Face(1,i)+DepthVector(1)], ...
           [Face(2,i),Face(2,i)+DepthVector(2)], ...
           [Face(3,i),Face(3,i)+DepthVector(3)], color);
  end
  hold off;
end