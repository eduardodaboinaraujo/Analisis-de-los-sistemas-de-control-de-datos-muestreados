%{
    Pr�ctica de procesamiento digital de se�ales.
    Muestreo, cuantizaci�n y codificaci�n de una se�al. 
%}

% Solicitud de la funci�n s de la se�al  en terminos de la variable t.
% s = input('Ingrese la funci�n de variable t: ','s');   

% Solicitud del vector t de tiempo "continuo" para la se�al a procesar.
t = input('Ingrese intervalo de tiempo: ');

inicial=subs(find(t,1));            % Primer valor del vector t. 

final=subs(find(t,1,'last'));       % �ltimo valor del vector t.

% Vector de valores de la se�al en el tiempo "continuo" t.
% y = eval(str2sym(s)); 
% y= cos(3*pi*t)+sin(4*pi*t);
y=(10/3).*exp(-t).*sin(3*t);

% Genera un dise�o de gr�fico en mosaico para mostrar 2x2 gr�ficos.
% tiledlayout(2,2);

% nexttile        % Genera un mosaico
figure(1)
plot(t,y,'r');  % Grafica la se�al en el tiempo "continuo".
hold on
grid on;        % Cuadr�cula de gr�fica
title('Gr�fica de la se�al continua en el tiempo.'); % T�tulo de la gr�fica
xlabel('t');    % T�tulo del eje x.
ylabel('y(t)'); % T�tulo del eje y.
legend({'Continua'},'Location','southwest'); % Leyenda al sur oeste.

% Solicitud de la frecuencia para muestrear la se�al.
fs=input('Ingrese frecuencia de muestreo: '); 

T=1/fs;                     % Periodo de la se�al de muestreo.

% Vector de tiempo "discreto" n para muestrear la se�al.
n=t(inicial):T:t(final);

% Remplaza la variable t por la n de la se�al s y la coloca en s2:
% s2=replace(y,'t','n');
% 
% y2=eval(str2sym(s2)); % Vector de valores muestreados.

% y2=cos(3*pi*n)+sin(4*pi*n);
y2=(10/3).*exp(-n).*sin(3*n);

figure(2)
stem(n,y2,'k');             % Grafica la se�al muestreada.
grid on;
title('Gr�ficas de la se�al continua y muestreada.');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Muestreada'},'Location','southwest');

input('Presione enter para continuar: ');   % Solicitud de espera

% Vector de los valores interpolados a partir de las muestras.
y3=interp1(n,y2,t,'ppval');

figure(3)
plot(t,y3,'b');             % Grafica la interpolaci�n .
grid on;
title('Gr�ficas de la se�al continua, muestreada e interpolada');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Muestreada','Interpolada'},'Location','southwest');
hold off;                       % Termina las gr�ficas.

input('Presione enter para continuar: ');

% nexttile

hold on;                        

stem(n,y2,'k');                 % Grafica la se�al discreta.
grid on;
title('Gr�fica de la se�al muestreada.');
xlabel('t');
ylabel('y(t)');
legend({'Muestras'},'Location','southwest');

% Solicitud del n�mero de bits para la cuantizaci�n de las muestras (n�mero
% de niveles).
b = input('Ingrese n�mero de bits para la cuantizaci�n: ');

rango=max(y)-min(y);            % Rango de la se�al

delta = rango/(2^b);          % Distancia entre los niveles de cuantizaci�n

% Genera el vector de ceros para colocar los valores de cada nivel de 
% cuantizaci�n.
nivel=zeros(1,2^b);

nivel(1)=min(y)+delta/2;       % Asignaci�n del valor del primer nivel


for i=2:2^b                  
    
    % Asignaci�n de los valores restantes de nivel.
    nivel(i)=nivel(i-1)+delta;
    
end

% Grafica los niveles de cuantizaci�n (Opcional).
for i=1:2^b
    
    nive=nivel(i);
    plot([t(inicial), t(final)], [nive, nive]);
    
end

title('Gr�ficas de muestreo y niveles de cuantizaci�n.');
xlabel('t');
ylabel('y(t)');
legend({'Muestras','Niveles'},'Location','southwest');

input('Presione enter para continuar: ');

N=find(n,1,'last');         % Encuentra el �ltimo �ndice del vector n 

% Genera el vector de ceros para asignar la cuantizaci�n de cada muestra.
y4=zeros(1,N);

% Genera el vector de ceros para asignar la codificaci�n de cada muestra.
y5=zeros(1,N);

% Asignaci�n de la cuantizaci�n y codificaci�n de las muestras.
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
title('Gr�ficas muestreo, niveles y cuancizaci�n.');
xlabel('t');
ylabel('y(t)');
legend({'Muestras','Niveles','Cuantizaci�n'},'Location','southwest');

hold off;

input('Presione enter para continuar: ');

stem(n,y4,'g');                 % Grafica las muestras cuantizadas.

hold on;

grid on;
title('Gr�fica de cuantizaci�n.');
xlabel('t');
ylabel('y(t)');
legend({'Cuantizaci�n'},'Location','southwest');

input('Presione enter para continuar: ');

stairs(n,y4);   % Gr�fica de escalera de la cuantizaci�n o digitalizaci�n.
grid on;
title('Gr�fica de escalera de la cuantizaci�n (digitalizaci�n).');
xlabel('t');
ylabel('y(t)');
legend({'Digitalizaci�n'},'Location','southwest');

hold off;

input('Presione enter para continuar: ');

plot(t,y,'r');                  % Grafica la se�al en el tiempo.

hold on;

stairs(n,y4,'g');                   % Grafica la se�al digitalizada.

grid on;
title('Gr�ficas de la se�al continua y digitalizada.');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Digitalizada'},'Location','southwest');

hold off;

%nexttile

plot(t,y,'r');             % Grafica la se�al en el tiempo "continuo".

hold on;

% Vector de los valores interpolados a partir de la se�al cuantizada.
y6=interp1(n,y4,t,'ppval');

plot(t,y6,'b');        % Grafica la interpolaci�n de la se�al digitalizada.

grid on;
title('Gr�ficas de la se�al continua e interpolaci�n de la digitalizada.');
xlabel('t');
ylabel('y(t)');
legend({'Continua','Interpolaci�n Digital'},'Location','southwest');

hold off;

% Vector del error entre la se�al original y la digitalizaci�n final.

error = y-y6;

%nexttile

plot(t,error,'k');% Grafica del error final al interpolar la digitalizaci�n

grid on;
title('Gr�fica del error.');
xlabel('t');
ylabel('y(t)');
legend({'Error'},'Location','southwest');

% Vector del c�digo binario de la se�al cuantificada (digitalizada).
Codificado=de2bi(y5)
