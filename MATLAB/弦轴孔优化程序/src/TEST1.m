function TEST1(b,L)
global L;
b=b+1
while  L>0
    L=L-1
    TEST1(b,L);       %�ƽ�������ѭ���ķ���������������ã�
end
return;