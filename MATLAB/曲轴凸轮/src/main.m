function main()
close all;
clear all;
warning off;
clc;
global y s r a b c Theta1 Theta2;
y=0; 
s=0;      %y,s�����洢�������������Ϣ,�����ĵ�����
disp('����ĥɰ��ĥ���������漴����ʼ��Ĭ�ϰ뾶��Ϣ��[R1,R2,R3]=[22.4,10.3,34.5]');
r=[22.4,10.3,34.5];
a=r(2)+r(3);
c=r(1)-r(2);
b=0;
Theta1=-1;                    %����ѭ�����еĹ���Theta1�ı��ʽȷ�����̬Ϊ-1���ÿ��Դ�0��ʼ        
Theta2=0;                      %��ʼ��ȫ�ֱ���
clc
disp('���潫չʾTheta1Ϊ�Ա���ʱ����ĥ͹��ĥ��̬��ʾ��')
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
    %����Theta1������������ѭ���Լ�1��ԭ�򣿣���������
    %��ԭ��ΪPICTURE������������Theta1��ֵ�ɽǶ�ֵ��Ϊ����ֵ
    %�ٴν���forѭ��ʱTheta1��ֵ���������
end
fid=fopen('Question1.txt', 'wt');  
fprintf(fid, 'Theta1=%-8.4f Theta2=%-8.4f Zo3=%-6.3f Px_z=(%6.3f,%-6.3f)\n', y);
fclose(fid);
clc
disp('����1��������ݱ�����ϣ�5����������2�������̺ͽ�����棡')
pause(5)           %ͣ��5��

clc
clf
b=0;
Theta1=0;
Theta2=-1;         %����ѭ�����еĹ���Theta1�ı��ʽȷ�����̬Ϊ-1���ÿ��Դ�0��ʼ
disp('���潫չʾTheta2Ϊ�Ա���ʱ����ĥ͹��ĥ��̬��ʾ��\n')
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
%toc;     %��tic�������ڼ����������ʱ�䣬ע�����������˳�򣡣�
clear all;
return;