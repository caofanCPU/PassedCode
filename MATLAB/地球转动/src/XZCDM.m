function XZCDM()
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
shg;

%虫子轨迹坐标
theat = 0:0.01:pi;
alfa = 3*theat-pi/2;
L = length(theat);
R = 1;                                %地球半径设为1
X = R*sin(theat).*cos(alfa);
Y = R*sin(theat).*sin(alfa);
Z = R*cos(theat)+R;
[X0,Y0,Z0]=sphere(30);                %得到单位经纬线球体坐标对
X0=R*X0;Y0=R*Y0;Z0=R*Z0+R;            %得到地球经纬线球坐标对
figure(1);
hold on;
grid on;
axis equal;
axis ([-1.5 1.5 -1.5 1.5 0 2]);
view(3);        %设置三维视角
E1 = surf(X0,Y0,Z0);
%shading interp                         %平滑渐变的颜色
re=[0 0 1];
colormap(re)
%shading flat
alpha(E1,0.2);
%plot3(X,Y,0*zeros(1,L),'y--','Marker','o',...
%    'MarkerFaceColor','k', 'MarkerSize',2);
%stem3(X,Y,Z,'--','color',[0 1 0],'Marker','None');
N = floor(L/30);
for i = 1:1:30                             %分段绘图
    %这里是绘图命令
    rotate(E1,[0 0 1],25);
    pause(0.3);
    X1 = X(1,(i-1)*N+1:i*N);
    Y1 = Y(1,(i-1)*N+1:i*N);
    Z1 = Z(1,(i-1)*N+1:i*N);
    if i ~= 30
        M7comet3(X1,Y1,Z1,0.01);
    else
        X1 = X(1,(i-1)*N+1:L);
        Y1 = Y(1,(i-1)*N+1:L);
        Z1 = Z(1,(i-1)*N+1:L);
        M7comet3(X1,Y1,Z1,0.9);
    end
    plot3(X1(1:4:9),Y1(1:4:9),0*zeros(1,3),'m-','Marker','o',...
    'MarkerFaceColor','y', 'MarkerSize',4);
    stem3(X1(1:4:9),Y1(1:4:9),Z1(1:4:9),'g--','Marker','None');
%     hca = allchild(gca);
%     set(hca(1),'visible','off');
%     %delete(hca(1));
    drawnow; % 刷新屏幕
end
end

