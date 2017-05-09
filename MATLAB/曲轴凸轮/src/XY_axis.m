function XY_axis(D_IFM)
%�˺���ר��������һ��figureͼ�л���X-O-Yֱ������ϵ

%�������ԣ���ͷ�ױ߾�2*O-X����2*O-YѡΪ�����ᵥλ�̶ȵ�1/10��1/5ʱ��ͷЧ���Ϻ�
%�����ᵥλ�̶Ƚϴ󣬼�ͷ��б��ϵѡȡû��Ҫ�࣬ȡ[2.0,2.5,3.0]���㹻��
%�����ᵥλ�̶Ƚ�С����ͷ��б��ϵ�ʵ�ѡȡ��һЩ��ȡ[2.0,2.1,2.3,2.5,2.7,2.9,3.0]
%��Ҫ�ǻ��ڴ���ͷ�������������߶Σ���ԭ�㣬��ͷ���������ע
% D_IFM��������ȷ�����������㷶ʽ��Ϣ
% D_IFM=[ArrowX_minx ArrowX_miny,ArrowY_minx ArrowY_miny, ArrowX_max, ArrowY_max, ML_X, MD_Y];
%����Щ�������棬���������¹�ϵʽ������
% ArrowX_minx+3*ArrowX_miny=ArrowX_max;
% ArrowY_miny+3*ArrowY_minx=ArrowY_max;
%����D_IFM=[xB yA, xA yB, xM, yM, MLX, MDY],
%�����㷶ʽ��ͷ����Ϊ X:(xB,-yA)-(xM,0)(xB,yA) Y:(-xA,yB)-(0,yM)-(xA,yB)
ArrowX_minx=D_IFM(1);
ArrowX_miny=D_IFM(2);
ArrowY_minx=D_IFM(3);
ArrowY_miny=D_IFM(4);
ArrowX_max=D_IFM(5);
ArrowY_max=D_IFM(6);
ML_X=D_IFM(7);            %�趨ͼ�εķ�Χ��X�������
MD_Y=D_IFM(8);            %�趨ͼ�εķ�Χ��Y�����¶�

%��X-Y��
%��ͼ�ʼ����һ������ hold on ��䣬�����Ż����룬��߳�������Ч��
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

%��Y�������ͷ
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
%��X�������ͷ
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

%��X-O-Y����ϵ���б�ע
text(-3,-2,'O','FontSize',16);
text(ArrowX_max-3,-2,'X','FontSize',16);
text(1,ArrowY_max-2,'Y','FontSize',16);
clear ArrowX_minx ArrowX_miny ArrowY_minx ArrowY_miny ArrowX_max ArrowY_max ML_X MD_Y
clear D_IFM;