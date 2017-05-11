function TEST1(b,L)
global L;
b=b+1
while  L>0
    L=L-1
    TEST1(b,L);       %破解主函数循环的方法：函数自身调用！
end
return;