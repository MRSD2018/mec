%Examples from the sample midterm

%Problem 1: Show the transformation
H0=RotationX(-60)*RotationZ(180); %{0} expressed in the globab frame
H01=Trans(4,3,0)*RotationX(60)*RotationZ(180) %{1} expressed in {1}
H1=H0*H01; %{1} expressed in global frame
figure(1);
clf(1);
Render_Axes(1, 'k', 2); %Axes rendered in global frame
Render_Prism(1,'c',transpose([0,0,0;0,-3,0;0,-1.5,sqrt(3^2-1.5^2)])...
    ,[-4;0;0]); % triangular prism rendered in global frame
Render_Transform(1, 'r', H0, '0', 1); % {0} in global frame
Render_Transform(1, 'b', H1, '1', 1); % {1} in global frame
axis square;
axis equal;

%Problem 2: Analytical problem, no good way to show solution

%Problem 3: Test the DH table you create
syms theta1 theta2 d3 theta4;
[H E]= DH_to_Transform([theta1, 85, 0, pi/2;...
                        theta2, 0, 27, -pi/2;...
                        0, 19+d3, 35, pi/2;...
                        theta4, 0, 29, -pi/2]);
theta1 = 0;
theta2 = 0;
d3 = 0;
theta4 = 0;
figure(2);
clf(2);
Render_Axes(2,'k', 30);
Render_Transform(2,'g',eye(4),'0',10);
Render_Transform(2,'b',subs(H(:,:,1)),'1',10);
Render_Transform(2,'r',subs(H(:,:,1))*subs(H(:,:,2)),'2',10);
Render_Transform(2,'g',subs(H(:,:,1))*subs(H(:,:,2))*subs(H(:,:,3)),'3',10);
Render_Transform(2,'c',subs(E),'4',10);
axis square;
axis equal;

%Problem 4: Test the DH table you create
syms th1 d2 th3 l1 l2;
[jv, jw] = DH_to_Jacobian([th1, 10, l1, 0;...
                        0, d2, 0, pi/2;...
                        th3, 0, l2, -pi/2]);
jv
jw
               