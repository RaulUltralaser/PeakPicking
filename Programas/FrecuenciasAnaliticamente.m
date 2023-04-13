clc
clearvars
close all 

% Este programa lo hice para que me mostrará facilmente las frecuencias
% naturales del sistema, pero requiere que corra primero el programa de 
% beam2.m y que guarde los valores de la matriz de rigidez y la de masas
% cosa que no me agrada mucho, voy a intentar recrear el programa sin esa
% parte

 load('Datos/MatrizRigidezMasasCONelprogramabeam2');

% Autovalores y autovectores de la matriz de rigidez y masa
[V,D] = eig(KK,MM);
freq_naturales = sqrt(diag(D))/(2*pi); % Frecuencias naturales en Hz
fact_amortiguamiento = -real(diag(D))./abs(diag(D)); % Factores de amortiguamiento
modeshapes = V; % Modos de vibración
