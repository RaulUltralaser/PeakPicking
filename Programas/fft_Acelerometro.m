clc
clearvars
% close all

% % Proposito del programa:
% %         Presenta una gráfica donde se muestre los datos recolectados del acelerometro
% %         en la parte superior y en la inferior el espectrograma o FFT (Fast Fourier Transformation)
% % 
% % Requiere: 
% %         Los datos previamente obtenido guardados como un archivo ".mat"

%% Preparación de datos
load(['Datos/Prueba5.mat']); %Cargar los datos (el archivo .mat)


y = Acelerometro.signals.values; %valores de la señal
t= Acelerometro.time; %tiempo de la señal
L=length(t);   %largo de la señal 
Ts=0.01;   %el periodo de muestreo (asegurarse que sea el periodo correcto 
% marcado en simulink al momento de registrar los datos
Fs=1/Ts;    %Frecuencia de muestreo en Hz
G=2;  %ganancia de las frecuencias en graficas (ayuda a ver mejor
%las frecuencias en las que se presentan picos, pero altera su amplitud,
% originalmente debe ser igual a dos para dar la correcta representación)

%% Calculo de la FFT 
f = Fs*(0:(L/2))/L; %Establece las frecuencias que se van a mostrar
% siempre son la mitad de la frecuencia de muestreo
yP=fft(y); %Esta función el la FFT de las señales registradas

%aquí se acomoda la fft para que solo muestre las respectivas a las 
%freuencias, esto es porque la fft se duplica, es decir, la mitad de la fft
% es igual a la otra mitad pero espejeada
P2P = abs(yP/L);
P1P = P2P(1:(L/2)+1);
P1P(2:end-1) = G*P1P(2:end-1);

%% Plotea los resultados
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