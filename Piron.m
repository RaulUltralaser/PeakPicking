clc
clearvars

%% valores que necesito poner manualmente

w=[18.21;127.7;244.45;375.42];  %vector de frecuencias naturales

%mode shapes
phi1=[8.2044; -0.8491; -4.3655; 2.6594  ];
phi2=[-7.0012; 6.1720; 3.0441; 0.5753];
phi3=[-139.09; -9.2087; 0.9947; 0.3556];
phi4=[-5.7143; -136.83; 2.8840; 0.6618];
Phi=[phi1 phi2 phi3 phi4];

K=[2 1 4; 3 1 0; 1 0 3]; %matriz de stiffness (puse una matriz invertible al azar)
mu=[2;2;2;2];  %masas modales (no sé si es una matriz)

ith=3;   %esto es para representar el i-esimo modo
alpha=2; %esto es la posición a calcular del par SA
m=3;     %los primeros m modos, la unica condición que pide es que m<n
n= 4;    %numero modos

%% Valores que se calculan automaticamente, y son posicionamiento SA

%modeshapes normalizados
for i = 1:size(Phi)
    Phin(:,i)=Phi(:,i)/norm(Phi(:,i));
end

%sumatoria de los k-esimo modeshapes en el valor alpha
x=0; %ecuación 11 primer denominador| sumatoria de modeshapes
for k = 1:1:(ith-1) 
    x=x+(Phin(alpha,k)^2);
end
  
y=Phin(alpha,ith)^2;   %ecuación 11 segundo denominador| modeshape i al cuadrado

z=Phin(alpha,ith+1)^2;  %ecuación 11 tercero denominador| modeshape i+1 al cuadrado

% %estos valores son para calcular R_alpha, que es la corrección estatica 
% de modos de alto orden en la posición alpha
sumr=0;  
for i = 1:1:m 
    sumr=sumr+((Phin(alpha,i)^2)/(mu(i)*(w(i)^2)));
end
invK=inv(K);

r=invK(alpha,alpha)-sumr;                    %ecuación 11 termino R_alpha

v1=w(ith)^2 ;                                %omega i al cuadrado
v2=w(ith)^2;                                 %omega i+1 al cuadrado también

%% Aproximación de z

a=r;
b=v2*r+v1*r+x+y+z;
c=v1*v2*r+x*v2+x*v1+y*v2+v1*z;
d=x*v1*v2;

p=[a 0 b 0 c 0 d];
soluciones=roots(p);

% syms s
% eq = a*(s^6)+b*(s^4)+c*(s^2)+d;
% soluciones= solve(eq,s);

for i=1:1:size(soluciones)
    if (w(ith)^2<soluciones(i)^2) && (soluciones(i)^2 <w(ith+1)^2)
        zi=soluciones(i);
    else
        zi=1;
    end
end

if (zi==1)
     disp('no se satisface el criterio para zi')
end




%% Criterio de posicionamiento

sum1=1;
for i = 1:1:m 
    sum1=sum1+zi-w(i))/();
end
mul1=1;
mul2=1;

Jx=((1/n)*sum1)*(nthroot(mul1,n))*(nthroot(mul2,n));
