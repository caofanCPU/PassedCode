function XZCDM()
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
shg;

%���ӹ켣����
theat = 0:0.01:pi;
alfa = 3*theat-pi/2;
L = length(theat);
R = 1;                                %����뾶��Ϊ1
X = R*sin(theat).*cos(alfa);
Y = R*sin(theat).*sin(alfa);
Z = R*cos(theat)+R;
[X0,Y0,Z0]=sphere(30);                %�õ���λ��γ�����������
X0=R*X0;Y0=R*Y0;Z0=R*Z0+R;            %�õ�����γ���������
figure(1);
hold on;
grid on;
axis equal;
axis ([-1.5 1.5 -1.5 1.5 0 2]);
view(3);        %������ά�ӽ�
E1 = surf(X0,Y0,Z0);
%shading interp                         %ƽ���������ɫ
re=[0 0 1];
colormap(re)
%shading flat
alpha(E1,0.2);
%plot3(X,Y,0*zeros(1,L),'y--','Marker','o',...
%    'MarkerFaceColor','k', 'MarkerSize',2);
%stem3(X,Y,Z,'--','color',[0 1 0],'Marker','None');
N = floor(L/30);
for i = 1:1:30                             %�ֶλ�ͼ
    %�����ǻ�ͼ����
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
    drawnow; % ˢ����Ļ
end
end

