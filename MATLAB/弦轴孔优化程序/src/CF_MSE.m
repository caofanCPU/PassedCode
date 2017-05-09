function  CF_MSE(u,v)
%warning off all;
%最小二乘法解决弦轴孔定位MATLAB仿真实验程序
%试验条件：①指定图纸二维坐标集合（标记为黑点）：{(ui,vi),i=1,2,...,8,9}
%         ②指定旋转平移方法，根据α及平移条件得到二维坐标集合（标记为绿点）：{(X_GREENi,Y_GREENi),i=1,2,...,8,9}
%         ③对绿点集合进行随机指定圆区域的干扰增量，从而得到仿真测量二维坐标集合（标记为绿点）：{(X_REDi,Y_REDi),i= 1,2,...,8,9}
%         ④选出2个红点与对应的黑点重新计算旋转参数β角和平移量，从而得到仿真模拟旋转平移后的二维坐标集合（标记为蓝点）：{(X_BLUEi,Y_BLUEi),i= 1,2,...,8,9}
%         ⑤利用最小二乘法算出最小二乘的6个参数，根据这个参数得到最小二乘化后的二维坐标集合（标记为紫红点）：{(X_MAGENTAi,Y_MAGENTAi),i= 1,2,...,8,9}
%         ⑥画出黑点、红点、蓝点和紫红点，便于直观分析
%         ⑦求出蓝点集合与黑点集合对应点距离差的和，紫红点集合与黑点集合对应点距离差的和

%定义坐标数据全局变量 图纸点坐标、机床点坐标、带误差测量点坐标、旋转平移点坐标、最小二乘点坐标、坐标点个数
%                    旋转角、平移量、旋转平移法参变量（与平移量有区别）
%                    最小二乘法参变量
global CF_u CF_v CF_X_GREEN CF_Y_GREEN CF_X_RED CF_Y_RED CF_X_BLUE CF_Y_BLUE CF_X_MAGENTA CF_Y_MAGENTA CF_LEN; 
global CF_CHOOSE1 CF_CHOOSE2 CF_THEAT CF_X_XP CF_Y_XP CF_X_XP_CBL CF_Y_XP_CBL ;
global CF_A_CBL CF_B_CBL CF_C_CBL CF_D_CBL CF_E_CBL CF_F_CBL ;
global CF_S_LD1 CF_S_LD2 CF_S_LD3 CF_E_S_LD1 CF_E_S_LD2 CF_E_S_LD3 CF_CF_MSE1 CF_CF_MSE2 CF_CF_MSE3;
%获取坐标数据的个数
CF_LEN = length(u);                   %图纸二维坐标点个数为CF_LEN
%图纸点累计合并
CF_u = [CF_u, u];
CF_v = [CF_v, v];
%图纸坐标绕点(u7,v7)旋转10°，平移(30-u(7),40-v(7))，得到机床点（绿点）集合
X_GREEN = (u-u(7)).* cos(pi/36) - (v-v(7)).* sin(pi/36) + 30;
Y_GREEN = (u-u(7)).* sin(pi/36) + (v-v(7)).* cos(pi/36) + 40;
%机床点累计合并
CF_X_GREEN = [CF_X_GREEN, X_GREEN];
CF_Y_GREEN = [CF_Y_GREEN, Y_GREEN];
%对每组所有机床点模拟【随机误差】测量
theat = 2 * pi *rand(1,CF_LEN);               %指定CF_LEN个在[0，2π)的随机角度值theat
r = 0.5 * rand(1,CF_LEN);                     %指定CF_LEN个在[0.5)的随机半径值
%对所有机床点模拟测量，【随机】选取其中的模拟测量点作为实际测量点，再执行方案
%得到模拟测量坐标，即红点集合
X_RED = X_GREEN + r.*cos(theat);
Y_RED = Y_GREEN + r.*sin(theat);
%模拟测量点累计合并
CF_X_RED = [CF_X_RED, X_RED];
CF_Y_RED = [CF_Y_RED, Y_RED];

%【随机】选取2个红点及其对应的黑点，求解新的旋转平移参数，得到蓝色点集合
%选取点5，点7；即(u(5),v(5)),(u(7),v(7))，点7为旋转中心;(X_RED(5),Y_RED(5)),(X_RED(7),Y_RED(7))
%优先使用矩阵求解旋转参数THEAT
CF_RED1 = randperm(CF_LEN);    %生成1（包括）到CF_LEN（包括）中的无重复随机行序列
CF_RED = CF_RED1(1:2);
P = CF_RED(1);                %随机选取得到旋转点P
Q = CF_RED(2);                %随机选取得到旋转中心点Q，且P、Q不是同一点

% P = 1;                %随机选取得到旋转点P
% Q = 2;                %随机选取得到旋转中心点Q，且P、Q不是同一点


L_CHOOSE1 = [Q; u(Q); v(Q); P; u(P); v(P)];
%保存这次选择数据
CF_CHOOSE1 = [CF_CHOOSE1, L_CHOOSE1];
T_A = [(u(P)-u(Q)), -(v(P)-v(Q)); (v(P)-v(Q)), (u(P)-u(Q))];
T_b = [X_RED(P)-X_RED(Q); Y_RED(P)-Y_RED(Q)];
T_cosxsiny = T_A\T_b;
T_cosxsiny = T_cosxsiny';
THEAT = atan(T_cosxsiny(2)/T_cosxsiny(1));          %变量THEAT即为新的旋转角，新的平移量即为(X_RED(7)-u(7),Y_RED(7)-v(7))
%以累计方式保存旋转平移方案重要数据
CF_THEAT = [CF_THEAT, THEAT];
CF_X_XP = [CF_X_XP, X_RED(Q)-u(Q)];
CF_Y_XP = [CF_Y_XP, Y_RED(Q)-v(Q)];
L_RX = [u(Q); THEAT ; v(Q); THEAT; X_RED(Q)];
L_RY = [u(Q); THEAT ; v(Q); THEAT; Y_RED(Q)];
CF_X_XP_CBL = [CF_X_XP_CBL, L_RX];
CF_Y_XP_CBL = [CF_Y_XP_CBL, L_RY];
%根据图纸坐标，得到设想1中的旋转平移坐标，即蓝点集合
X_BLUE = (u-u(Q)).* cos(THEAT) - (v-v(Q)).* sin(THEAT) + X_RED(Q);
Y_BLUE = (u-u(Q)).* sin(THEAT) + (v-v(Q)).* cos(THEAT) + Y_RED(Q);
%旋转平移点累计合并
CF_X_BLUE = [CF_X_BLUE, X_BLUE];
CF_Y_BLUE = [CF_Y_BLUE, Y_BLUE];

%求解最小二乘法的6个参变量a,b,c,d,e,f
n = 9;                                           %指定选用n个测量点用于计算最小二乘法的参变量
%n的值关系到文件保存的正确性，要对应改！！
fid=fopen('IMP_DATAS.txt', 'at');  
fprintf(fid,'旋转平移法选用2个随机测量点，最小二乘法选用%d个随机测量点，得到如下数据：\n', n);
fclose(fid);

%随机选取最小二乘法方案随机选取n个点
%SJ_MAGENTA = randperm(CF_LEN);
%SJ_MAGENTA = SJ_MAGENTA(1:n);                    %得到一个随机选取n个坐标点的序列
% CF_RED1 = [4 50 80 189];

SJ_MAGENTA = CF_RED1(1:n);
L_CHOOSE2 = [SJ_MAGENTA; u(SJ_MAGENTA); v(SJ_MAGENTA)];  %这是一个3*n的矩阵
L_CHOOSE2 = reshape(L_CHOOSE2,3*n,1);             %变换为(3*n)*1的矩阵
%保存这次选择数据
CF_CHOOSE2 = [CF_CHOOSE2, L_CHOOSE2];

SJ_X_RED = X_RED(SJ_MAGENTA);                    %得到随机选取的n个测量点坐标
SJ_Y_RED = Y_RED(SJ_MAGENTA);                    %可指定为全局变量以输出随机选取的测量点坐标数据
CF_MAGENTA_u = u(SJ_MAGENTA);                    %得到的对应的n个图纸坐标
CF_MAGENTA_v = v(SJ_MAGENTA); 

%构建最小二乘法参变量矩阵方程
A = sum(CF_MAGENTA_u.^2,2);
B = sum(CF_MAGENTA_u.*CF_MAGENTA_v,2);
C = sum(CF_MAGENTA_u,2);
D = sum(CF_MAGENTA_u.*SJ_X_RED,2);
E = sum(CF_MAGENTA_v.^2,2);
F = sum(CF_MAGENTA_v,2);
G = sum(CF_MAGENTA_v.*SJ_X_RED,2);
H = sum(SJ_X_RED,2);
I = sum(CF_MAGENTA_u.*SJ_Y_RED,2);
J = sum(CF_MAGENTA_v.*SJ_Y_RED,2);
K = sum(SJ_Y_RED,2);
XS = [A B C; B E F; C F n];                     %系数矩阵为3x3
XCXS = [D; G; H];                               %X组常数矩阵为3x1
YCXS = [I; J; K];                               %Y组常数矩阵为3x1
%求解矩阵方程得到参变量矩阵解
CBL_X = XS\XCXS;                                %求解x组参变量矩阵3x1
CBL_Y = XS\YCXS;                                %求解y组参变量矩阵3x1

%以累计方式保存最小二乘法方案重要参数
CF_A_CBL = [CF_A_CBL, CBL_X(1)];
CF_B_CBL = [CF_B_CBL, CBL_X(2)];
CF_C_CBL = [CF_C_CBL, CBL_X(3)];
CF_D_CBL = [CF_D_CBL, CBL_Y(1)];
CF_E_CBL = [CF_E_CBL, CBL_Y(2)];
CF_F_CBL = [CF_F_CBL, CBL_Y(3)];
%根据最小二乘法函数关系得到最小二乘优化后坐标，即紫红点
X_MAGENTA = CBL_X(1).*u + CBL_X(2).*v + CBL_X(3);
Y_MAGENTA = CBL_Y(1).*u + CBL_Y(2).*v + CBL_Y(3);
CF_X_MAGENTA = [CF_X_MAGENTA, X_MAGENTA];
CF_Y_MAGENTA = [CF_Y_MAGENTA, Y_MAGENTA];

%对旋转平移法方案、最小二乘法方案进行距离差的数学期望和均方差数值分析
S_LD1 = sqrt((X_BLUE - X_GREEN).^2 + (Y_BLUE - Y_GREEN).^2);   %行向量1*219
S_LD2 = sqrt((X_MAGENTA - X_GREEN).^2 + (Y_MAGENTA - Y_GREEN).^2);
S_LD3 = sqrt((X_RED - X_GREEN).^2 + (Y_RED - Y_GREEN).^2);

%以累计方式得到实验全部距离差数据
CF_S_LD1 = [CF_S_LD1, S_LD1];        %行向量1*(L*219)   
CF_S_LD2 = [CF_S_LD2, S_LD2];
CF_S_LD3 = [CF_S_LD3, S_LD3];
%求每组的数学期望和均方差
E_S_LD1 = sum(S_LD1,2)/(CF_LEN);
E_S_LD2 = sum(S_LD2,2)/(CF_LEN);
E_S_LD3 = sum(S_LD3,2)/(CF_LEN);
CF_MSE1 = sqrt(sum((S_LD1 - E_S_LD1).^2,2)/(CF_LEN));
CF_MSE2 = sqrt(sum((S_LD2 - E_S_LD2).^2,2)/(CF_LEN));
CF_MSE3 = sqrt(sum((S_LD3 - E_S_LD3).^2,2)/(CF_LEN));
%以累计方式保存两种方案中的数学期望和均方差
CF_E_S_LD1 = [CF_E_S_LD1, E_S_LD1];
CF_E_S_LD2 = [CF_E_S_LD2, E_S_LD2];
CF_E_S_LD3 = [CF_E_S_LD3, E_S_LD3];
CF_CF_MSE1 = [CF_CF_MSE1, CF_MSE1];
CF_CF_MSE2 = [CF_CF_MSE2, CF_MSE2];
CF_CF_MSE3 = [CF_CF_MSE3, CF_MSE3];

%重要数据保存在IMP_DATAS中，以非累计方式，采用添加写文件方式完成数据在生成文件中的保存
IMP_DATAS = [E_S_LD1; CF_MSE1; E_S_LD2; CF_MSE2; E_S_LD3; CF_MSE3];
fid=fopen('IMP_DATAS.txt', 'at');  
fprintf(fid, '旋转平移法：\n\t\t数学期望E_S_LD1=%-8.4f\t\t\t 均方差CF_MSE1=%-8.4f\n最小二乘法：\n\t\t数学期望E_S_LD2=%-8.4f\t\t\t 均方差CF_MSE2=%-8.4f\n直接测量法：\n\t\t数学期望E_S_LD3=%-8.4f\t\t\t 均方差CF_MSE3=%-8.4f\n', IMP_DATAS);
fclose(fid);

% %画4幅图，这种方法的展示效果较好，但不利于程序执行
% figure(1);
% subplot(2,2,1);
% grid on;
% hold on;
% axis 'equal';
% title('图1  图纸点与机床点图形');
% plot(u,v,'-ko',X_GREEN,Y_GREEN,'-go');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Block pot','\fontsize{14}\it Green pot');
% 
% subplot(2,2,2);
% grid on;
% hold on;
% axis 'equal';
% title('图2  图纸点与测量点图形');
% plot(u,v,'-ko',X_RED,Y_RED,'-ro');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Block pot','\fontsize{14}\it Red pot');
% 
% subplot(2,2,3);
% grid on;
% hold on;
% axis 'equal';
% title('图3  机床点与旋转平移点图形');
% plot(X_GREEN,Y_GREEN,'-.go',X_BLUE,Y_BLUE,'-bo');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Green pot','\fontsize{14}\it Blue pot');
% 
% subplot(2,2,4);
% grid on;
% hold on;
% axis 'equal';
% title('图4  最小二乘点与旋转平移点差异图形');
% plot(X_GREEN,Y_GREEN,'-.go',X_MAGENTA,Y_MAGENTA,'-mo');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Green pot','\fontsize{14}\it Magenta pot');

% 表5.1.1 绘图参数表
% 色彩字符颜色线型字符线型格式标记符号数据点形式标记符号数据点形式
% y 黄  -  实线        . 点      <小于号
% m 紫  ： 点线        o 圆      s正方形
% c 青  -. 点划线      x 叉号    d 菱形
% r 红  - - 虚线       + 加号    h六角星
% g 绿  * 星号         p五角星
% b 蓝  v 向下三角形
% w 白  ^ 向上三角形
% k 黑  > 大于号

%画4幅图，这种方法的展示效果较差，但是很方便程序执行，实际运行时采用这种方案
figure(1);
hold on;
grid on;
axis 'equal';
title('图1  图纸点与机床点图形');
plot(u,v,'-ko','MarkerFaceColor','k');
plot(X_GREEN,Y_GREEN,'-go','MarkerFaceColor','g')
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it 图纸点','\fontsize{14}\it 机床点');

figure(2);
hold on;
grid on;
axis 'equal';
title('图2  机床点与测量点图形');
plot(X_GREEN,Y_GREEN,'-go','MarkerFaceColor','g');
plot(X_RED,Y_RED,'-ro','MarkerFaceColor','r');
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it 机床点','\fontsize{14}\it 测量点');

figure(3);
hold on;
grid on;
axis 'equal';
title('图3  机床点与旋转平移点图形');
plot(X_GREEN,Y_GREEN,'-.go','MarkerFaceColor','g');
plot(X_BLUE,Y_BLUE,'-bo','MarkerFaceColor','b');
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it 机床点','\fontsize{14}\it 旋转平移点');

figure(4);
hold on;
grid on;
axis 'equal';
title('图4  机床点与最小二乘点差异图形');
plot(X_GREEN,Y_GREEN,'-.go','MarkerFaceColor','g');
plot(X_MAGENTA,Y_MAGENTA,'-mo','MarkerFaceColor','m')
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it 机床点','\fontsize{14}\it 最小二乘点');
hold off;

% %toc;
% L = L - 1;
% if  L ~= 0
%    CF_MSE(u,v,L);  %递归调用不能改善主函数循环的性能，且对函数调用的参数保存所需要的堆栈空间也是有限的！
%    return;
% end
return;