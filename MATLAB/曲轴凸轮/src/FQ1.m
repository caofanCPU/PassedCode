function FQ1(Theta1,a,b,c,r,y)
global a b c r y Theta1 ; 
a_Theta1=Theta1;                     %����Theta1��ԭʼ��Ϣ
if Theta1>180
   Theta1=360-Theta1;
end
Theta1=deg2rad(Theta1);                 %���Ƕ�ֵ���ɻ���ֵ
Cm=c^2-a^2;
Bm=2*c*cos(Theta1);
b=1/2*(Bm+(Bm^2-4*Cm)^(1/2));         %�õ���������һ��һ����ȡ����
C=asin(c*sin(Theta1)/a);
B=pi-C-Theta1;                        %������B,C��Ϊ����ֵ
Theta1=a_Theta1;                      %Theta1��ԭΪ�Ƕ�ֵ
if Theta1>180
   Theta2=rad2deg(pi+B);
else       
   Theta2=rad2deg(pi-B);               %������Theta2Ϊ�Ƕ�ֵ
end
Pz=b-r(3)*cos(C);        
Px=r(3)*sin(C);    
if Theta1<180
   Px=Px;
else
   Px=-Px;
end
if Px>-0.0005 && Px<0.
   Px=0.;                              %����͵���Px��ֵ,���������ݾ���Ҫ�������СBUG
end
y1=[Theta1;Theta2;b;Px;Pz];            %����ÿ��ѭ���������
if Theta1==0
    y=[y1];                            %����ȫ�ֱ���y�����ݴ洢��Ϣ
else
    y=[y;y1];                          %�ۼ�ʽ�洢��ǰ�������������Ϣ
end