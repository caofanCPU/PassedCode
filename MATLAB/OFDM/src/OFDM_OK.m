function OFDM_OK( )
%OFDM_OK 此处显示有关此函数的摘要
%   此处显示详细说明

%Matlab的例子（一）
t=0:1/4096:1;    %采样步长
y0= cos(2*pi*100*t)+cos(2*pi*150*t)+cos(2*pi*200*t)+cos(2*pi*250*t)+cos(2*pi*300*t);
y = y0 .* cos(2*pi*1000*t);
N=length(t);    %样点个数
figure(1);
plot(t,y);      %绘制时域抽样信号图形

fs=4096;         %采样频率fs为采样步长间隔的倒数
df=fs/(N-1);    %分辨率
f=(0:N-1)*df;%其中每点的频率
Y=fft(y)/N*2;%真实的幅值
Y=fftshift(Y);
figure(2)
plot(f,abs(Y));
%由于以上程序是结合傅里叶算法转换得到的对称图，而常用的只需要一半就可以了。对应的程序如下：
 
% t=0:1/256:1;%采样步长
% y= 2+3*cos(2*pi*50*t-pi*30/180)+1.5*cos(2*pi*75*t+pi*90/180);
% N=length(t); %样点个数
% plot(t,y);
% fs=256;%采样频率
% df=fs/(N-1);%分辨率
% f=(0:N-1)*df;%其中每点的频率
% Y=fft(y(1:N))/N*2;%真实的幅值
% %Y=fftshift(Y);
% figure(2)
% plot(f(1:N/2),abs(Y(1:N/2)));

end

