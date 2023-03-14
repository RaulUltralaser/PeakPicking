
clc 
clearvars
close all

%Especificar datos
Fs=100;

%Importar datos
load('cambiosDeFrecuencia.mat')

datos=str2double(X1);%Cambiar este valor por el sensor que se requiera

% Preprocesamiento de datos
datos_filt = medfilt1(datos, 5);

% Estimación de la respuesta en frecuencia
frf = fft(datos_filt)/length(datos_filt);

% Visualización de la respuesta en frecuencia
f = linspace(0, Fs/2, length(datos_filt)/2+1);
figure;
subplot(2,1,1);
plot(f, 20*log10(abs(frf(1:length(f)))));
ylabel('Amplitud (dB)');
xlabel('Frecuencia (Hz)');
subplot(2,1,2);
plot(f, unwrap(angle(frf(1:length(f))))*180/pi);
ylabel('Fase (grados)');
xlabel('Frecuencia (Hz)');


% Encontrar los picos de la respuesta en frecuencia
[pks,locs] = findpeaks(abs(frf(1:length(f))),f);

% Visualizar los picos en la curva de amplitud de la FRF
figure;
plot(f, 20*log10(abs(frf(1:length(f)))));
hold on;
plot(locs, 20*log10(pks), 'ro');
hold off;
ylabel('Amplitud (dB)');
xlabel('Frecuencia (Hz)');


