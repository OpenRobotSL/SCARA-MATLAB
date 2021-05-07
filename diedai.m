t=0:0.01:2*pi;
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

qq=invqq;