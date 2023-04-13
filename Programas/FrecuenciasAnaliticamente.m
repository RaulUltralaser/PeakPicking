clc
clearvars
close all 

% Valores estructurales de la viga en voladizo
L = 1; % Longitud de la viga en metros
b = 0.025; % Ancho de la viga en metros
h = 0.002; % Espesor de la viga en metros
rho = 2710; % Densidad del material en kg/m^3
E = 6.89e10; % Módulo de elasticidad en Pa
nu = 0.33; % Coeficiente de Poisson

% Matriz de rigidez y masa de la viga
K = (E*h^3)/(12*(1-nu^2))*[12 6*L -12 6*L; 6*L 4*L^2 -6*L 2*L^2; -12 -6*L 12 -6*L; 6*L 2*L^2 -6*L 4*L^2];
M = rho*b*h*L/420*[156 22*L 54 -13*L; 22*L 4*L^2 13*L -3*L^2; 54 13*L 156 -22*L; -13*L -3*L^2 -22*L 4*L^2];

% Autovalores y autovectores de la matriz de rigidez y masa
[V,D] = eig(K,M);
freq_naturales = sqrt(diag(D))/(2*pi); % Frecuencias naturales en Hz
fact_amortiguamiento = -real(diag(D))./abs(diag(D)); % Factores de amortiguamiento
modeshapes = V; % Modos de vibración
