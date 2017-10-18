%D-H Table to Transformation Matrix 
%For your variable component, creat a "symbolic variable" 
%To create a symbolic variable, initialize with: "syms theta alpha etc..."
%NOTE: Matlab ocassionally does a shitty job of approximating numbers...
%may need to wround (ex: sin(pi/2) does not always equal 1 in MATLAB!

%Inputs: nx4 table of DH parameters
%outputs: H = 4x4xn table of homogeneous matrices
%         E = 4x4 ground frame to end effector matrix

function [H, E]= DH_to_Transform(DH) 
E=eye(4);

for i=1:size(DH,1)
    theta = DH(i,1);
    d  = DH(i,2);
    a = DH(i,3);
    alpha = DH(i,4);
H (:,:,i) = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), a*cos(theta);
    sin(theta), cos(theta)*round(cos(alpha)), -cos(theta)*round(sin(alpha)), a*sin(theta);
    0, round(sin(alpha)), round(cos(alpha)), d;
    0, 0, 0, 1];
    E=E*H(:,:,i);
end

end
