clear all
clc 
%DH = [THETA D A ALPHA SIGMA]
L1 = Link([0,0,0.25,0,0]);
L2 = Link([0,0,0.15,pi,0]);
%设置第三个关节为平移关节（改变sigma值为1），并设置关节限位0-2（移动范围）
L3 = Link([0,0,0,0,1]); L3.qlim = [0 2];
L4 = Link([0,0,0,0,0]);
scara=SerialLink([L1 L2 L3 L4], 'name', 'SCARA');
%scara.plot([0 0 0 0], 'workspace',[-0.31 0.31 -0.31 0.31 -0.31 0.31])   %显示机器人，初始q1至q4都为0
scara.plotopt={'workspace',[-0.5 0.5 -0.5 0.5 -0.5 0.5]};%必须加这个必然无法画图
scara.plot([0 0 0 0])
scara.teach %打开各关节的驱动，用于调节各关节变量值,必须加L3.qlim

%正解
theta=[0 0 0 0];
T01=scara_T(theta(1),0,0.25,0);
T12=scara_T(theta(2),0,0.15,pi);
T23=scara_T(theta(3),0,0,0);
T34=scara_T(theta(4),0,0,0);
T=T01*T12*T23*T34

%逆解
theta=scara_ikine(T);

q1=[176 32.4 0 0]/180*pi;
q1(3)=0;
q2=[15.3 14.4 0.24 0]/180*pi;
q2(3)=0.24;

T1=scara.fkine(q1);
T2=scara.fkine(q2);

TT=ctraj(T1,T2,40);
p=transl(TT);
plot3(p(:,1),p(:,2),p(:,3))
hold on

for i=1:40
    
theta=scara_ikine(TT(:,:,i));

invqq(i,:)=theta(1,:);

end
scara.plot(invqq)
hold on
T3=scara.fkine(invqq);
p3=transl(T3);
plot3(p3(:,1),p3(:,2),p3(:,3))


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0:0.1:2*pi;
x=0.3+0.05*sin(t);
y=0+0.05*cos(t);
plot3(x,y,-0.16*ones(1,length(t)),'linewidth',1.2)
hold on
r=rpy2r(pi,0,0);

for i=1:length(t)

    T=[r,[x(i),y(i),-0.160]'; 0 0 0 1];
    theta=scara_ikine(T);
    invqq(i,:)=theta(1,:);
    
end
scara.plot(invqq)
hold on
T3=scara.fkine(invqq);
p3=transl(T3);
plot3(p3(:,1),p3(:,2),p3(:,3))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p1=[0.1139 0.1357 0.1];
p2=[-0.1489 -0.0960 -0.18];

k=1:2;
ki=linspace(1,2,30);
xi=interp1(k,[p1(1),p2(1)],ki,'linear');
yi=interp1(k,[p1(2),p2(2)],ki,'linear');
zi=interp1(k,[p1(3),p2(3)],ki,'linear');
plot3(xi,yi,zi)

for i=1:30

    TTT=[  0.4258    0.9048    0.0000    xi(i)
           0.9048   -0.4258   -0.0000    yi(i)
           0         0.0000   -1.0000    zi(i)
           0         0         0         1.0000];

       theta=scara_ikine(TTT);
       invqq(i,:)=theta(1,:);

end







