function Chromosome()
%��άȾɫ���룺
figure('menubar','none','numbertitle','off','name','ʨ�ӵ�&����ʨ');
f=@(x,y,z)(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3;
g=@(x,y,z)(sqrt(x.^2+y.^2)-2).^2+z.^2-.09;
implicitmesh(f,[-1.5 1.5],[-.8 .8],[-1.5 1.5],50);
hold on%�������ͼ��
h=implicitmesh(g,[-2.3,2.3]);
colormap hsv;set(h,'facecolor','none');%�������ø���Ч��
axis off;axis equal;
figure('menubar','none','numbertitle','off','name','ʨ�ӵ�&����ʨ');
f=@(x,y,z)(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3;
g=@(x,y,z)(sqrt(x.^2+y.^2)-2).^2+z.^2-.09;
h=implicitsurf(f,[-1.5 1.5],[-.8 .8],[-1.5 1.5],50);
set(h,'AmbientStrength',.5);%�������ø���Ч��
hold on%�������ͼ��
h=implicitsurf(g,[-2.3,2.3],[-2.3,2.3],[-.3,.3]);
colormap hsv;set(h,'AmbientStrength',.8,'FaceAlpha',.5);%�������ø���Ч��
axis off;axis equal;shading interp;camlight;lighting gouraud;

%MATLAB eig�������õ�����������ֻ��������������������Ҫ��������������λ����õ����ƺ�ͬ����
end