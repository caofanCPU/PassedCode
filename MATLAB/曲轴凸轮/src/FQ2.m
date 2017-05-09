function FQ2(Theta2,Theta1,a,b,c,r,s)
global a b c r s Theta2 Theta1;
a_Theta2=Theta2;                      
Theta2=deg2rad(Theta2);               %将角度值换成弧度值
if Theta2>pi
   B=Theta2-pi;
else
   B=pi-Theta2;
end
b=sqrt(a^2+c^2-2*a*c*cos(B));       %得到两个根，一正一负，取正根
C=asin(c*sin(B)/b);                 %C角为锐角,A角不确定
A=pi-B-C;                           %计算结果B,C均为弧度值
Pz=b-r(3)*cos(C);
Px=r(3)*sin(C);
Theta2=a_Theta2;                    %Theta2复原为角度值
if Theta2>180
   Theta1=360-rad2deg(A);
   Px=-Px;
else
   Theta1=abs(rad2deg(A));
   %Px=Px;
end
if Px>-0.0005 && Px<0.
   Px=0.;
end
s1=[Theta1;Theta2;b;Px;Pz];
if Theta2==0
    s=[s1];
else
    s=[s;s1];
end