clc
clearvars
close all

load(['Datos/Prueba1.mat']);


y = Acelerometro.signals.values; %valores de la señal
t= Acelerometro.time; %tiempo de la señal
L=length(t);   %largo de la señal 
Fs=1000;    %Frecuencia de muestreo en Hz
T=1/Fs;   %el periodo de muestreo
G=2;  %ganancia de las frecuencias en graficas (ayuda a ver mejor
%las frecuencias en las que se presentan picos, pero altera su amplitud,
% originalmente debe ser igual a dos para dar la correcta representación)

f = Fs*(0:(L/2))/L;
yP=fft(y);

P2P = abs(yP/L);
P1P = P2P(1:(L/2)+1);
P1P(2:end-1) = G*P1P(2:end-1);


figure('Name','fft de las mediciones del acelerometro');
subplot(2,1,1)
plot(t,y,'k')
title('Aceleración medida sin procesar')
xlabel('tiempo s')
ylabel('m/s^2')
grid on
subplot(2,1,2)
plot(f,P1P,'k')
title('amplitud del espectro de las mediciones')
xlabel('frecuencia hz')
ylabel('Amplitud')
grid on