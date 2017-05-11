function MSE_MAIN()
warning off all;
%弦轴孔定位最小二乘法主函数
%定义设想方案中重要数据存储全局变量
%          图纸点坐标、机床点坐标、带误差测量点坐标、旋转平移点坐标、最小二乘点坐标、坐标点个数
%          旋转角、平移量、旋转平移法参变量（与平移量有区别）
%          最小二乘法参变量
%          每次随机过程得到的距离差数学期望、距离差均方差
tic;
global CF_u CF_v CF_X_GREEN CF_Y_GREEN CF_X_RED CF_Y_RED CF_X_BLUE CF_Y_BLUE CF_X_MAGENTA CF_Y_MAGENTA CF_LEN; 
global CF_CHOOSE1 CF_CHOOSE2 CF_THEAT CF_X_XP CF_Y_XP CF_X_XP_CBL CF_Y_XP_CBL ;
global CF_A_CBL CF_B_CBL CF_C_CBL CF_D_CBL CF_E_CBL CF_F_CBL ;
global CF_S_LD1 CF_S_LD2 CF_S_LD3 CF_E_S_LD1 CF_E_S_LD2 CF_E_S_LD3 CF_CF_MSE1 CF_CF_MSE2 CF_CF_MSE3;
global u v L;
%将全体设想方案中重要数据存储全局变量初始化为空矩阵
CF_u = []; CF_v = []; CF_X_GREEN = []; CF_Y_GREEN = []; CF_X_RED = []; CF_Y_RED = [];  CF_X_BLUE = []; CF_Y_BLUE = []; CF_X_MAGENTA = []; CF_Y_MAGENTA = []; 
CF_CHOOSE1 = []; CF_CHOOSE2 = []; CF_THEAT = []; CF_X_XP = []; CF_Y_XP = []; CF_X_XP_CBL = []; CF_Y_XP_CBL = [];
CF_A_CBL = []; CF_B_CBL = []; CF_C_CBL = []; CF_D_CBL = []; CF_E_CBL = []; CF_F_CBL = [] ;
CF_S_LD1 = []; CF_S_LD2 = []; CF_S_LD3 = []; CF_E_S_LD1 = []; CF_E_S_LD2 = []; CF_E_S_LD3 = []; CF_CF_MSE1 = []; CF_CF_MSE2 = []; CF_CF_MSE3 = [];

%读取图纸坐标文件“仿图纸坐标.txt”
fid = fopen('仿图纸坐标.txt','r');
s = fscanf(fid,'%*c%f %*c%f ',[2 inf]);     
fclose(fid);
u = s(1,:);
v = s(2,:);
save CF_ZUOBIAOXP.mat s u v;           %得到图纸二维坐标{（u,v）}，保存在“CF_ZUOBIAO.mat”文件中
% MSE_MAIN
% Elapsed time is 15.662000 seconds.  1000次
% >> MSE_MAIN
% Elapsed time is 350.111000 seconds.  5000次
% >> MSE_MAIN
% Elapsed time is 354.651000 seconds.   5000次
rand('state',sum(100*clock));            %初始化随机种子，种子随时间变化全局随机流
L=1;                                  %进行L次随机主过程
% set(0,'RecursionLimit',5002);          %设置递归调用允许的深度，即堆栈空间，默认为500
% CF_MSE(u,v,L);
for i=1:1:L
    CF_MSE(u,v);
end

%模拟量与理论量差异程度分析
%差异分析的方法：
%       对目标模拟量多次统计的数据点，即蓝点和紫红点，与对应的理论量，即绿点，求对应点的距离差，分别得到三组距离差数据CF_S_LD1、CF_S_LD2、CF_S_LD3
%       画出CF_S_LD1、CF_S_LD2、CF_S_LD3的折线图进行对比分析，并求每组距离差数据的数学期望和均方差，从图形和数据两方面判断方案的可行性与优劣
y = [CF_S_LD1; CF_S_LD2;CF_S_LD3];
%y=y';
%计算三种方案的数学期望和方差
CF_E_S_LD1 = sum(CF_E_S_LD1,2)/L;
CF_E_S_LD2 = sum(CF_E_S_LD2,2)/L;
CF_E_S_LD3 = sum(CF_E_S_LD3,2)/L;
CF_CF_MSE1 = sum(CF_CF_MSE1,2)/L;
CF_CF_MSE2 = sum(CF_CF_MSE2,2)/L;
CF_CF_MSE3 = sum(CF_CF_MSE3,2)/L;

% %close all;
% figure(5);
% hold on;
% grid on;
% axis 'equal';
% t = 1:1:CF_LEN*L;                      %点的个数*进行随机过程的循环次数
% plot(t,CF_S_LD1,'-bo',t,CF_S_LD2,'-mo',t,CF_S_LD3,'-ro');
% 
% bar(y',0.5);
% title('图5  最小二乘方案与旋转平移方案点距离差图形');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it 旋转平移法距离差折线图','\fontsize{14}\it 最小二乘法距离差折线图','\fontsize{14}\it 实际测量法距离差折线图','\fontsize{14}\it 旋转平移法距离差直方图','\fontsize{14}\it 最小二乘法距离差直方图','\fontsize{14}\it  实际测量法法距离差直方图');
CF_ALL_XY = [CF_u;CF_v;CF_X_RED;CF_Y_RED;CF_X_BLUE;CF_Y_BLUE;CF_X_GREEN;CF_Y_GREEN;CF_X_MAGENTA;CF_Y_MAGENTA];
CF_ALL_CBL1 = [CF_CHOOSE1; CF_THEAT; CF_X_XP; CF_Y_XP; CF_X_XP_CBL; CF_Y_XP_CBL];
CF_ALL_CBL2 = [CF_CHOOSE2; CF_A_CBL; CF_B_CBL; CF_C_CBL; CF_D_CBL; CF_E_CBL; CF_F_CBL];
IMP_DATAS = [CF_E_S_LD1; CF_CF_MSE1; CF_E_S_LD2; CF_CF_MSE2; CF_E_S_LD3; CF_CF_MSE3];
fid=fopen('IMP_DATAS.txt', 'at');  
fprintf(fid, '>>>>>>>>>>>>>>>>>>>>>>>>>>\n旋转平移法：\n\t最终数学期望E_S_LD1=%-8.4f\t\t 最终均方差CF_MSE1=%-8.4f\n最小二乘法：\n\t最终数学期望E_S_LD2=%-8.4f\t\t 最终均方差CF_MSE2=%-8.4f\n直接测量法：\n\t最终数学期望E_S_LD3=%-8.4f\t\t 最终均方差CF_MSE3=%-8.4f\n<<<<<<<<<<<<<<<<', IMP_DATAS);
fclose(fid);

%生成所有颜色点的二维坐标数据文件“TuZhiZuoBiao.txt”
% fid=fopen('TuZhiZuoBiao.txt', 'wt');  
% fprintf(fid, '黑点坐标(%-7.3f,%7.3f)；红点坐标(%-7.3f,%7.3f)；蓝点坐标(%-7.3f,%7.3f)；绿点坐标(%-7.3f,%7.3f)；紫红点坐标(%-7.3f,%7.3f)\n', CF_ALL_XY);
% fclose(fid);

%生成设想1方案中重要参数及函数关系数据文件“1_SheXiangFangAn_CBL.txt”
% fid=fopen('1_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '设想方案1中:选取旋转中心：图纸点1编号“%-3d点”\t坐标：(%-8.4f，%8.4f)\t选取旋转点：图纸点2编号“%-3d点”\t坐标：(%-8.4f，%8.4f)\n旋转角：β=%-8.4f ；平移量：(%-8.4f，%8.4f)\n\t\tx=(u-(%-8.4f))*cos(%-8.4f)-(v-(%-8.4f))*sin(%-8.4f)+(%-8.4f)\n\t\ty=(u-(%-8.4f))*sin(%-8.4f)+(v-(%-8.4f))*cos(%-8.4f)+(%-8.4f)\n', CF_ALL_CBL1);
% fclose(fid);

%%%%%%%%%%%%删除测试
% fid=fopen('1_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '设想方案1中:选取旋转中心：图纸点1编号“%-3d点”\t坐标：(%-8.4f，%8.4f)\t选取旋转点：图纸点2编号“%-3d点”\t坐标：(%-8.4f，%8.4f)\n', CF_CHOOSE1);
% fclose(fid);

%生成设想2方案中重要参数及函数关系数据文件“2_SheXiangFangAn_CBL.txt”
% fid=fopen('2_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '设想方案2中:\n图纸点1编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点2编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点3编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点4编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点5编号“%-3d点”，坐标：(%-8.4f，%8.4f)；\n图纸点6编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点7编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点8编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点9编号“%-3d点”，坐标：(%-8.4f，%8.4f)；\n\t\t采用最小二乘法函数关系为：\n\t\t\tx=(%-8.4f)*u +(%-8.4f)*v + (%-8.4f)\n\t\t\ty=(%-8.4f)*u +(%-8.4f)*v + (%-8.4f)\n', CF_ALL_CBL2);
% fclose(fid);

%%%%%%%%%%%%%%%%%%%%删除测试
% fid=fopen('2_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '设想方案2中:\n图纸点1编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点2编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点3编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点4编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点5编号“%-3d点”，坐标：(%-8.4f，%8.4f)；\n图纸点6编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点7编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点8编号“%-3d点”，坐标：(%-8.4f，%8.4f)；图纸点9编号“%-3d点”，坐标：(%-8.4f，%8.4f)；\n', CF_CHOOSE2);
% fclose(fid);

%生成三种方案的坐标点与机床点的距离差数据文件“S_LD.txt”
% fid=fopen('S_LD.txt', 'wt');  
% fprintf(fid, '旋转平移点距离差：\t(%-8.4f)\t；最小二乘点距离差：\t(%-8.4f)\t；测量点距离差\t(%-8.4f)\n', y);
% fclose(fid);
toc
return;