%D-H Table to Transformation Matrix 
%For your variable component, creat a "symbolic variable" 
%To create a symbolic variable, initialize with: "syms theta alpha etc..."
%NOTE: Matlab ocassionally does a shitty job of approximating numbers...
%may need to wround (ex: sin(pi/2) does not always equal 1 in MATLAB!
function H = DH_to_Transform(theta, d, a, alpha) 

H = [cos(theta), -sin(theta)*cos(alpha), sin(theta)*sin(alpha), a*cos(theta);
    sin(theta), cos(theta)*round(cos(alpha)), -cos(theta)*round(sin(alpha)), a*sin(theta);
    0, round(sin(alpha)), round(cos(alpha)), d;
    0, 0, 0, 1];
end