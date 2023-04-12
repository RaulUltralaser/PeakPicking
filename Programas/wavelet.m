clc
clear vars
close all

load('Pruebaa32HzsoloMid.mat')

y1=Punta.signals.values;
t=Entrada.time;


L=length(t);
y=[];

for i=1:L
    y(i,1)=y1(:,:,i);
end

wt=cwt(y);

cwt(y,1)