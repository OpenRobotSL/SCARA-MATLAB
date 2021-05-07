
function theta=nijie(T)

l1=0.25;
l2=0.15;
nx=T(1,1);
ny=T(2,1);
nz=T(3,1);
ox=T(1,2);
oy=T(2,2);
oz=T(3,2);
ax=T(1,3);
ay=T(2,3);
az=T(3,3);
px=T(1,4);
py=T(2,4);
pz=T(3,4);
angle=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
r=sqrt(px^2+py^2);        
A=(l1^2-l2^2+px^2+py^2)/(2*l1*r);
fi=atan2(px,py);
q1=atan2(A,sqrt(1-A^2))-fi;
q2=atan2(r*cos(q1+fi),r*sin(q1+fi)-l1);
d3=-pz;
q4=-atan2(-sin(q1)*nx+cos(q1)*ny,cos(q1)*nx+sin(q1)*ny)+q2;
  theta1=[q1,q2,d3,q4];
%%%%%%%%%%%%%%%%%        
r=sqrt(px^2+py^2);        
A=(l1^2-l2^2+px^2+py^2)/(2*l1*r);
fi=atan2(px,py);
q1=atan2(A,-sqrt(1-A^2))-fi;
q2=atan2(r*cos(q1+fi),r*sin(q1+fi)-l1);
d3=-pz;
q4=-atan2(-sin(q1)*nx+cos(q1)*ny,cos(q1)*nx+sin(q1)*ny)+q2;             
 theta2=[q1,q2,d3,q4];
%%%%%%%%%%%%%%%%%%%%%%%%%%%
 theta=[theta1;theta2];
 
end