function  CF_MSE(u,v)
%warning off all;
%��С���˷��������׶�λMATLAB����ʵ�����
%������������ָ��ͼֽ��ά���꼯�ϣ����Ϊ�ڵ㣩��{(ui,vi),i=1,2,...,8,9}
%         ��ָ����תƽ�Ʒ��������ݦ���ƽ�������õ���ά���꼯�ϣ����Ϊ�̵㣩��{(X_GREENi,Y_GREENi),i=1,2,...,8,9}
%         �۶��̵㼯�Ͻ������ָ��Բ����ĸ����������Ӷ��õ����������ά���꼯�ϣ����Ϊ�̵㣩��{(X_REDi,Y_REDi),i= 1,2,...,8,9}
%         ��ѡ��2��������Ӧ�ĺڵ����¼�����ת�����½Ǻ�ƽ�������Ӷ��õ�����ģ����תƽ�ƺ�Ķ�ά���꼯�ϣ����Ϊ���㣩��{(X_BLUEi,Y_BLUEi),i= 1,2,...,8,9}
%         ��������С���˷������С���˵�6��������������������õ���С���˻���Ķ�ά���꼯�ϣ����Ϊ�Ϻ�㣩��{(X_MAGENTAi,Y_MAGENTAi),i= 1,2,...,8,9}
%         �޻����ڵ㡢��㡢������Ϻ�㣬����ֱ�۷���
%         ��������㼯����ڵ㼯�϶�Ӧ������ĺͣ��Ϻ�㼯����ڵ㼯�϶�Ӧ������ĺ�

%������������ȫ�ֱ��� ͼֽ�����ꡢ���������ꡢ�������������ꡢ��תƽ�Ƶ����ꡢ��С���˵����ꡢ��������
%                    ��ת�ǡ�ƽ��������תƽ�Ʒ��α�������ƽ����������
%                    ��С���˷��α���
global CF_u CF_v CF_X_GREEN CF_Y_GREEN CF_X_RED CF_Y_RED CF_X_BLUE CF_Y_BLUE CF_X_MAGENTA CF_Y_MAGENTA CF_LEN; 
global CF_CHOOSE1 CF_CHOOSE2 CF_THEAT CF_X_XP CF_Y_XP CF_X_XP_CBL CF_Y_XP_CBL ;
global CF_A_CBL CF_B_CBL CF_C_CBL CF_D_CBL CF_E_CBL CF_F_CBL ;
global CF_S_LD1 CF_S_LD2 CF_S_LD3 CF_E_S_LD1 CF_E_S_LD2 CF_E_S_LD3 CF_CF_MSE1 CF_CF_MSE2 CF_CF_MSE3;
%��ȡ�������ݵĸ���
CF_LEN = length(u);                   %ͼֽ��ά��������ΪCF_LEN
%ͼֽ���ۼƺϲ�
CF_u = [CF_u, u];
CF_v = [CF_v, v];
%ͼֽ�����Ƶ�(u7,v7)��ת10�㣬ƽ��(30-u(7),40-v(7))���õ������㣨�̵㣩����
X_GREEN = (u-u(7)).* cos(pi/36) - (v-v(7)).* sin(pi/36) + 30;
Y_GREEN = (u-u(7)).* sin(pi/36) + (v-v(7)).* cos(pi/36) + 40;
%�������ۼƺϲ�
CF_X_GREEN = [CF_X_GREEN, X_GREEN];
CF_Y_GREEN = [CF_Y_GREEN, Y_GREEN];
%��ÿ�����л�����ģ�⡾���������
theat = 2 * pi *rand(1,CF_LEN);               %ָ��CF_LEN����[0��2��)������Ƕ�ֵtheat
r = 0.5 * rand(1,CF_LEN);                     %ָ��CF_LEN����[0.5)������뾶ֵ
%�����л�����ģ��������������ѡȡ���е�ģ���������Ϊʵ�ʲ����㣬��ִ�з���
%�õ�ģ��������꣬����㼯��
X_RED = X_GREEN + r.*cos(theat);
Y_RED = Y_GREEN + r.*sin(theat);
%ģ��������ۼƺϲ�
CF_X_RED = [CF_X_RED, X_RED];
CF_Y_RED = [CF_Y_RED, Y_RED];

%�������ѡȡ2����㼰���Ӧ�ĺڵ㣬����µ���תƽ�Ʋ������õ���ɫ�㼯��
%ѡȡ��5����7����(u(5),v(5)),(u(7),v(7))����7Ϊ��ת����;(X_RED(5),Y_RED(5)),(X_RED(7),Y_RED(7))
%����ʹ�þ��������ת����THEAT
CF_RED1 = randperm(CF_LEN);    %����1����������CF_LEN���������е����ظ����������
CF_RED = CF_RED1(1:2);
P = CF_RED(1);                %���ѡȡ�õ���ת��P
Q = CF_RED(2);                %���ѡȡ�õ���ת���ĵ�Q����P��Q����ͬһ��

% P = 1;                %���ѡȡ�õ���ת��P
% Q = 2;                %���ѡȡ�õ���ת���ĵ�Q����P��Q����ͬһ��


L_CHOOSE1 = [Q; u(Q); v(Q); P; u(P); v(P)];
%�������ѡ������
CF_CHOOSE1 = [CF_CHOOSE1, L_CHOOSE1];
T_A = [(u(P)-u(Q)), -(v(P)-v(Q)); (v(P)-v(Q)), (u(P)-u(Q))];
T_b = [X_RED(P)-X_RED(Q); Y_RED(P)-Y_RED(Q)];
T_cosxsiny = T_A\T_b;
T_cosxsiny = T_cosxsiny';
THEAT = atan(T_cosxsiny(2)/T_cosxsiny(1));          %����THEAT��Ϊ�µ���ת�ǣ��µ�ƽ������Ϊ(X_RED(7)-u(7),Y_RED(7)-v(7))
%���ۼƷ�ʽ������תƽ�Ʒ�����Ҫ����
CF_THEAT = [CF_THEAT, THEAT];
CF_X_XP = [CF_X_XP, X_RED(Q)-u(Q)];
CF_Y_XP = [CF_Y_XP, Y_RED(Q)-v(Q)];
L_RX = [u(Q); THEAT ; v(Q); THEAT; X_RED(Q)];
L_RY = [u(Q); THEAT ; v(Q); THEAT; Y_RED(Q)];
CF_X_XP_CBL = [CF_X_XP_CBL, L_RX];
CF_Y_XP_CBL = [CF_Y_XP_CBL, L_RY];
%����ͼֽ���꣬�õ�����1�е���תƽ�����꣬�����㼯��
X_BLUE = (u-u(Q)).* cos(THEAT) - (v-v(Q)).* sin(THEAT) + X_RED(Q);
Y_BLUE = (u-u(Q)).* sin(THEAT) + (v-v(Q)).* cos(THEAT) + Y_RED(Q);
%��תƽ�Ƶ��ۼƺϲ�
CF_X_BLUE = [CF_X_BLUE, X_BLUE];
CF_Y_BLUE = [CF_Y_BLUE, Y_BLUE];

%�����С���˷���6���α���a,b,c,d,e,f
n = 9;                                           %ָ��ѡ��n�����������ڼ�����С���˷��Ĳα���
%n��ֵ��ϵ���ļ��������ȷ�ԣ�Ҫ��Ӧ�ģ���
fid=fopen('IMP_DATAS.txt', 'at');  
fprintf(fid,'��תƽ�Ʒ�ѡ��2����������㣬��С���˷�ѡ��%d����������㣬�õ��������ݣ�\n', n);
fclose(fid);

%���ѡȡ��С���˷��������ѡȡn����
%SJ_MAGENTA = randperm(CF_LEN);
%SJ_MAGENTA = SJ_MAGENTA(1:n);                    %�õ�һ�����ѡȡn������������
% CF_RED1 = [4 50 80 189];

SJ_MAGENTA = CF_RED1(1:n);
L_CHOOSE2 = [SJ_MAGENTA; u(SJ_MAGENTA); v(SJ_MAGENTA)];  %����һ��3*n�ľ���
L_CHOOSE2 = reshape(L_CHOOSE2,3*n,1);             %�任Ϊ(3*n)*1�ľ���
%�������ѡ������
CF_CHOOSE2 = [CF_CHOOSE2, L_CHOOSE2];

SJ_X_RED = X_RED(SJ_MAGENTA);                    %�õ����ѡȡ��n������������
SJ_Y_RED = Y_RED(SJ_MAGENTA);                    %��ָ��Ϊȫ�ֱ�����������ѡȡ�Ĳ�������������
CF_MAGENTA_u = u(SJ_MAGENTA);                    %�õ��Ķ�Ӧ��n��ͼֽ����
CF_MAGENTA_v = v(SJ_MAGENTA); 

%������С���˷��α������󷽳�
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
XS = [A B C; B E F; C F n];                     %ϵ������Ϊ3x3
XCXS = [D; G; H];                               %X�鳣������Ϊ3x1
YCXS = [I; J; K];                               %Y�鳣������Ϊ3x1
%�����󷽳̵õ��α��������
CBL_X = XS\XCXS;                                %���x��α�������3x1
CBL_Y = XS\YCXS;                                %���y��α�������3x1

%���ۼƷ�ʽ������С���˷�������Ҫ����
CF_A_CBL = [CF_A_CBL, CBL_X(1)];
CF_B_CBL = [CF_B_CBL, CBL_X(2)];
CF_C_CBL = [CF_C_CBL, CBL_X(3)];
CF_D_CBL = [CF_D_CBL, CBL_Y(1)];
CF_E_CBL = [CF_E_CBL, CBL_Y(2)];
CF_F_CBL = [CF_F_CBL, CBL_Y(3)];
%������С���˷�������ϵ�õ���С�����Ż������꣬���Ϻ��
X_MAGENTA = CBL_X(1).*u + CBL_X(2).*v + CBL_X(3);
Y_MAGENTA = CBL_Y(1).*u + CBL_Y(2).*v + CBL_Y(3);
CF_X_MAGENTA = [CF_X_MAGENTA, X_MAGENTA];
CF_Y_MAGENTA = [CF_Y_MAGENTA, Y_MAGENTA];

%����תƽ�Ʒ���������С���˷��������о�������ѧ�����;�������ֵ����
S_LD1 = sqrt((X_BLUE - X_GREEN).^2 + (Y_BLUE - Y_GREEN).^2);   %������1*219
S_LD2 = sqrt((X_MAGENTA - X_GREEN).^2 + (Y_MAGENTA - Y_GREEN).^2);
S_LD3 = sqrt((X_RED - X_GREEN).^2 + (Y_RED - Y_GREEN).^2);

%���ۼƷ�ʽ�õ�ʵ��ȫ�����������
CF_S_LD1 = [CF_S_LD1, S_LD1];        %������1*(L*219)   
CF_S_LD2 = [CF_S_LD2, S_LD2];
CF_S_LD3 = [CF_S_LD3, S_LD3];
%��ÿ�����ѧ�����;�����
E_S_LD1 = sum(S_LD1,2)/(CF_LEN);
E_S_LD2 = sum(S_LD2,2)/(CF_LEN);
E_S_LD3 = sum(S_LD3,2)/(CF_LEN);
CF_MSE1 = sqrt(sum((S_LD1 - E_S_LD1).^2,2)/(CF_LEN));
CF_MSE2 = sqrt(sum((S_LD2 - E_S_LD2).^2,2)/(CF_LEN));
CF_MSE3 = sqrt(sum((S_LD3 - E_S_LD3).^2,2)/(CF_LEN));
%���ۼƷ�ʽ�������ַ����е���ѧ�����;�����
CF_E_S_LD1 = [CF_E_S_LD1, E_S_LD1];
CF_E_S_LD2 = [CF_E_S_LD2, E_S_LD2];
CF_E_S_LD3 = [CF_E_S_LD3, E_S_LD3];
CF_CF_MSE1 = [CF_CF_MSE1, CF_MSE1];
CF_CF_MSE2 = [CF_CF_MSE2, CF_MSE2];
CF_CF_MSE3 = [CF_CF_MSE3, CF_MSE3];

%��Ҫ���ݱ�����IMP_DATAS�У��Է��ۼƷ�ʽ���������д�ļ���ʽ��������������ļ��еı���
IMP_DATAS = [E_S_LD1; CF_MSE1; E_S_LD2; CF_MSE2; E_S_LD3; CF_MSE3];
fid=fopen('IMP_DATAS.txt', 'at');  
fprintf(fid, '��תƽ�Ʒ���\n\t\t��ѧ����E_S_LD1=%-8.4f\t\t\t ������CF_MSE1=%-8.4f\n��С���˷���\n\t\t��ѧ����E_S_LD2=%-8.4f\t\t\t ������CF_MSE2=%-8.4f\nֱ�Ӳ�������\n\t\t��ѧ����E_S_LD3=%-8.4f\t\t\t ������CF_MSE3=%-8.4f\n', IMP_DATAS);
fclose(fid);

% %��4��ͼ�����ַ�����չʾЧ���Ϻã��������ڳ���ִ��
% figure(1);
% subplot(2,2,1);
% grid on;
% hold on;
% axis 'equal';
% title('ͼ1  ͼֽ���������ͼ��');
% plot(u,v,'-ko',X_GREEN,Y_GREEN,'-go');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Block pot','\fontsize{14}\it Green pot');
% 
% subplot(2,2,2);
% grid on;
% hold on;
% axis 'equal';
% title('ͼ2  ͼֽ���������ͼ��');
% plot(u,v,'-ko',X_RED,Y_RED,'-ro');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Block pot','\fontsize{14}\it Red pot');
% 
% subplot(2,2,3);
% grid on;
% hold on;
% axis 'equal';
% title('ͼ3  ����������תƽ�Ƶ�ͼ��');
% plot(X_GREEN,Y_GREEN,'-.go',X_BLUE,Y_BLUE,'-bo');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Green pot','\fontsize{14}\it Blue pot');
% 
% subplot(2,2,4);
% grid on;
% hold on;
% axis 'equal';
% title('ͼ4  ��С���˵�����תƽ�Ƶ����ͼ��');
% plot(X_GREEN,Y_GREEN,'-.go',X_MAGENTA,Y_MAGENTA,'-mo');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it Green pot','\fontsize{14}\it Magenta pot');

% ��5.1.1 ��ͼ������
% ɫ���ַ���ɫ�����ַ����͸�ʽ��Ƿ������ݵ���ʽ��Ƿ������ݵ���ʽ
% y ��  -  ʵ��        . ��      <С�ں�
% m ��  �� ����        o Բ      s������
% c ��  -. �㻮��      x ���    d ����
% r ��  - - ����       + �Ӻ�    h������
% g ��  * �Ǻ�         p�����
% b ��  v ����������
% w ��  ^ ����������
% k ��  > ���ں�

%��4��ͼ�����ַ�����չʾЧ���ϲ���Ǻܷ������ִ�У�ʵ������ʱ�������ַ���
figure(1);
hold on;
grid on;
axis 'equal';
title('ͼ1  ͼֽ���������ͼ��');
plot(u,v,'-ko','MarkerFaceColor','k');
plot(X_GREEN,Y_GREEN,'-go','MarkerFaceColor','g')
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it ͼֽ��','\fontsize{14}\it ������');

figure(2);
hold on;
grid on;
axis 'equal';
title('ͼ2  �������������ͼ��');
plot(X_GREEN,Y_GREEN,'-go','MarkerFaceColor','g');
plot(X_RED,Y_RED,'-ro','MarkerFaceColor','r');
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it ������','\fontsize{14}\it ������');

figure(3);
hold on;
grid on;
axis 'equal';
title('ͼ3  ����������תƽ�Ƶ�ͼ��');
plot(X_GREEN,Y_GREEN,'-.go','MarkerFaceColor','g');
plot(X_BLUE,Y_BLUE,'-bo','MarkerFaceColor','b');
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it ������','\fontsize{14}\it ��תƽ�Ƶ�');

figure(4);
hold on;
grid on;
axis 'equal';
title('ͼ4  ����������С���˵����ͼ��');
plot(X_GREEN,Y_GREEN,'-.go','MarkerFaceColor','g');
plot(X_MAGENTA,Y_MAGENTA,'-mo','MarkerFaceColor','m')
set(get(gca,'YLabel'),'String','Y','FontSize',15);
set(get(gca,'XLabel'),'String','X','FontSize',15);
legend('\fontsize{14}\it ������','\fontsize{14}\it ��С���˵�');
hold off;

% %toc;
% L = L - 1;
% if  L ~= 0
%    CF_MSE(u,v,L);  %�ݹ���ò��ܸ���������ѭ�������ܣ��ҶԺ������õĲ�����������Ҫ�Ķ�ջ�ռ�Ҳ�����޵ģ�
%    return;
% end
return;