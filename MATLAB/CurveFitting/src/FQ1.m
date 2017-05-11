function FQ1(Theta1,a,b,c,r,y)
global a b c r y Theta1 ; 
a_Theta1=Theta1;                     %保存Theta1的原始信息
if Theta1>180
   Theta1=360-Theta1;
end
Theta1=deg2rad(Theta1);                 %将角度值换成弧度值
Cm=c^2-a^2;
Bm=2*c*cos(Theta1);
b=1/2*(Bm+(Bm^2-4*Cm)^(1/2));         %得到两个根，一正一负，取正根
C=asin(c*sin(Theta1)/a);
B=pi-C-Theta1;                        %计算结果B,C均为弧度值
Theta1=a_Theta1;                      %Theta1复原为角度值
if Theta1>180
   Theta2=rad2deg(pi+B);
else       
   Theta2=rad2deg(pi-B);               %计算结果Theta2为角度值
end
Pz=b-r(3)*cos(C);        
Px=r(3)*sin(C);    
if Theta1<180
   Px=Px;
else
   Px=-Px;
end
if Px>-0.0005 && Px<0.
   Px=0.;                              %计算和调整Px的值,并消除数据精度要求带来的小BUG
end
y1=[Theta1;Theta2;b;Px;Pz];            %保存每次循环的求解结果
if Theta1==0
    y=[y1];                            %调整全局变量y的数据存储信息
else
    y=[y;y1];                          %累加式存储当前的求解结果数据信息
end