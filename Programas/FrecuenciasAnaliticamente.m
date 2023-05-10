clc
clearvars
%close all 
% 
% % Proposito del programa:
% %     mostrar rapidamente las frecuencias naturales, para comparar
% %     estás que son calculadas analiticamente con las calculadas con los
% %     datos recolectados
% % 
% % Nota: para ver las frecuencias se debe hacer click en esa variable en 
% %       el workspace. También se calcula los modeshapes y los factores de 
% %       amortiguamiento.

%% Escribir los parametrós manualmente
%%%%%%%%%%%%%%%%%%% valores mecanicos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L=1;                        %Longitud de la viga       m
an=0.025;                   %Ancho de la viga          m
es=0.002;                   %Espesor de la viga        m 
area=an*es;                 %area sección transversal  m^2
E=69E7;                     %Nm %Modulo de Young       Pa
I=1.66667E-11;              %Momento de inercia        m^4
rho=2710;                   %densidad del metal        kg/m^3

%%%%%%%%%%%%%%%%%%%% valores para el analisis de elemento finito%%%%%%%%%
ne=21;          %numero de elementos                  
nne=2;          %numero de nodos por elemento
dof=2;          %Grado de libertad -> Nùmero de variables por nodo
Le=L/ne;        %H distancia entre elementos
nn=ne+1;        %Número de nodos
nq=dof*nn;      %Número de variables totales

%% Cálculo de las matrices de rigidez y masa

% este valor lo requiere la función febeam1 debe ser 1 para masasa
% continuas o dos para masas con grumos, (en mi barra es 1)
imass=1;

% inicialización de matrices
KK=zeros(nq,nq);
MM=zeros(nq,nq);
nodes=zeros(ne,nne);

% se rellenan las matrices

% los nodos es una matriz que cuyos renglones son numeros consecutivos
% es solo para ordenar los nodos que estan juntos
for i=1:ne
nodes(i,:)=[i,i+1];
end

% utilizando febeam1 se crea la matriz de rigidez y masas de un elemnto
% y estas son ensambladas para crear las respectivas matrices de todo el 
% sitema. El programa feeldof computa los grados de libertad asociados a
% cada elemento.
for e=1:ne
[K,Mg]=febeam1(E,I,Le,area,rho,imass);
index=feeldof(nodes(e,:),nne,dof);
KK=feasmbl1(KK,K,index);            %MATRIZ DE TODO EL SISTEMA
MM=feasmbl1(MM,Mg,index);
end



%% Calculo de la frecuencias naturales, factores de amortiguamiento y modos de vibración

% Autovalores y autovectores de la matriz de rigidez y masa
[V,D] = eig(KK,MM);
freq_naturales = sqrt(diag(D))/(2*pi); % Frecuencias naturales en Hz
fact_amortiguamiento = -real(diag(D))./abs(diag(D)); % Factores de amortiguamiento
modeshapes = V; % Modos de vibración
