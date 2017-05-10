function Chromosome()
%三维染色代码：
figure('menubar','none','numbertitle','off','name','狮子蝶&蝴蝶狮');
f=@(x,y,z)(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3;
g=@(x,y,z)(sqrt(x.^2+y.^2)-2).^2+z.^2-.09;
implicitmesh(f,[-1.5 1.5],[-.8 .8],[-1.5 1.5],50);
hold on%可以添加图形
h=implicitmesh(g,[-2.3,2.3]);
colormap hsv;set(h,'facecolor','none');%可以设置各种效果
axis off;axis equal;
figure('menubar','none','numbertitle','off','name','狮子蝶&蝴蝶狮');
f=@(x,y,z)(x.^2 + (9/4)*y.^2 + z.^2 - 1).^3 - x.^2.*z.^3 - (9/80)*y.^2.*z.^3;
g=@(x,y,z)(sqrt(x.^2+y.^2)-2).^2+z.^2-.09;
h=implicitsurf(f,[-1.5 1.5],[-.8 .8],[-1.5 1.5],50);
set(h,'AmbientStrength',.5);%可以设置各种效果
hold on%可以添加图形
h=implicitsurf(g,[-2.3,2.3],[-2.3,2.3],[-.3,.3]);
colormap hsv;set(h,'AmbientStrength',.8,'FaceAlpha',.5);%可以设置各种效果
axis off;axis equal;shading interp;camlight;lighting gouraud;

%MATLAB eig函数，得到的特征向量只满足相似条件。所以需要将此向量正交单位化后得到相似合同矩阵。
end