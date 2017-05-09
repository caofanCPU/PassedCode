function Sanci_Picture(C_,D_x,D_y,D_n,D_L,R)
%实现凸轮构造，求切点，砂轮圆心坐标，连心向量，求连切角θ，画凸轮旋转(-θ)后的图形，再画圆心位于X轴上的砂轮
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
%求累积弧长，临时放在d_L中
d_L(1)=0;
for i=2:1:D_n
    d_L(i)=d_L(i-1)+D_L(i);
end         %这个for循环也是必要的,除非D_n较小
%在已知切点位置的情况下,即以累积弧长为自变量时,画凸轮磨砂轮磨动态展现图
%为画图准备数据
x_c=[];
y_c=[];
dx=[];
dy=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%以等间距弧长求解凸轮轮廓曲线
for i=2:1:D_n         %自变量t∈[0,d_L(D_n)],需要对t值进行分类鉴别
    t=d_L(i-1):0.005:d_L(i);
    SL=t-d_L(i-1);
    x_c=[x_c,A(i-1)*SL.^3+B(i-1)*SL.^2+C(i-1)*SL+D(i-1)];
    y_c=[y_c,E(i-1)*SL.^3+F(i-1)*SL.^2+G(i-1)*SL+P(i-1)];
    dx=[dx,3*A(i-1)*SL.^2+2*B(i-1)*SL+C(i-1)];
    dy=[dy,3*E(i-1)*SL.^2+2*F(i-1)*SL+G(i-1)];        %在切点处的X-Y导数行向量
end     %这个for循环是必要的
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
xt=x_c;              %数据信息1-2：切点原坐标
yt=y_c;              %求出切点坐标行向量
save SJ_TuLun.mat x_c y_c;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fid=fopen('实际凸轮轮廓曲线坐标.txt', 'wt');  
fprintf(fid, '%-8.4f  %-8.4f\n',[ x_c; y_c ]);
fclose(fid);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ds=sqrt(dx.^2+dy.^2);
% Tt_x=dx./ds;
% Tt_y=dy./ds;         %求出切点切向量行向量(Tt_x,Tt_y)
% Nt_x=dy./ds;
% Nt_y=-dx/ds;         %求出切点法向量行向量(Nt_x,Nt_y)
Xt=xt+R*dy./ds;        %数据信息1-3：砂轮圆心原坐标 
Yt=yt-R*dx./ds;        %砂轮变换前的圆心坐标行向量(Xt,Yt)
Theta=rad2deg(atan(Yt./Xt));    %数据信息1-1：轴心角∠O1-O-X=Theta
%保存坐标变换前的数据信息文件
DATAS=[Theta;xt;yt;Xt;Yt];
fid=fopen('TSDATAS1.txt', 'wt');  
fprintf(fid, '原Theta=%-8.4f    原Px_y=(%-8.4f,%8.4f)    原○1=(%-8.4f,%8.4f)\n',DATAS);
fclose(fid);
co=sqrt(Xt.^2+Yt.^2);%砂轮圆心与回转中心距离O1--O,变换后砂轮圆心坐标为（co,0）,R=1
                     %数据信息2-3：砂轮圆心次坐标
%坐标变换条件：凸轮旋转角Theta
Theta=-Theta;    %数据信息2-1：凸轮旋转角-Theta
THETA = rad2deg(Theta);
cos_Theta=Xt./co;
sin_Theta=Yt./co;
xt=x_c.*cos_Theta+y_c.*sin_Theta;
yt=y_c.*cos_Theta-x_c.*sin_Theta;    %数据信息2-2：切点次坐标
%保存坐标变换后的数据信息文件
%DATAS=[Theta;xt;yt;co];
DATAS=[Theta;cos_Theta;sin_Theta;co]; 
fid=fopen('TSDATAS2.txt', 'wt');  
fprintf(fid, '次Theta=%-8.4f    次Px_y=(%-8.4f,%8.4f)    次○1=(%-8.4f,  0.0000)\n',DATAS);
fclose(fid);      
%下面实现用户控制展现型值点、弦长、三次参数样条曲线
Sanci_XY_axis([3.65,0.05,0.05,1.75,3.8,1.9,-2.5,-1.5]);
set(gca,'XTick',-2.5:0.25:4);
set(gca,'XTickLabel',{'-2.50','-2.25','-2.00','-1.75','-1.50','1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00','2.25','2.50','2.75','3.00','3.25','3.50','3.75','4.00'});
set(gca,'YTick',-1.5:0.25:2);
set(gca,'YTickLabel',{'-1.50','-1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00'});
grid on;         %画网格线
title('三次参数样条曲线构造凸轮过程展示','fontsize',20,'fontweight','bold','fontname','华文行楷');
% clc;
disp('请按任意键确认展示凸轮型值点');
pause();
plot(D_x,D_y,'p','markersize',8,'Markerfacecolor','g');
%pause(5);
disp('请按任意键确认展示凸轮型值点的弦');
pause();
plot(D_x,D_y,'-gp','LineWidth',3);
%pause(5);
disp('请按任意键确认展示凸轮型值点的三次参数样条曲线');
pause();
%主要变量x_c,y_c在内存空间的数据
plot(x_c,y_c,'-b','LineWidth',3);      %画好凸轮
%save TLLK.mat x_c y_c THETA;
% clc;
%pause(5);

save TL_BianLiang;        %凸轮磨削任务所有数据变量存储在mat文件“TL_BianLiang”
disp('下面为凸轮磨削任务的动态展示');
disp('请按任意键继续......');
pause();  
%下面来画凸轮磨砂轮磨动态展现图
for D_t=1:2:fix(d_L(D_n)/0.005)
    clf     %每次都清除前一次的图像
    Sanci_XY_axis([3.65,0.05,0.05,1.75,3.8,1.9,-2.5,-1.5]);
    set(gca,'XTick',-2.5:0.25:4);
    set(gca,'XTickLabel',{'-2.50','-2.25','-2.00','-1.75','-1.50','1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00','2.25','2.50','2.75','3.00','3.25','3.50','3.75','4.00'});
    set(gca,'YTick',-1.5:0.25:2);
    set(gca,'YTickLabel',{'-1.50','-1.25','-1.00','-0.75','-0.50','-0.25','0','0.25','0.50','0.75','1.00','1.25','1.50','1.75','2.00'});
    grid on;         %画网格线
    title('凸轮磨削任务动态仿真','fontsize',20,'fontweight','bold','fontname','华文行楷');
    D_x1=D_x*cos_Theta(D_t)+D_y*sin_Theta(D_t);
    D_y1=D_y*cos_Theta(D_t)-D_x*sin_Theta(D_t);
    plot(D_x1,D_y1,'p','markersize',18,'Markerfacecolor','g');       %画凸轮型值点
%     D_x1=D_x*cos_Theta(D_t)+D_y*sin_Theta(D_t);
%     D_y1=D_y*cos_Theta(D_t)-D_x*sin_Theta(D_t);
%     plot(D_x1,D_y1,'-p');      %画凸轮型值点弦长
    %下面为坐标变换条件
    x_c1=x_c*cos_Theta(D_t)+y_c*sin_Theta(D_t);
    y_c1=y_c*cos_Theta(D_t)-x_c*sin_Theta(D_t);
    plot(x_c1,y_c1,'-b','LineWidth',3);      %画好凸轮
    clear x_c1 y_c1;
    x=-0.06:0.01:0.06;
    y=x-x;
    plot(x,y,'-b.');
    clear x y;
    y=-0.06:0.01:0.06;
    x=y-y;
    plot(x,y,'-b.');
    hold on;
    clear x y;                 %画好凸轮回转中心小十字 
    t=0:0.01:2*pi;
    xo=co(D_t)+R*cos(t);
    yo=R*sin(t);
    plot(xo,yo,'-m.','LineWidth',3);          %画好砂轮
    clear t;
    x=(co(D_t)-0.05):0.01:(co(D_t)+0.05);
    y=x-x;
    plot(x,y,'-m.');
    clear x y;
    y=-0.05:0.01:0.05;
    x=y-y+co(D_t);
    plot(x,y,'-m.');
    clear  x y;                %画好砂轮圆心小十字
    pause(0.001);
end           %这个循环是必要的 