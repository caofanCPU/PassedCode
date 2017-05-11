function Sanci_Picture(C_,D_x,D_y,D_n,D_L,R)
%ʵ��͹�ֹ��죬���е㣬ɰ��Բ�����꣬���������������нǦȣ���͹����ת(-��)���ͼ�Σ��ٻ�Բ��λ��X���ϵ�ɰ��
% clc;
global C_ D_x D_y D_n D_L R x_c y_c;
A=C_(1,:);
B=C_(2,:);
C=C_(3,:);
D=C_(4,:);
E=C_(5,:);
F=C_(6,:);
G=C_(7,:);
P=C_(8,:);
%���ۻ���������ʱ����d_L��
d_L(1)=0;
for i=2:1:D_n
    d_L(i)=d_L(i-1)+D_L(i);
end         %���forѭ��Ҳ�Ǳ�Ҫ��,����D_n��С
%����֪�е�λ�õ������,�����ۻ�����Ϊ�Ա���ʱ,��͹��ĥɰ��ĥ��̬չ��ͼ
%Ϊ��ͼ׼������
x_c=[];
y_c=[];
dx=[];
dy=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�Եȼ�໡�����͹����������
for i=2:1:D_n         %�Ա���t��[0,d_L(D_n)],��Ҫ��tֵ���з������
    t=d_L(i-1):0.005:d_L(i);
    SL=t-d_L(i-1);
    x_c=[x_c,A(i-1)*SL.^3+B(i-1)*SL.^2+C(i-1)*SL+D(i-1)];
    y_c=[y_c,E(i-1)*SL.^3+F(i-1)*SL.^2+G(i-1)*SL+P(i-1)];
    dx=[dx,3*A(i-1)*SL.^2+2*B(i-1)*SL+C(i-1)];
    dy=[dy,3*E(i-1)*SL.^2+2*F(i-1)*SL+G(i-1)];        %���е㴦��X-Y����������
end     %���forѭ���Ǳ�Ҫ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
xt=x_c;              %������Ϣ1-2���е�ԭ����
yt=y_c;              %����е�����������
save SJ_TuLun.mat x_c y_c;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen('ʵ��͹��������������.txt', 'wt');  
fprintf(fid, '%-8.4f  %-8.4f\n',[ x_c; y_c ]);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ds=sqrt(dx.^2+dy.^2);
% Tt_x=dx./ds;
% Tt_y=dy./ds;         %����е�������������(Tt_x,Tt_y)
% Nt_x=dy./ds;
% Nt_y=-dx/ds;         %����е㷨����������(Nt_x,Nt_y)
Xt=xt+R*dy./ds;        %������Ϣ1-3��ɰ��Բ��ԭ���� 
Yt=yt-R*dx./ds;        %ɰ�ֱ任ǰ��Բ������������(Xt,Yt)
Theta=rad2deg(atan(Yt./Xt));    %������Ϣ1-1�����Ľǡ�O1-O-X=Theta
%��������任ǰ��������Ϣ�ļ�
DATAS=[Theta;xt;yt;Xt;Yt];
fid=fopen('TSDATAS1.txt', 'wt');  
fprintf(fid, 'ԭTheta=%-8.4f    ԭPx_y=(%-8.4f,%8.4f)    ԭ��1=(%-8.4f,%8.4f)\n',DATAS);
fclose(fid);
co=sqrt(Xt.^2+Yt.^2);%ɰ��Բ�����ת���ľ���O1--O,�任��ɰ��Բ������Ϊ��co,0��,R=1
                     %������Ϣ2-3��ɰ��Բ�Ĵ�����
%����任������͹����ת��Theta
Theta=-Theta;    %������Ϣ2-1��͹����ת��-Theta
THETA = rad2deg(Theta);
cos_Theta=Xt./co;
sin_Theta=Yt./co;
xt=x_c.*cos_Theta+y_c.*sin_Theta;
yt=y_c.*cos_Theta-x_c.*sin_Theta;    %������Ϣ2-2���е������
%��������任���������Ϣ�ļ�
%DATAS=[Theta;xt;yt;co];
DATAS=[Theta;cos_Theta;sin_Theta;co]; 
fid=fopen('TSDATAS2.txt', 'wt');  
fprintf(fid, '��Theta=%-8.4f    ��Px_y=(%-8.4f,%8.4f)    �Ρ�1=(%-8.4f,  0.0000)\n',DATAS);
fclose(fid);      
%����ʵ���û�����չ����ֵ�㡢�ҳ������β�����������
Sanci_XY_axis([3.65,0.05,0.05,1.75,3.8,1.9,-2.5,-1.5]);
set(gca,'XTick',-2.5:0.25:4);
set(gca,'XTickLabel',{'-2.50','-2.25','-2.00','-1.75','-1.50','1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00','2.25','2.50','2.75','3.00','3.25','3.50','3.75','4.00'});
set(gca,'YTick',-1.5:0.25:2);
set(gca,'YTickLabel',{'-1.50','-1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00'});
grid on;         %��������
title('���β����������߹���͹�ֹ���չʾ','fontsize',20,'fontweight','bold','fontname','�����п�');
% clc;
disp('�밴�����ȷ��չʾ͹����ֵ��');
pause();
plot(D_x,D_y,'p','markersize',8,'Markerfacecolor','g');
%pause(5);
disp('�밴�����ȷ��չʾ͹����ֵ�����');
pause();
plot(D_x,D_y,'-gp','LineWidth',3);
%pause(5);
disp('�밴�����ȷ��չʾ͹����ֵ������β�����������');
pause();
%��Ҫ����x_c,y_c���ڴ�ռ������
plot(x_c,y_c,'-b','LineWidth',3);      %����͹��
%save TLLK.mat x_c y_c THETA;
% clc;
%pause(5);

save TL_BianLiang;        %͹��ĥ�������������ݱ����洢��mat�ļ���TL_BianLiang��
disp('����Ϊ͹��ĥ������Ķ�̬չʾ');
disp('�밴���������......');
pause();  
%��������͹��ĥɰ��ĥ��̬չ��ͼ
for D_t=1:2:fix(d_L(D_n)/0.005)
    clf     %ÿ�ζ����ǰһ�ε�ͼ��
    Sanci_XY_axis([3.65,0.05,0.05,1.75,3.8,1.9,-2.5,-1.5]);
    set(gca,'XTick',-2.5:0.25:4);
    set(gca,'XTickLabel',{'-2.50','-2.25','-2.00','-1.75','-1.50','1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00','2.25','2.50','2.75','3.00','3.25','3.50','3.75','4.00'});
    set(gca,'YTick',-1.5:0.25:2);
    set(gca,'YTickLabel',{'-1.50','-1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00'});
    grid on;         %��������
    title('͹��ĥ������̬����','fontsize',20,'fontweight','bold','fontname','�����п�');
    D_x1=D_x*cos_Theta(D_t)+D_y*sin_Theta(D_t);
    D_y1=D_y*cos_Theta(D_t)-D_x*sin_Theta(D_t);
    plot(D_x1,D_y1,'p','markersize',18,'Markerfacecolor','g');       %��͹����ֵ��
%     D_x1=D_x*cos_Theta(D_t)+D_y*sin_Theta(D_t);
%     D_y1=D_y*cos_Theta(D_t)-D_x*sin_Theta(D_t);
%     plot(D_x1,D_y1,'-p');      %��͹����ֵ���ҳ�
    %����Ϊ����任����
    x_c1=x_c*cos_Theta(D_t)+y_c*sin_Theta(D_t);
    y_c1=y_c*cos_Theta(D_t)-x_c*sin_Theta(D_t);
    plot(x_c1,y_c1,'-b','LineWidth',3);      %����͹��
    clear x_c1 y_c1;
    x=-0.06:0.01:0.06;
    y=x-x;
    plot(x,y,'-b.');
    clear x y;
    y=-0.06:0.01:0.06;
    x=y-y;
    plot(x,y,'-b.');
    hold on;
    clear x y;                 %����͹�ֻ�ת����Сʮ�� 
    t=0:0.01:2*pi;
    xo=co(D_t)+R*cos(t);
    yo=R*sin(t);
    plot(xo,yo,'-m.','LineWidth',3);          %����ɰ��
    clear t;
    x=(co(D_t)-0.05):0.01:(co(D_t)+0.05);
    y=x-x;
    plot(x,y,'-m.');
    clear x y;
    y=-0.05:0.01:0.05;
    x=y-y+co(D_t);
    plot(x,y,'-m.');
    clear  x y;                %����ɰ��Բ��Сʮ��
    pause(0.001);
end           %���ѭ���Ǳ�Ҫ�� 