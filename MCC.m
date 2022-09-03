%{
    Práctica de procesamiento digital de señales.
    Muestreo, cuantización y codificación de una señal. 
%}

% Solicitud de la función s de la señal  en terminos de la variable t.
% s = input('Ingrese la función de variable t: ','s');   

% Solicitud del vector t de tiempo "continuo" para la señal a procesar.
t = input('Ingrese intervalo de tiempo: ');

inicial=subs(find(t,1));            % Primer valor del vector t. 

final=subs(find(t,1,'last'));       % Último valor del vector t.

% Vector de valores de la señal en el tiempo "continuo" t.
% y = eval(str2sym(s)); 
% y= cos(3*pi*t)+sin(4*pi*t);
y=(10/3).*exp(-t).*sin(3*t);

% Genera un diseño de gráfico en mosaico para mostrar 2x2 gráficos.
% tiledlayout(2,2);

% nexttile        % Genera un mosaico
figure(1)
plot(t,y,'r');  % Grafica la señal en el tiempo "continuo".
hold on
grid on;        % Cuadrícula de gráfica
title('Gráfica de la señal continua en el tiempo.'); % Título de la gráfica
xlabel('t');    % Título del eje x.
ylabel('y(t)'); % Título del eje y.
legend({'Continua'},'Location','southwest'); % Leyenda al sur oeste.

% Solicitud de la frecuencia para muestrear la señal.
fs=input('Ingrese frecuencia de muestreo: '); 

T=1/fs;                     % Periodo de la señal de muestreo.

% Vector de tiempo "discreto" n para muestrear la señal.
n=t(inicial):T:t(final);

% Remplaza la variable t por la n de la señal s y la coloca en s2:
% s2=replace(y,'t','n');
% 
% y2=eval(str2sym(s2)); % Vector de valores muestreados.

% y2=cos(3*pi*n)+sin(4*pi*n);
y2=(10/3).*exp(-n).*sin(3*n);

figure(2)
stem(n,y2,'k');             % Grafica la señal muestreada.
grid on;
title('Gráficas de la señal continua y muestreada.');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Muestreada'},'Location','southwest');

input('Presione enter para continuar: ');   % Solicitud de espera

% Vector de los valores interpolados a partir de las muestras.
y3=interp1(n,y2,t,'ppval');

figure(3)
plot(t,y3,'b');             % Grafica la interpolación .
grid on;
title('Gráficas de la señal continua, muestreada e interpolada');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Muestreada','Interpolada'},'Location','southwest');
hold off;                       % Termina las gráficas.

input('Presione enter para continuar: ');

% nexttile

hold on;                        

stem(n,y2,'k');                 % Grafica la señal discreta.
grid on;
title('Gráfica de la señal muestreada.');
xlabel('t');
ylabel('y(t)');
legend({'Muestras'},'Location','southwest');

% Solicitud del número de bits para la cuantización de las muestras (número
% de niveles).
b = input('Ingrese número de bits para la cuantización: ');

rango=max(y)-min(y);            % Rango de la señal

delta = rango/(2^b);          % Distancia entre los niveles de cuantización

% Genera el vector de ceros para colocar los valores de cada nivel de 
% cuantización.
nivel=zeros(1,2^b);

nivel(1)=min(y)+delta/2;       % Asignación del valor del primer nivel


for i=2:2^b                  
    
    % Asignación de los valores restantes de nivel.
    nivel(i)=nivel(i-1)+delta;
    
end

% Grafica los niveles de cuantización (Opcional).
for i=1:2^b
    
    nive=nivel(i);
    plot([t(inicial), t(final)], [nive, nive]);
    
end

title('Gráficas de muestreo y niveles de cuantización.');
xlabel('t');
ylabel('y(t)');
legend({'Muestras','Niveles'},'Location','southwest');

input('Presione enter para continuar: ');

N=find(n,1,'last');         % Encuentra el último índice del vector n 

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

stem(n,y4,'g');                 % Grafica las muestras cuantizadas

grid on;
title('Gráficas muestreo, niveles y cuancización.');
xlabel('t');
ylabel('y(t)');
legend({'Muestras','Niveles','Cuantización'},'Location','southwest');

hold off;

input('Presione enter para continuar: ');

stem(n,y4,'g');                 % Grafica las muestras cuantizadas.

hold on;

grid on;
title('Gráfica de cuantización.');
xlabel('t');
ylabel('y(t)');
legend({'Cuantización'},'Location','southwest');

input('Presione enter para continuar: ');

stairs(n,y4);   % Gráfica de escalera de la cuantización o digitalización.
grid on;
title('Gráfica de escalera de la cuantización (digitalización).');
xlabel('t');
ylabel('y(t)');
legend({'Digitalización'},'Location','southwest');

hold off;

input('Presione enter para continuar: ');

plot(t,y,'r');                  % Grafica la señal en el tiempo.

hold on;

stairs(n,y4,'g');                   % Grafica la señal digitalizada.

grid on;
title('Gráficas de la señal continua y digitalizada.');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Digitalizada'},'Location','southwest');

hold off;

%nexttile

plot(t,y,'r');             % Grafica la señal en el tiempo "continuo".

hold on;

% Vector de los valores interpolados a partir de la señal cuantizada.
y6=interp1(n,y4,t,'ppval');

plot(t,y6,'b');        % Grafica la interpolación de la señal digitalizada.

grid on;
title('Gráficas de la señal continua e interpolación de la digitalizada.');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Interpolación Digital'},'Location','southwest');

hold off;

% Vector del error entre la señal original y la digitalización final.

error = y-y6;

%nexttile

plot(t,error,'k');% Grafica del error final al interpolar la digitalización

grid on;
title('Gráfica del error.');
xlabel('t');
ylabel('y(t)');
legend({'Error'},'Location','southwest');

% Vector del código binario de la señal cuantificada (digitalizada).
Codificado=de2bi(y5)
