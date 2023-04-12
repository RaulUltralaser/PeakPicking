clc
clearvars
close all

load('cambiosDeFrecuencia.mat');

L=length(Frame);   %largo de la señal 
Fs=100;    %Frecuencia de muestreo en Hz
T=1/Fs;   %el periodo de muestreo
G=2;  %ganancia de las frecuencias en graficas (ayuda a ver mejor
%las frecuencias en las que se presentan picos, pero altera su amplitud,
% originalmente debe ser igual a dos para dar la correcta representación)

f = Fs*(0:(L/2))/L;
y=str2double(X3);
yP=fft(y);

P2P = abs(yP/L);
P1P = P2P(1:(L/2)+1);
P1P(2:end-1) = G*P1P(2:end-1);


figure('Name','fft de las mediciones del mocap');
subplot(2,1,1)
plot(Frame,y,'k')
title('posición medida por el mocap de algún marcador')
xlabel('tiempo s')
ylabel('mm')
grid on
subplot(2,1,2)
plot(f,P1P,'k')
title('amplitud del espectro de las mediciones')
xlabel('frecuencia hz')
ylabel('Amplitud')
grid on



