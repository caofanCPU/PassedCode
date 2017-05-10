function h=implicitsurf(f,xlimit,ylimit,zlimit,gd)
%implicitsurf(f,span,gd):画隐函数曲面f(x,y,z)=0的网格图,
%                          各坐标范围均限定在span=[lb,ub],
%                          网格数为gd，默认为25
%implicitsurf(f,xspan,yspan,zspan,gd):画隐函数曲面f(x,y,z)=0,
%                          各坐标范围分别限定在xspan,yspan,zspan
%h=implicitsurf(...)：画隐函数曲面并输出句柄
%例一：
%implicitsurf(inline('x.*y+z.^2'),[-5 5])%注意*\^一定要设成点运算
%例二：
%f=@(x,y,z)x.^2+y.^2+0*z-1;%注意如果f中不含某个变量一定要加上诸如0*y的项。
%implicitsurf(f,[-1 1],10)
%例三：
%f=@(x,y,z)(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3;
%g=@(x,y,z)(sqrt(x.^2+y.^2)-2).^2+z.^2-.09;
%h=implicitsurf(f,[-1.5 1.5],[-.8 .8],[-1.5 1.5],50);
%set(h,'AmbientStrength',.5);%可以设置各种效果
%hold on%可以添加图形
%h=implicitsurf(g,[-2.3,2.3],[-2.3,2.3],[-.3,.3]);
%colormap hsv;set(h,'AmbientStrength',.8,'FaceAlpha',.5);%可以设置各种效果
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