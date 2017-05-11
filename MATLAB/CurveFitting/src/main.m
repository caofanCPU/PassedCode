function main()
close all;
clear all;
warning off;
clc;
global y s r a b c Theta1 Theta2;
y=0; 
s=0;      %y,s用来存储求解结果的数据信息,便于文档保存
disp('曲轴磨砂轮磨任务程序仿真即将开始，默认半径信息：[R1,R2,R3]=[22.4,10.3,34.5]');
r=[22.4,10.3,34.5];
a=r(2)+r(3);
c=r(1)-r(2);
b=0;
Theta1=-1;                    %根据循环体中的关于Theta1的表达式确定其初态为-1正好可以从0开始        
Theta2=0;                      %初始化全局变量
clc
disp('下面将展示Theta1为自变量时曲轴磨凸轮磨动态演示：')
pause(5)
for i=0:1:360     
    Theta1=Theta1+1;
%     tic;
    FQ1(Theta1,a,b,c,r,y);
%     toc;
%     pause(20);
    %count11=PICTURE(Theta1,b,c,r);
%     tic;
    PICTURE(Theta1,b,c,r);
%     toc;
%     pause(20);
    %引起Theta1不能正常进行循环自加1的原因？？？？？？
    %其原因为PICTURE函数调用里面Theta1的值由角度值变为弧度值
    %再次进入for循环时Theta1的值基本不会变
end
fid=fopen('Question1.txt', 'wt');  
fprintf(fid, 'Theta1=%-8.4f Theta2=%-8.4f Zo3=%-6.3f Px_z=(%6.3f,%-6.3f)\n', y);
fclose(fid);
clc
disp('问题1求解结果数据保存完毕！5秒后进入问题2的求解过程和结果保存！')
pause(5)           %停顿5秒

clc
clf
b=0;
Theta1=0;
Theta2=-1;         %根据循环体中的关于Theta1的表达式确定其初态为-1正好可以从0开始
disp('下面将展示Theta2为自变量时曲轴磨凸轮磨动态演示：\n')
for i=0:1:360
    Theta2=Theta2+1;
%     tic;
    FQ2(Theta2,Theta1,a,b,c,r,s);
%     toc;
%     pause(20);
%     tic;
    PICTURE(Theta1,b,c,r);
%     toc;
%     pause(20);
end
fid=fopen('Question2.txt', 'wt');  
fprintf(fid, 'Theta1=%-8.4f Theta2=%-8.4f Zo3=%-6.3f Px_z=(%6.3f,%-6.3f)\n', s);
fclose(fid);
close all;
%toc;     %与tic搭配用于计算程序运行时间，注意清除变量的顺序！！
clear all;
return;