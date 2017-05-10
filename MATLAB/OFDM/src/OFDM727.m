function OFDM727( )
%OFDM727 此处显示有关此函数的摘要
%   此处显示详细说明
% ofdm spectrum plot clear all; 
close all;
clc;  
Num_Sc = 12;  %Num_Sc+1个子载波
Ts = 1;       %时间为1s 
F_space = 1/Ts; %频率间隔 
F = -F_space*Num_Sc/2-4:0.001:F_space*Num_Sc/2+4;   %频域自变量f
F_spectrum = zeros(Num_Sc,length(F));               %F_spectrum为频域函数网格粒子
for i = -Num_Sc/2:1:Num_Sc/2     
	F_spectrum(i+Num_Sc/2+1,1:end)  =  sin(2*pi*(F-i*F_space).*Ts/2)./(2*pi*(F-i*F_space).*Ts/2); 
end
figure(1);
plot(F,F_spectrum,'LineWidth',3);
%plot(x,y,'o','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','g','MarkerSize',10);
%'LineWidth',2：设置线宽为2个点；
%'MarkerEdgeColor','r'：设置数据点型和边界为红色；
%'MarkerFaceColor','g'：设置数据点型的填充颜色为绿色；
%'MarkerSize',10：设置数据点型的宽度为10个点

grid on;

% OFDM子载波绘图
% clear all; 
% close all; 
% clc; 
N = 256; 
M = 6; 
N_symbol = 1; 
% s_data = [-3-sqrt(-1)*3 -3-sqrt(-1) -3-sqrt(1) -3-sqrt(-1)*3]/sqrt(10); 
s_data = (1+sqrt(-1))/sqrt(2);   
tx_data = repmat(s_data,1,N);  
% some initial phase 
% Original_bin = randint(2,N*N_symbol,2,222);  
% Modobj =  modem.qammod('M',4,'SymbolOrder','Gray','InputType','Bit'); 
% tx_data = modulate(Modobj,Original_bin)/sqrt(10); 
for j = 0:1:N_symbol-1   
	for k =0:1:N-1         
		for n = 0:1:N-1               
			x_tmp(k+1,n+1+j*N) = tx_data(k+1+j*N)*exp(sqrt(-1)*2*pi*k*n/N);         
		end   
	end 
end  %plot four-subcarrier 
figure(2)  
plot(real(x_tmp(1:4,1:end).'),'LineWidth',3);

end

