function OFDM727( )
%OFDM727 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
% ofdm spectrum plot clear all; 
close all;
clc;  
Num_Sc = 12;  %Num_Sc+1�����ز�
Ts = 1;       %ʱ��Ϊ1s 
F_space = 1/Ts; %Ƶ�ʼ�� 
F = -F_space*Num_Sc/2-4:0.001:F_space*Num_Sc/2+4;   %Ƶ���Ա���f
F_spectrum = zeros(Num_Sc,length(F));               %F_spectrumΪƵ������������
for i = -Num_Sc/2:1:Num_Sc/2     
	F_spectrum(i+Num_Sc/2+1,1:end)  =  sin(2*pi*(F-i*F_space).*Ts/2)./(2*pi*(F-i*F_space).*Ts/2); 
end
figure(1);
plot(F,F_spectrum,'LineWidth',3);
%plot(x,y,'o','LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','g','MarkerSize',10);
%'LineWidth',2�������߿�Ϊ2���㣻
%'MarkerEdgeColor','r'���������ݵ��ͺͱ߽�Ϊ��ɫ��
%'MarkerFaceColor','g'���������ݵ��͵������ɫΪ��ɫ��
%'MarkerSize',10���������ݵ��͵Ŀ��Ϊ10����

grid on;

% OFDM���ز���ͼ
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

