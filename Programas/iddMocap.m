clc 
clearvars
close all
%% carga de datos y adecuación de los mismos 

load('cambiosDeFrecuencia.mat');
load('EntradasAnalogicas.mat');

y=str2double(X1);           %Estos son los registros del mocap
ul=Entrada.signals.values;  %Registros de la entrada

t=Entrada.time;             %tiempo (medido desde la entrada)

L=length(t);   %largo de la señal 
Fs=100;    %Frecuencia de muestreo
Ts=1/Fs;   %el periodo de muestreo

%proceso para adecuar las señal u ya que esta está dada como valores unit16
for i=1:L
    u(i,1)=ul(:,:,i);
end
u=double(u);
Diferencia=size(u,1)-size(y,1);
u=u(Diferencia:end-1,1);

t=Entrada.time(Diferencia:end-1,1);   % sobre escribo el valor del tiempo para ajustarlo al mismo 
%length de u

%% utilización de system identification toolbox para encontrar las frecuencias naturales

data = iddata(y, u, Ts);

% Estimate a transfer function model of the system using subspace identification
n_states = 6;  % Number of states to estimate
model = ssest(data, n_states);

% Extract the natural frequencies and damping factors from the model
pole_locs = pole(model);  % Locations of the system poles in the complex plane
damping_ratios = abs(real(pole_locs)./abs(pole_locs));  % Damping ratios
natural_freqs = abs(pole_locs)/(2*pi);  % Natural frequencies in Hz

% Display the results
fprintf('Natural frequencies: %.2f, %.2f Hz\n', natural_freqs);
fprintf('Damping factors: %.2f, %.2f\n', damping_ratios);
