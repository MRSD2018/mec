function [jv, jw] = DH_to_Jacobian(DH, jointTypes)
%D-H Table to Jacobian 
%For your variable component, creat a "symbolic variable" 
%To create a symbolic variable, initialize with: "syms theta alpha etc..."
%NOTE: Matlab ocassionally does a shitty job of approximating numbers...
%may need to wround (ex: sin(pi/2) does not always equal 1 in MATLAB!

%Inputs: DH = nx4 table of DH parameters
%        jointTypes = horizontal array of ints: 1 if revolute, 0 if prismatic
%outputs: H = 4x4xn table of homogeneous matrices
%         E = 4x4 ground frame to end effector matrix

    [H, E] = DH_to_Transform(DH);
    jv = zeros(3, size(jointTypes, 2));
    jw = zeros(3, size(jointTypes, 2));
    
    jv = sym('a',3);
    jw = sym('a',3);
    for i = 1:size(jointTypes,2)
        h = eye(4);
        for j = 1:i 
            if (j > 1)
                h = h * H(:,:,i-1);
            end
        end
            
        if jointTypes(i)== 0
            jw(:,i) = [0;0;0];
            jv(:,i) = h(1:3,1:3)* [0;0;1];
        elseif jointTypes(i) == 1
            jw(:,i) = h(1:3,1:3)*[0;0;1];
            on = E*[0;0;0;1];
            oi = h*[0;0;0;1];
            jv(:,i) = cross(h(1:3,1:3)*[0;0;1], (on(1:3) - oi(1:3)));
        end 
    end     
end