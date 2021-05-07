clear all;
clc;
%        theta    d           a-1        alpha-1    phi,0转动1移动
L(1)=Link([0       0     0          0           0          ],'modified'); 
L(2)=Link([0       0     0.25          0         0     ],'modified');
L(3)=Link([0       0     0.15     pi           1         ],'modified');
L(4)=Link([0       0     0        0            0        ],'modified');
                 
scara=SerialLink(L, 'name', 'SCARA');L(3).qlim = [0 0.5];
%scara.plot([0 0 0 0], 'workspace',[-0.31 0.31 -0.31 0.31 -0.31 0.31])   %显示机器人，初始q1至q4都为0
scara.plotopt={'workspace',[-0.5 0.5 -0.5 0.5 -0.5 0.5]};%必须加这个必然无法画图
scara.plot([0 0 0 0])
scara.teach %打开各关节的驱动，用于调节各关节变量值,必须加L3.qlim
T=scara.fkine([0,0,0,0])

%正解
a1=[0 0 pi 0];
l=[0 0.25 0.15 0];
A=zeros(4);
T=eye(4);
A(4,4)=1;

G=[-33.2/180*pi 96.1/180*pi 0 62.9/180*pi];%q1 q2 q4
d=[0 0 0.16 0];%d(3)

for i=1:4
    c=cos(G(1,i));
    s=sin(G(1,i));
    ca=cos(a1(i));
    sa=sin(a1(i));
    A(1,1)=c;A(1,2)=-s;A(1,4)=l(i);
    A(2,1)=s*ca;A(2,2)=c*ca;A(2,3)=-sa;A(2,4)=-sa*d(i);
    A(3,1)=s*sa;A(3,2)=c*sa;A(3,3)=ca;A(3,4)=ca*d(i);
    T=T*A;
end
T
theta=nijie(T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=0:0.1:2*pi;
x=0.3+0.08*sin(t);
y=0+0.08*cos(t);
plot3(x,y,-0.16*ones(1,length(t)),'linewidth',1.2)
hold on
r=rpy2r(pi,0,0);

for i=1:length(t)

    T=[r,[x(i),y(i),-0.160]'; 0 0 0 1];
    theta=nijie(T);
    invqq(i,:)=theta(1,:);
    
end
scara.plot(invqq)
hold on
T3=scara.fkine(invqq);
p3=transl(T3);
plot3(p3(:,1),p3(:,2),p3(:,3))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%