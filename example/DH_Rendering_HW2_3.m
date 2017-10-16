syms theta1 d2 theta3;
[H E]= DH_to_Transform([theta1, 10, 0, 0;...
                        0, d2, 9, pi/2;...
                        theta3, 0, 5, 0]);
theta1 = 0;
d2 = 0;
theta3 = 0;
figure(1);
clf(1);
Render_Axes(1,'k', 10);
Render_Transform(1,'g',eye(4),'0',3);
Render_Transform(1,'b',subs(H(:,:,1)),'1',3);
Render_Transform(1,'r',subs(H(:,:,1))*subs(H(:,:,2)),'2',3);
Render_Transform(1,'c',subs(E),'3',3);
axis square;
axis equal;