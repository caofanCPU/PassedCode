function  ZD_Action()
%MATLAB传递函数编程训练
% zeta=0.2;
% for i=1:1:7
% zeta=zeta+0.1;  %阻尼比，初始化为最佳阻尼比
% num=[16];    %闭环传递函数的分子表达式
% den=[1,8*zeta,16]; %闭环传递函数的分母表达式
% sys=tf(num,den);   %构建闭环传递函数的s域的表达式
% p=roots(den);
% figure(1);
% impulse(sys,5);
% grid;
% hold on;
% xlabel('t');ylabel('c1(t)');title('脉冲响应');
% figure(2);
% step(sys,5);grid;hold on;
% xlabel('t');ylabel('c2(t)');title('阶跃响应');
% figure(3);grid on; hold on;
% t=0:0.001:10;
% u=t;
% lsim(sys,u,t,0);
% xlabel('t');ylabel('c2(t)');title('斜坡响应');
% end

zeta=0.2;
for i=1:1:7
zeta=zeta+0.1;  %阻尼比，初始化为最佳阻尼比
wn=80;
num=[wn^2];    %传递函数的分子表达式
den=[1,2*zeta*wn,wn^2]; %传递函数的分母表达式
G1=tf(num,den);   %构建传递函数的s域的表达式
den1=[1,0];
num1=1;
G2=tf(num1,den1);  %调用传递函数，后接()括弧
sys=series(G1,G2);
disp('系统闭环传递函数为：\n');
sys=feedback(sys,1,-1);
%p=roots(den);
figure(1);
impulse(sys,10);
grid;
hold on;
xlabel('t');ylabel('c1(t)');title('脉冲响应');
figure(2);
step(sys,10);grid;hold on;
xlabel('t');ylabel('c2(t)');title('阶跃响应');
figure(3);grid on; hold on;
t=0:0.001:10;
u=t;
lsim(sys,u,t,0);
xlabel('t');ylabel('c2(t)');title('斜坡响应');
end
return ;