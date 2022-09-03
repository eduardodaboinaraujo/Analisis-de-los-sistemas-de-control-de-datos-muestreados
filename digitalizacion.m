clear 
clc 
close all

s = tf('s');
g=(10)/(s^2+2*s+10);

% ---- Calculo de la frecuencia del sistema escojido el cual se utiliza ----%
%       para calcular el tiempo de muestreo adecuado para este sistema      %
Frmx=bandwidth(g);
T=5*Frmx;
To=1/T;
%---------------------------------------------------------%
% ---- Vector de tiempo el cual se analisa para que tenga el tiempo ----%
%       suficiente para ilustrar la dinamica completa del sistem        %
t=0:To:6;
%-----------------------------------------------------------------------%

% ---- Sistema escojido el cual se le aplico transformada inversa ----% 
%      de laplace para poder trabajarlo en el dominio temporal        %
y=(10/3).*exp(-t).*sin(3*t);
% --------------------------------------------------------------------%
% ---- Se aplico un cambio de variable de t = n para poder hacer el ----%
%     calculo de los nivel y asi evaluarlo dependiendo de la camtidad   %
%                           de bits a utilizar                          %
n=0:To:6;
y2=(10/3).*exp(-n).*sin(3*n);
% ----------------------------------------------------------------------%
% ---- Ingrese número de bits para la cuantización:
b = input('Ingrese número de bits para la cuantización: ');
rango=max(y)-min(y);            % Rango de la señal
delta = rango/(2^b);          % Distancia entre los niveles de cuantización

% ---- Genera el vector de ceros para colocar los valores de cada ----%
%      nivel de cuantización.                                         %
nivel=zeros(1,2^b);
nivel(1)=min(y)+delta/2;  

for i=2:2^b                  
    
    % Asignación de los valores restantes de nivel.
    nivel(i)=nivel(i-1)+delta;
    
end

% Encuentra el último índice del vector n 
N=find(n,1,'last');         

% Genera el vector de ceros para asignar la cuantización de cada muestra.
y4=zeros(1,N);

% Genera el vector de ceros para asignar la codificación de cada muestra.
y5=zeros(1,N);

% Asignación de la cuantización y codificación de las muestras.
for i=1:N
    
    for j=1:2^b
        
        if y2(i)<=nivel(1)
            
            y4(i)=nivel(1);
            y5(i)=0;
            
        elseif abs(y2(i)-nivel(j))<=delta/2
            
            y4(i)=nivel(j);
            y5(i)=j-1;
            
        elseif y2(i)>=nivel(j)
            
            y4(i)=nivel(j);
            y5(i)=j-1;
        end 
    end
    
end
Codificado=de2bi(y5)
%-------------------------------------------------------------------------%
% ---- Digitalizacion metodo retenedor de orden 0 ----% 
gz=c2d(g,To,'zoh');
%-------------------------------------------------------------------------%
% ---- Digitalizacion metodo retenedor de orden 0 ----%
%  estraemos la data ya digitalizada y la convertimos %
%           en funcion de transferencia               %
[numz,denz]=tfdata(gz,'v');
gz1=tf(numz,denz,To);
%-------------------------------------------------------------------------%
% ---- Convertimos de digital a continuo ----%
sysc = d2c(gz1);
%-------------------------------------------------------------------------%

figure(1)
step(g,'b')
hold on 
step(gz,'r')
hold on
for i=1:2^b
    
    nive=nivel(i);
    plot([0, 6], [nive, nive]);
    
end
[Y,X,J]=step(gz);
stem(X,Y,'g');
title('Sistema de segundo orden sub-amortiguado');
legend('continua','digital','Cuantización');
grid on

figure(2)
step(gz1,'b')
hold on 
step(sysc,'r')
hold on
for i=1:2^b
    
    nive=nivel(i);
    plot([0, 6], [nive, nive]);
    
end
[Y,X,J]=step(gz1);
stem(X,Y,'g');
title('Sistema de segundo orden sub-amortiguado');
legend('digital','continuo','Cuantización');
grid on
