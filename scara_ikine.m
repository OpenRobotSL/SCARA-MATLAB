function theta=scara_ikine(T)

 d1=0;
 L1=0.25;
 L2=0.15;
 %d3=0; …ÒÀı¡ø
 px=T(1,4);py=T(2,4);pz=T(3,4);
 nx=T(1,1);ny=T(2,1);
 
 c2=(px^2+py^2-L1^2-L2^2)/(2*L1*L2);
 s2=real(sqrt(1-c2^2));
 q2=atan2(s2,c2);
 
 s1=((L1+L2*c2)*py-L2*s2*px)/(px^2+py^2);
 c1=((L1+L2*c2)*px+L2*s2*py)/(px^2+py^2);
 q1=atan2(s1,c1);
 
 q3=d1-pz;
 
 c4=nx*cos(q1+q2)+ny*sin(q1+q2);
 s4=nx*sin(q1+q2)-ny*cos(q1+q2);
 q4=atan2(s4,c4);
 theta1=[q1 ,q2 ,q3 ,q4];
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 c2=(px^2+py^2-L1^2-L2^2)/(2*L1*L2);
 s2=-real(sqrt(1-c2^2));

 q2=atan2(s2,c2);
 
 s1=((L1+L2*c2)*py-L2*s2*px)/(px^2+py^2);
 c1=((L1+L2*c2)*px+L2*s2*py)/(px^2+py^2);
 q1=atan2(s1,c1);
 
 q3=d1-pz;
 
 c4=nx*cos(q1+q2)+ny*sin(q1+q2);
 s4=nx*sin(q1+q2)-ny*cos(q1+q2);
 q4=atan2(s4,c4);
 
 theta2=[q1 ,q2 ,q3 ,q4];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta=[theta1;theta2];
end