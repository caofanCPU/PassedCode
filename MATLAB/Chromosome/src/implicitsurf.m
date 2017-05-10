function h=implicitsurf(f,xlimit,ylimit,zlimit,gd)
%implicitsurf(f,span,gd):������������f(x,y,z)=0������ͼ,
%                          �����귶Χ���޶���span=[lb,ub],
%                          ������Ϊgd��Ĭ��Ϊ25
%implicitsurf(f,xspan,yspan,zspan,gd):������������f(x,y,z)=0,
%                          �����귶Χ�ֱ��޶���xspan,yspan,zspan
%h=implicitsurf(...)�������������沢������
%��һ��
%implicitsurf(inline('x.*y+z.^2'),[-5 5])%ע��*\^һ��Ҫ��ɵ�����
%������
%f=@(x,y,z)x.^2+y.^2+0*z-1;%ע�����f�в���ĳ������һ��Ҫ��������0*y���
%implicitsurf(f,[-1 1],10)
%������
%f=@(x,y,z)(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3;
%g=@(x,y,z)(sqrt(x.^2+y.^2)-2).^2+z.^2-.09;
%h=implicitsurf(f,[-1.5 1.5],[-.8 .8],[-1.5 1.5],50);
%set(h,'AmbientStrength',.5);%�������ø���Ч��
%hold on%�������ͼ��
%h=implicitsurf(g,[-2.3,2.3],[-2.3,2.3],[-.3,.3]);
%colormap hsv;set(h,'AmbientStrength',.8,'FaceAlpha',.5);%�������ø���Ч��
%axis off;axis equal;shading interp;camlight;lighting gouraud;
if nargin==2
    ylimit=xlimit;zlimit=xlimit;gd=25;
elseif nargin==3
    gd=ylimit;ylimit=xlimit;zlimit=xlimit;
elseif nargin==4
    gd=25;
elseif nargin==5
else
    error('Error in input arguments')
end
x=linspace(xlimit(1),xlimit(2),gd);
y=linspace(ylimit(1),ylimit(2),gd);
z=linspace(zlimit(1),zlimit(2),gd); 
[x,y,z]=meshgrid(x,y,z);val=f(x,y,z);
[f,v]=isosurface(x,y,z,val,0);
if isempty(f)
    warning('There is no graph in the range.');
    p=[];
else
    newplot;
    p=patch('Faces',f,'Vertices',v,'CData',v(:,3),'facecolor','flat','EdgeColor','k');
    isonormals(x,y,z,val,p);view(3);grid on
end
if nargout==0
else
    h=p;
end