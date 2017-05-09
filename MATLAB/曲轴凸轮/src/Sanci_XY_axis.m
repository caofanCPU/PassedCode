function Sanci_XY_axis(D_IFM)
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
axis 'equal';
axis ([ML_X ArrowX_max,MD_Y ArrowY_max]);
hold on;
x=ML_X:0.05:ArrowX_max;
y=x-x;
plot(x,y,'-k');
clear x y;
y=MD_Y:0.05:ArrowY_max;
x=y-y;
axis 'equal';
axis ([ML_X ArrowX_max,MD_Y ArrowY_max]);
plot(x,y,'-k');
hold on;
clear x y;
%��Y�������ͷ
x=0:-0.01:-ArrowY_minx;
x1=x+ArrowY_minx;
y=2*x1+ArrowY_miny;
y=[y,2.1*x1+ArrowY_miny];
y=[y,2.3*x1+ArrowY_miny];
y=[y,2.5*x1+ArrowY_miny];
y=[y,2.7*x1+ArrowY_miny];
y=[y,2.9*x1+ArrowY_miny];
y=[y,3*x1+ArrowY_miny];
x=[x,x,x,x,x,x,x];
plot(x,y,'-k');
clear x x1 y;
x=0:0.01:ArrowY_minx;
x1=x-ArrowY_minx;
y=(-2)*x1+ArrowY_miny;
y=[y,(-2.1)*x1+ArrowY_miny];
y=[y,(-2.3)*x1+ArrowY_miny];
y=[y,(-2.5)*x1+ArrowY_miny];
y=[y,(-2.7)*x1+ArrowY_miny];
y=[y,(-2.9)*x1+ArrowY_miny];
y=[y,(-3)*x1+ArrowY_miny];
x=[x,x,x,x,x,x,x];
plot(x,y,'-k');
clear x x1 y;
%��X�������ͷ
y=0:0.01:ArrowX_miny;
y1=y-ArrowX_miny;
x=(-2)*y1+ArrowX_minx;
x=[x,(-2.1)*y1+ArrowX_minx];
x=[x,(-2.3)*y1+ArrowX_minx];
x=[x,(-2.5)*y1+ArrowX_minx];
x=[x,(-2.7)*y1+ArrowX_minx];
x=[x,(-2.9)*y1+ArrowX_minx];
x=[x,(-3)*y1+ArrowX_minx];
y=[y,y,y,y,y,y,y];
plot(x,y,'-k');
clear x y1 y;
y=0:-0.01:-ArrowX_miny;
y1=y+ArrowX_miny;
x=2*y1+ArrowX_minx;
x=[x,2.1*y1+ArrowX_minx];
x=[x,2.3*y1+ArrowX_minx];
x=[x,2.5*y1+ArrowX_minx];
x=[x,2.7*y1+ArrowX_minx];
x=[x,2.9*y1+ArrowX_minx];
x=[x,3*y1+ArrowX_minx];
y=[y,y,y,y,y,y,y];
plot(x,y,'-k');
clear x y1 y;
%��X-O-Y����ϵ���б�ע
text(-0.10,-0.10,'O','FontSize',16);
text(ArrowX_max-0.1,-0.10,'X','FontSize',16);
text(0.05,ArrowY_max-0.05,'Y','FontSize',16);
clear ArrowX_minx ArrowX_miny ArrowY_minx ArrowY_miny ArrowX_max ArrowY_max ML_X MD_Y
clear D_IFM;

%�����Ҫ��ע����ϵ�̶ȣ��������д��޸Ĵ���
% clc;
% tic;
% x=-1.25:0.25:3.5; y=-1.25:0.25:1.6;%ָ�������᷶Χ
% axis off;  %��ȥ���ܱ߿�
% hold on;
% plot([0,0],[min(y) max(y)],'k',[min(x) max(x)],[0 0],'k'); % ǰ�벿�ֱ�ʾx��������[0,0]��y��������[min,max]�������� 
% ax=[max(x),max(x)-0.1,max(x)-0.1;0,0.03,-0.03]; %axΪ2*2����
% fill(ax(1,:),ax(2,:),'k');  %ax(1,:)��ʾ����ax��һ������Ԫ��
% ay=[0,0.03,-0.03;max(y),max(y)-0.1,max(y)-0.1];
% fill(ay(1,:),ay(2,:),'k');       %�����ͷ�������
% hold on
% for i=1:length(x)-1  %ע��i���1��ʼ����Ϊ�������꽻��0����0�̶�ֵֻ�軭һ��
%     if x(i)~=0  %x(i)ֵΪx�ĵ�iλԪ��ֵ
%          plot([x(i),x(i)],[0,0.03],'k'); hold on  %���̶���
%          a=text(x(i),-0.08,num2str(x(i)));       %���̶�ֵ��-0.08Ϊ�̶�ֵ������ƫ����
%          set(a,'HorizontalAlignment','center');  %HorizontalAlignment��Ϊˮƽ���룬��set()��Ϊ��''�е�����ȫ��Ӧ�õ�c
%          end
% end
% % text(max(x),-0.1,'X');
% for i=1:length(y)-1 
%     if y(i)~=0
%         plot([0,0.03],[y(i),y(i)],'k'); hold on
%         b=text(-0.08,y(i),num2str(y(i)));
%         set(b,'HorizontalAlignment','center'); 
%     end
% end
% text(-0.1,max(y),'Y');
% c=text(-0.008,-0.08,num2str(0));  %����0�̶�ֵ
% set(c,'HorizontalAlignment'); 
% toc;
% pause()
% text(-0.10,-0.10,'O','FontSize',16);
% text(ArrowX_max-0.1,-0.10,'X','FontSize',16);
% text(0.05,ArrowY_max-0.05,'Y','FontSize',16);