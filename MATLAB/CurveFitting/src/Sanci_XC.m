function c_=Sanci_XC(D_x,D_y,D_n,D_L)
%求弦长，参数方程的系数[A,B,C,D];[E,F,G,P]
global D_x D_y D_n D_L;
%求出型值点给定的弦长
D_L(1)=0;
for i=1:1:(D_n-1)
    D_L(i+1)=sqrt((D_x(i+1)-D_x(i))^2+(D_y(i+1)-D_y(i))^2);  %D_L为每段弦长存储行向量
end
%disp(D_L);
%求X(L)的参数方程 X(L)=Ai*(L-L(i-1))^3+B*(L-L(i-1))^2+C*(L-L(i-1))+D (i=1:n)
n=D_n-1;                 %去除(x0,y0)点后剩下的n个点
s=D_x(2:n+1)-D_x(1:n);   
B=reshape([s;zeros(2,n)],3*n,1);     %B矩阵是一个3*n行1列的常数矩阵
%reshape函数用于对已知矩阵变换维数(变换前后矩阵元素数目严格相等，这是报错的条件)
%其变换原理是：将已知矩阵X按照线性下标存储（即列优先存储）为“一行”，再对需要的M by N矩阵进行列优先填充
%对于那“一行”数据，将其分为N组，每一组的M个“行数据”变为“列填充”
A=zeros(3*n,3*n);        %预留3*n * 3*n的0矩阵等待数据信息填充进去
for i=1:1:n
    D_Li=D_L(i+1);
    D_Lm =[D_Li^3,D_Li^2,D_Li;3*D_Li,1,0;3*D_Li^2,2*D_Li,1];
    A = A + [zeros((i-1)*3,3*n); [zeros(3,(i-1)*3),D_Lm,zeros(3,(n-i)*3)]; zeros((n-i)*3,3*n)];
    if i<n
        A(3*i-1,3*(i+1)-1) = -1;
        A(3*i  ,3*(i+1)  ) = -1;
    else
        A(3*i-1,2) = -1;
        A(3*i  ,3) = -1;
    end
end
X = A\B;           %求出来的X为一个列向量！！！
a = X(1:3:3*n)';   %此表达式属于线性下标引用数组元素,需要上一步求解判断其属性！！！
b = X(2:3:3*n)';
c = X(3:3:3*n)';
d = D_x(1:n);
%此处a,b,c,d不包括初始解！即a(1)=X(1)=a1
%求Y(L)的参数方程 Y(L)=Ai*(L-L(i-1))^3+B*(L-L(i-1))^2+C*(L-L(i-1))+D (i=1:n)
n = D_n-1;    %去除(x0,y0)点后剩下的n个点
s = D_y(2:n+1)-D_y(1:n);   
B =reshape([s;zeros(2,n)],3*n,1);
A = zeros(3*n,3*n);
for i = 1:n
    D_Li = D_L(i+1);
    D_Lm =[D_Li^3,D_Li^2,D_Li; 3*D_Li,1,0;  3*D_Li^2,2*D_Li,1];
    A = A + [zeros((i-1)*3,3*n); [zeros(3,(i-1)*3),D_Lm,zeros(3,(n-i)*3)]; zeros((n-i)*3,3*n)];
    if i<n
        A(3*i-1,3*(i+1)-1) = -1;
        A(3*i  ,3*(i+1)  ) = -1;
    else
        A(3*i-1,2) = -1;
        A(3*i  ,3) = -1;
    end
end
Y = A\B;    %求出来的Y为一个列向量！！！
e = Y(1:3:3*n)';
f = Y(2:3:3*n)';
g = Y(3:3:3*n)';
p = D_y(1:n);
%所求得的8个系数矩阵全为行向量
c_=[a;b;c;d;e;f;g;p];     %将求解结果合并到8 by (D_n-1)矩阵c_中