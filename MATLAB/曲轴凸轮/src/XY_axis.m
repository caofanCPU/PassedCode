function XY_axis(D_IFM)
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
%画图最开始的那一部分用 hold on 语句，可以优化代码，提高程序运行效率
axis 'equal';
axis ([ML_X ArrowX_max,MD_Y ArrowY_max]);
hold on;
x=ML_X:0.5:ArrowX_max;
y=x-x;
plot(x,y,'-k');
clear x,y;
y=MD_Y:0.5:ArrowY_max;
x=y-y;
plot(x,y,'-k');
clear x y;

%画Y轴正向箭头
    x=0:-0.1:-ArrowY_minx;
    y=2*(x+ArrowY_minx)+ArrowY_miny;
    y=[y,2.5*(x+ArrowY_minx)+ArrowY_miny];
    y=[y,3*(x+ArrowY_minx)+ArrowY_miny];
    x=[0:-0.1:-ArrowY_minx,0:-0.1:-ArrowY_minx,0:-0.1:-ArrowY_minx];
    plot(x,y,'-k.');
    clear x y;
    x=0:0.1:ArrowY_minx;
    y=(-2)*(x-ArrowY_minx)+ArrowY_miny;
    y=[y,(-2.5)*(x-ArrowY_minx)+ArrowY_miny];
    y=[y,(-3)*(x-ArrowY_minx)+ArrowY_miny];
    x=[0:0.1:ArrowY_minx,0:0.1:ArrowY_minx,0:0.1:ArrowY_minx];
    plot(x,y,'-k.');
    clear x y;
%画X轴正向箭头
    y=0:0.1:ArrowX_miny;
    x=[(-2)*(y-ArrowX_miny)+ArrowX_minx];
    x=[x,(-2.5)*(y-ArrowX_miny)+ArrowX_minx];
    x=[x,(-3)*(y-ArrowX_miny)+ArrowX_minx];
    y=[0:0.1:ArrowX_miny,0:0.1:ArrowX_miny,0:0.1:ArrowX_miny,];
    plot(x,y,'-k.');
    clear x y;
    y=0:-0.1:-ArrowX_miny;    
    x=[2*(y+ArrowX_miny)+ArrowX_minx];
    x=[x,2.5*(y+ArrowX_miny)+ArrowX_minx];
    x=[x,3*(y+ArrowX_miny)+ArrowX_minx];
    y=[0:-0.1:-ArrowX_miny,0:-0.1:-ArrowX_miny,0:-0.1:-ArrowX_miny];
    plot(x,y,'-k.');
    clear x y;

%对X-O-Y坐标系进行标注
text(-3,-2,'O','FontSize',16);
text(ArrowX_max-3,-2,'X','FontSize',16);
text(1,ArrowY_max-2,'Y','FontSize',16);
clear ArrowX_minx ArrowX_miny ArrowY_minx ArrowY_miny ArrowX_max ArrowY_max ML_X MD_Y
clear D_IFM;