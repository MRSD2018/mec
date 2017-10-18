function transformShape()

%%% Set the below variables. By default they're set to Problem 1 on the
%%% practice Exam
% Make a pretty polygon that you can use to debug.
    numOfSides = 3;
    interiorAngle = (numOfSides-2)*180/numOfSides; % Interior angle of the polygon's corners
    lengthOfSides = 3; 
    depthOfPolygon = 4;
% Rotate polygon to align with zero frame
    rotatePolygonX = degtorad(0);
    rotatePolygonY = degtorad(-interiorAngle);
    rotatePolygonZ = degtorad(-90);
% Translate the Coordinate Frame
    xTranslation = 4;
    yTranslation = 3; 
    zTranslation = 0; 
% Rotate the Coordinate Frame   
    xAngle = degtorad(-(180-interiorAngle));
    yAngle = degtorad(180);
    zAngle = degtorad(0);
    
    
% Here are the variables for Question 3 on Problem Set 1
% % Make a pretty polygon that you can use to debug.
%     numOfSides = 6;
%         interiorAngle = (numOfSides-2)*180/numOfSides % Don't change this one. Interior angle of the polygon's corners
%     lengthOfSides = 2*sqrt(3); 
%     depthOfPolygon = 5;
% % Rotate polygon to align with zero frame
%     rotatePolygonX = degtorad(0);
%     rotatePolygonY = degtorad(0);
%     rotatePolygonZ = degtorad(0);
% % Translate the new Coordinate Frame
%     xTranslation = 0;
%     yTranslation = depthOfPolygon; 
%     zTranslation = 2*sin(degtorad(interiorAngle)) * lengthOfSides
% % Rotate the new Coordinate Frame   
%     xAngle = degtorad(90);
%     yAngle = degtorad(0);
%     zAngle = degtorad(-(180-interiorAngle));
    
    
% You shouldn't have to change anything below here
    
    [frame0, d, Rx, Ry, Rz] = createMatrixes(xTranslation,yTranslation,zTranslation,xAngle,yAngle,zAngle);
    
	% Final rotation matrix
    R = [Rx(1:3,1:3)*Ry(1:3,1:3)*Rz(1:3,1:3),[0;0;0];
         0, 0, 0, 1];
    H01 = d*R % Answer, the final transformation matrix
    frame1 = H01*frame0; % The transformed coordinate frame icon
    
    % Show Plot
     plotArea = [-yTranslation, yTranslation+3;
                 -yTranslation, yTranslation+3;
                 -yTranslation, yTranslation+3];
    name = "Transform Shape";
    figure('Name',name)
    hold on;
    plotCoordinateFrame(frame0,name,plotArea,'0');
    plotCoordinateFrame(frame1,name,plotArea,'1');
    plotPolygons(numOfSides, lengthOfSides, depthOfPolygon, rotatePolygonX,rotatePolygonY,rotatePolygonZ)
end

function rotateX = makeXRotationMatrix(angle) 
    rotateX = [ 1,           0,            0, 0;
                0, cos(angle), -sin(angle), 0;
                0, sin(angle),  cos(angle), 0;
                0,            0,            0, 1];
end

function rotateY = makeYRotationMatrix(angle)
    rotateY = [ cos(angle), 0, sin(angle), 0;
                0, 1, 0, 0;
                -sin(angle), 0, cos(angle), 0;
                0, 0, 0, 1];
end

function rotateZ = makeZRotationMatrix(angle)
    rotateZ = [ cos(angle), -sin(angle), 0, 0;
                sin(angle),  cos(angle), 0, 0;
                          0,            0, 1, 0;
                          0,            0, 0, 1];
end

function [frame0, d, Rx, Ry, Rz] = createMatrixes(xTranslation,yTranslation,zTranslation,xAngle,yAngle,zAngle);
    % Rigid body at origin (The red, green, blue coordinate frame icon plotted)
    frame0 = [0, 1, 0, 0, 0, 0;
              0, 0, 0, 1, 0, 0;
              0, 0, 0, 0, 0, 1;
              1, 1, 1, 1, 1, 1];
    % Transformation matrix
    d =  [ 1, 0, 0, xTranslation;
           0, 1, 0, yTranslation;
           0, 0, 1, zTranslation;
           0, 0, 0, 1];
    % Rotation matrices to be multiplied
    Rx = makeXRotationMatrix(xAngle);
    Ry = makeYRotationMatrix(yAngle);
    Rz = makeZRotationMatrix(zAngle);
end
% Displays coordinate frame symbols, plotted as red, green, and blue
% X, Y, Z unit vectors.
% Input: An X, Y, Z coordinate frame icon represented as a 6x4 matrix
% Output: A plot of the coordinate frame icon
function plotCoordinateFrame(H, plotTitle, plotArea,frameNumber)
    for i = 1:2:6
        drawString = '';
        if i <= 2
            drawString = '-r';
            xText = text(H(1,i+1),H(2,i+1),H(3,i+1),strcat('X',frameNumber));
            xText.Color = 'red';

        elseif 2 < i && i <= 4
            drawString = '-g';
            yText = text(H(1,i+1),H(2,i+1),H(3,i+1),strcat('Y',frameNumber));
            yText.Color = 'green';
        elseif 4 < i && i <= 6
            drawString = '-b';
            zText = text(H(1,i+1),H(2,i+1),H(3,i+1),strcat('Z',frameNumber));
            zText.Color = 'blue';
        else
             "Index out of bounds error in plotTransform()"   
        end
        plot3(H(1,i:i+1),H(2,i:i+1),H(3,i:i+1),drawString)
        
    end
    view(45,45);
    axis equal
    axis([plotArea(1,1),plotArea(1,2),plotArea(2,1),plotArea(2,2),plotArea(3,1),plotArea(3,2)]);
    title(plotTitle)
end

function plotPolygons(numOfSides, lengthOfSides, yTranslation, xRotate, yRotate, zRotate)
    interiorAngle = (numOfSides-2)*180/numOfSides; % Interior angle of the polygon's corners
    polygon1 = [;;];
    polygon2 = [;;];
    radiusOfPolygon = lengthOfSides/(2*sin(degtorad(180)/numOfSides));
    apothem = lengthOfSides/(2*tan(degtorad(180)/numOfSides));
     rotatePolygon = 0;
      if  numOfSides == 6 || numOfSides == 10
          rotatePolygon = 0;
      elseif numOfSides == 3 || numOfSides == 5 || numOfSides == 9
          rotatePolygon = degtorad(90);
      else
         rotatePolygon = degtorad(interiorAngle/2);
      end
    
    for i = 1:(numOfSides+1)
        polygon1 = [polygon1, [radiusOfPolygon * cos((2*pi*(1+i)/numOfSides) + rotatePolygon) - lengthOfSides/2;
                               0;
                               radiusOfPolygon * sin((2*pi*(1+i)/numOfSides) + rotatePolygon) + apothem]];
        polygon2 = [polygon2, [radiusOfPolygon * cos((2*pi*(1+i)/numOfSides) + rotatePolygon) - lengthOfSides/2;
                               yTranslation;
                               radiusOfPolygon * sin((2*pi*(1+i)/numOfSides) + rotatePolygon) + apothem]];
                    
    end
    xrot = makehgtform('xrotate',xRotate);
    yrot = makehgtform('yrotate',yRotate);
    zrot = makehgtform('zrotate',zRotate);
    rot = zrot(1:3,1:3)*yrot(1:3,1:3)*xrot(1:3,1:3);
    polygon1 = rot*polygon1;
    polygon2 = rot*polygon2;
    plot3(polygon1(1,:),polygon1(2,:),polygon1(3,:),'-')
    plot3(polygon2(1,:),polygon2(2,:),polygon2(3,:),'-')
end
