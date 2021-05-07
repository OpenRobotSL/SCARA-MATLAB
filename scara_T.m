function T=scara_T(theta,d,a,alpha)
T=trotz(theta)*transl(0,0,d)*transl(a,0,0)*trotx(alpha);
end