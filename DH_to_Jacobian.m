function [jv, jw] = DH_to_Jacobian(DH)
%D-H Table to Jacobian 
%For your variable component, creat a "symbolic variable" 
%To create a symbolic variable, initialize with: "syms theta alpha etc..."
%NOTE: Matlab ocassionally does a shitty job of approximating numbers...
%may need to wround (ex: sin(pi/2) does not always equal 1 in MATLAB!

%Inputs: DH = nx4 table of DH parameters
%        jointTypes = horizontal array of ints: 1 if revolute, 0 if prismatic
%outputs: jv = 3xn linear jacobian
%         jw = 3xn angular jacobian

    [H, E] = DH_to_Transform(DH);

    
    jv = sym('a',[3, size(DH,1)]);
    jw = sym('a',[3, size(DH,1)]);
    for i = 1:size(DH, 1)
        h = eye(4);
        for j = 1:i 
            if (j > 1)
                h = h * H(:,:,i-1);
            end
        end
            
        if isequal(DH(i,1),0)
            jw(:,i) = [0;0;0];
            jv(:,i) = h(1:3,1:3)* [0;0;1];
        elseif ~isequal(DH(i,1),0)
            jw(:,i) = h(1:3,1:3)*[0;0;1];
            on = E*[0;0;0;1];
            oi = h*[0;0;0;1];
            jv(:,i) = cross(h(1:3,1:3)*[0;0;1], (on(1:3) - oi(1:3)));
        end 
    end     
end