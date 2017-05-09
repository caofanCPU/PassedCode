function Sanci_XY_axis(D_IFM)
%此函数专门用于在一幅figure图中画出X-O-Y直角坐标系
%经过测试，箭头底边距2*O-X或者2*O-Y选为坐标轴单位刻度的1/10到1/5时箭头效果较好
%坐标轴单位刻度较大，箭头的斜率系选取没必要多，取[2.0,2.5,3.0]就足够了
%坐标轴单位刻度较小，箭头的斜率系适当选取多一些，取[2.0,2.1,2.3,2.5,2.7,2.9,3.0]
%主要是基于带箭头（→；↑）的线段，对原点，箭头附近的轴标注
% D_IFM参数用于确定坐标轴三点范式信息
% D_IFM=[ArrowX_minx ArrowX_miny,ArrowY_minx ArrowY_miny, ArrowX_max, ArrowY_max, ML_X, MD_Y];
%在这些参数里面，必须有如下关系式成立：
% ArrowX_minx+3*ArrowX_miny=ArrowX_max;
% ArrowY_miny+3*ArrowY_minx=ArrowY_max;
%例如D_IFM=[xB yA, xA yB, xM, yM, MLX, MDY],
%其三点范式箭头坐标为 X:(xB,-yA)-(xM,0)(xB,yA) Y:(-xA,yB)-(0,yM)-(xA,yB)
ArrowX_minx=D_IFM(1);
ArrowX_miny=D_IFM(2);
ArrowY_minx=D_IFM(3);
ArrowY_miny=D_IFM(4);
ArrowX_max=D_IFM(5);
ArrowY_max=D_IFM(6);
ML_X=D_IFM(7);            %设定图形的范围里X轴最左端
MD_Y=D_IFM(8);            %设定图形的范围里Y轴最下端
%画X-Y轴
axis 'equal';
axis ([ML_X ArrowX_max,MD_Y ArrowY_max]);
hold on;
x=ML_X:0.05:ArrowX_max;
y=x-x;
plot(x,y,'-k');
clear x y;
y=MD_Y:0.05:ArrowY_max;
x=y-y;
axis 'equal';
axis ([ML_X ArrowX_max,MD_Y ArrowY_max]);
plot(x,y,'-k');
hold on;
clear x y;
%画Y轴正向箭头
x=0:-0.01:-ArrowY_minx;
x1=x+ArrowY_minx;
y=2*x1+ArrowY_miny;
y=[y,2.1*x1+ArrowY_miny];
y=[y,2.3*x1+ArrowY_miny];
y=[y,2.5*x1+ArrowY_miny];
y=[y,2.7*x1+ArrowY_miny];
y=[y,2.9*x1+ArrowY_miny];
y=[y,3*x1+ArrowY_miny];
x=[x,x,x,x,x,x,x];
plot(x,y,'-k');
clear x x1 y;
x=0:0.01:ArrowY_minx;
x1=x-ArrowY_minx;
y=(-2)*x1+ArrowY_miny;
y=[y,(-2.1)*x1+ArrowY_miny];
y=[y,(-2.3)*x1+ArrowY_miny];
y=[y,(-2.5)*x1+ArrowY_miny];
y=[y,(-2.7)*x1+ArrowY_miny];
y=[y,(-2.9)*x1+ArrowY_miny];
y=[y,(-3)*x1+ArrowY_miny];
x=[x,x,x,x,x,x,x];
plot(x,y,'-k');
clear x x1 y;
%画X轴正向箭头
y=0:0.01:ArrowX_miny;
y1=y-ArrowX_miny;
x=(-2)*y1+ArrowX_minx;
x=[x,(-2.1)*y1+ArrowX_minx];
x=[x,(-2.3)*y1+ArrowX_minx];
x=[x,(-2.5)*y1+ArrowX_minx];
x=[x,(-2.7)*y1+ArrowX_minx];
x=[x,(-2.9)*y1+ArrowX_minx];
x=[x,(-3)*y1+ArrowX_minx];
y=[y,y,y,y,y,y,y];
plot(x,y,'-k');
clear x y1 y;
y=0:-0.01:-ArrowX_miny;
y1=y+ArrowX_miny;
x=2*y1+ArrowX_minx;
x=[x,2.1*y1+ArrowX_minx];
x=[x,2.3*y1+ArrowX_minx];
x=[x,2.5*y1+ArrowX_minx];
x=[x,2.7*y1+ArrowX_minx];
x=[x,2.9*y1+ArrowX_minx];
x=[x,3*y1+ArrowX_minx];
y=[y,y,y,y,y,y,y];
plot(x,y,'-k');
clear x y1 y;
%对X-O-Y坐标系进行标注
text(-0.10,-0.10,'O','FontSize',16);
text(ArrowX_max-0.1,-0.10,'X','FontSize',16);
text(0.05,ArrowY_max-0.05,'Y','FontSize',16);
clear ArrowX_minx ArrowX_miny ArrowY_minx ArrowY_miny ArrowX_max ArrowY_max ML_X MD_Y
clear D_IFM;

%如果需要标注坐标系刻度，采用下列待修改代码
% clc;
% tic;
% x=-1.25:0.25:3.5; y=-1.25:0.25:1.6;%指定坐标轴范围
% axis off;  %消去四周边框
% hold on;
% plot([0,0],[min(y) max(y)],'k',[min(x) max(x)],[0 0],'k'); % 前半部分表示x坐标区间[0,0]，y坐标区间[min,max]间点的连线 
% ax=[max(x),max(x)-0.1,max(x)-0.1;0,0.03,-0.03]; %ax为2*2矩阵
% fill(ax(1,:),ax(2,:),'k');  %ax(1,:)表示矩阵ax第一行所有元素
% ay=[0,0.03,-0.03;max(y),max(y)-0.1,max(y)-0.1];
% fill(ay(1,:),ay(2,:),'k');       %坐标箭头绘制完成
% hold on
% for i=1:length(x)-1  %注意i需从1开始，因为横纵坐标交于0，而0刻度值只需画一个
%     if x(i)~=0  %x(i)值为x的第i位元素值
%          plot([x(i),x(i)],[0,0.03],'k'); hold on  %画刻度线
%          a=text(x(i),-0.08,num2str(x(i)));       %画刻度值，-0.08为刻度值相对轴的偏移量
%          set(a,'HorizontalAlignment','center');  %HorizontalAlignment意为水平对齐，该set()意为将''中的属性全部应用到c
%          end
% end
% % text(max(x),-0.1,'X');
% for i=1:length(y)-1 
%     if y(i)~=0
%         plot([0,0.03],[y(i),y(i)],'k'); hold on
%         b=text(-0.08,y(i),num2str(y(i)));
%         set(b,'HorizontalAlignment','center'); 
%     end
% end
% text(-0.1,max(y),'Y');
% c=text(-0.008,-0.08,num2str(0));  %补上0刻度值
% set(c,'HorizontalAlignment'); 
% toc;
% pause()
% text(-0.10,-0.10,'O','FontSize',16);
% text(ArrowX_max-0.1,-0.10,'X','FontSize',16);
% text(0.05,ArrowY_max-0.05,'Y','FontSize',16);