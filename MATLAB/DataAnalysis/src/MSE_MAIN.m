function MSE_MAIN()
warning off all;
%����׶�λ��С���˷�������
%�������뷽������Ҫ���ݴ洢ȫ�ֱ���
%          ͼֽ�����ꡢ���������ꡢ�������������ꡢ��תƽ�Ƶ����ꡢ��С���˵����ꡢ��������
%          ��ת�ǡ�ƽ��������תƽ�Ʒ��α�������ƽ����������
%          ��С���˷��α���
%          ÿ��������̵õ��ľ������ѧ����������������
tic;
global CF_u CF_v CF_X_GREEN CF_Y_GREEN CF_X_RED CF_Y_RED CF_X_BLUE CF_Y_BLUE CF_X_MAGENTA CF_Y_MAGENTA CF_LEN; 
global CF_CHOOSE1 CF_CHOOSE2 CF_THEAT CF_X_XP CF_Y_XP CF_X_XP_CBL CF_Y_XP_CBL ;
global CF_A_CBL CF_B_CBL CF_C_CBL CF_D_CBL CF_E_CBL CF_F_CBL ;
global CF_S_LD1 CF_S_LD2 CF_S_LD3 CF_E_S_LD1 CF_E_S_LD2 CF_E_S_LD3 CF_CF_MSE1 CF_CF_MSE2 CF_CF_MSE3;
global u v L;
%��ȫ�����뷽������Ҫ���ݴ洢ȫ�ֱ�����ʼ��Ϊ�վ���
CF_u = []; CF_v = []; CF_X_GREEN = []; CF_Y_GREEN = []; CF_X_RED = []; CF_Y_RED = [];  CF_X_BLUE = []; CF_Y_BLUE = []; CF_X_MAGENTA = []; CF_Y_MAGENTA = []; 
CF_CHOOSE1 = []; CF_CHOOSE2 = []; CF_THEAT = []; CF_X_XP = []; CF_Y_XP = []; CF_X_XP_CBL = []; CF_Y_XP_CBL = [];
CF_A_CBL = []; CF_B_CBL = []; CF_C_CBL = []; CF_D_CBL = []; CF_E_CBL = []; CF_F_CBL = [] ;
CF_S_LD1 = []; CF_S_LD2 = []; CF_S_LD3 = []; CF_E_S_LD1 = []; CF_E_S_LD2 = []; CF_E_S_LD3 = []; CF_CF_MSE1 = []; CF_CF_MSE2 = []; CF_CF_MSE3 = [];

%��ȡͼֽ�����ļ�����ͼֽ����.txt��
fid = fopen('��ͼֽ����.txt','r');
s = fscanf(fid,'%*c%f %*c%f ',[2 inf]);     
fclose(fid);
u = s(1,:);
v = s(2,:);
save CF_ZUOBIAOXP.mat s u v;           %�õ�ͼֽ��ά����{��u,v��}�������ڡ�CF_ZUOBIAO.mat���ļ���
% MSE_MAIN
% Elapsed time is 15.662000 seconds.  1000��
% >> MSE_MAIN
% Elapsed time is 350.111000 seconds.  5000��
% >> MSE_MAIN
% Elapsed time is 354.651000 seconds.   5000��
rand('state',sum(100*clock));            %��ʼ��������ӣ�������ʱ��仯ȫ�������
L=1;                                  %����L�����������
% set(0,'RecursionLimit',5002);          %���õݹ�����������ȣ�����ջ�ռ䣬Ĭ��Ϊ500
% CF_MSE(u,v,L);
for i=1:1:L
    CF_MSE(u,v);
end

%ģ����������������̶ȷ���
%��������ķ�����
%       ��Ŀ��ģ�������ͳ�Ƶ����ݵ㣬��������Ϻ�㣬���Ӧ�������������̵㣬���Ӧ��ľ����ֱ�õ�������������CF_S_LD1��CF_S_LD2��CF_S_LD3
%       ����CF_S_LD1��CF_S_LD2��CF_S_LD3������ͼ���жԱȷ���������ÿ���������ݵ���ѧ�����;������ͼ�κ������������жϷ����Ŀ�����������
y = [CF_S_LD1; CF_S_LD2;CF_S_LD3];
%y=y';
%�������ַ�������ѧ�����ͷ���
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
% t = 1:1:CF_LEN*L;                      %��ĸ���*����������̵�ѭ������
% plot(t,CF_S_LD1,'-bo',t,CF_S_LD2,'-mo',t,CF_S_LD3,'-ro');
% 
% bar(y',0.5);
% title('ͼ5  ��С���˷�������תƽ�Ʒ���������ͼ��');
% set(get(gca,'YLabel'),'String','Y','FontSize',15);
% set(get(gca,'XLabel'),'String','X','FontSize',15);
% legend('\fontsize{14}\it ��תƽ�Ʒ����������ͼ','\fontsize{14}\it ��С���˷����������ͼ','\fontsize{14}\it ʵ�ʲ��������������ͼ','\fontsize{14}\it ��תƽ�Ʒ������ֱ��ͼ','\fontsize{14}\it ��С���˷������ֱ��ͼ','\fontsize{14}\it  ʵ�ʲ������������ֱ��ͼ');
CF_ALL_XY = [CF_u;CF_v;CF_X_RED;CF_Y_RED;CF_X_BLUE;CF_Y_BLUE;CF_X_GREEN;CF_Y_GREEN;CF_X_MAGENTA;CF_Y_MAGENTA];
CF_ALL_CBL1 = [CF_CHOOSE1; CF_THEAT; CF_X_XP; CF_Y_XP; CF_X_XP_CBL; CF_Y_XP_CBL];
CF_ALL_CBL2 = [CF_CHOOSE2; CF_A_CBL; CF_B_CBL; CF_C_CBL; CF_D_CBL; CF_E_CBL; CF_F_CBL];
IMP_DATAS = [CF_E_S_LD1; CF_CF_MSE1; CF_E_S_LD2; CF_CF_MSE2; CF_E_S_LD3; CF_CF_MSE3];
fid=fopen('IMP_DATAS.txt', 'at');  
fprintf(fid, '>>>>>>>>>>>>>>>>>>>>>>>>>>\n��תƽ�Ʒ���\n\t������ѧ����E_S_LD1=%-8.4f\t\t ���վ�����CF_MSE1=%-8.4f\n��С���˷���\n\t������ѧ����E_S_LD2=%-8.4f\t\t ���վ�����CF_MSE2=%-8.4f\nֱ�Ӳ�������\n\t������ѧ����E_S_LD3=%-8.4f\t\t ���վ�����CF_MSE3=%-8.4f\n<<<<<<<<<<<<<<<<', IMP_DATAS);
fclose(fid);

%����������ɫ��Ķ�ά���������ļ���TuZhiZuoBiao.txt��
% fid=fopen('TuZhiZuoBiao.txt', 'wt');  
% fprintf(fid, '�ڵ�����(%-7.3f,%7.3f)���������(%-7.3f,%7.3f)����������(%-7.3f,%7.3f)���̵�����(%-7.3f,%7.3f)���Ϻ������(%-7.3f,%7.3f)\n', CF_ALL_XY);
% fclose(fid);

%��������1��������Ҫ������������ϵ�����ļ���1_SheXiangFangAn_CBL.txt��
% fid=fopen('1_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '���뷽��1��:ѡȡ��ת���ģ�ͼֽ��1��š�%-3d�㡱\t���꣺(%-8.4f��%8.4f)\tѡȡ��ת�㣺ͼֽ��2��š�%-3d�㡱\t���꣺(%-8.4f��%8.4f)\n��ת�ǣ���=%-8.4f ��ƽ������(%-8.4f��%8.4f)\n\t\tx=(u-(%-8.4f))*cos(%-8.4f)-(v-(%-8.4f))*sin(%-8.4f)+(%-8.4f)\n\t\ty=(u-(%-8.4f))*sin(%-8.4f)+(v-(%-8.4f))*cos(%-8.4f)+(%-8.4f)\n', CF_ALL_CBL1);
% fclose(fid);

%%%%%%%%%%%%ɾ������
% fid=fopen('1_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '���뷽��1��:ѡȡ��ת���ģ�ͼֽ��1��š�%-3d�㡱\t���꣺(%-8.4f��%8.4f)\tѡȡ��ת�㣺ͼֽ��2��š�%-3d�㡱\t���꣺(%-8.4f��%8.4f)\n', CF_CHOOSE1);
% fclose(fid);

%��������2��������Ҫ������������ϵ�����ļ���2_SheXiangFangAn_CBL.txt��
% fid=fopen('2_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '���뷽��2��:\nͼֽ��1��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��2��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��3��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��4��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��5��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��\nͼֽ��6��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��7��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��8��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��9��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��\n\t\t������С���˷�������ϵΪ��\n\t\t\tx=(%-8.4f)*u +(%-8.4f)*v + (%-8.4f)\n\t\t\ty=(%-8.4f)*u +(%-8.4f)*v + (%-8.4f)\n', CF_ALL_CBL2);
% fclose(fid);

%%%%%%%%%%%%%%%%%%%%ɾ������
% fid=fopen('2_SheXiangFangAn_CBL.txt', 'wt');  
% fprintf(fid, '���뷽��2��:\nͼֽ��1��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��2��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��3��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��4��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��5��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��\nͼֽ��6��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��7��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��8��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��ͼֽ��9��š�%-3d�㡱�����꣺(%-8.4f��%8.4f)��\n', CF_CHOOSE2);
% fclose(fid);

%�������ַ�����������������ľ���������ļ���S_LD.txt��
% fid=fopen('S_LD.txt', 'wt');  
% fprintf(fid, '��תƽ�Ƶ����\t(%-8.4f)\t����С���˵����\t(%-8.4f)\t������������\t(%-8.4f)\n', y);
% fclose(fid);
toc
return;