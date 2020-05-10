% Parametros
la = 0.2;   % Lambdas; Usar la = [0.1 0.2 0.3]
tv = 0;      % Iniciacion de vacunas; Usar tv = [0 10]

% Valores Iniciales
S0 = 10000;
I0 = 2;
X0 = [S0, I0];  
poblacion = S0 + I0;

% Intervalo de Integracion
a = 0;
b = 49;
h = 0.02;%0.0015625; % h obtenido en la primera seccion

% Primera parte: 
LAs = [0.1, 0.2, 0.3];
g = 0.2;
r = 0.0002;
La_res = [];
for la = LAs
  [t X] = estimacion_SIR_con_vacuna(a,b,h,X0,r,g,la,tv);
  Y = [t X];
  [t2 s2]=fin_epidemia(Y, poblacion);
  La_res = [La_res; la t2 s2 max(Y(:,3))];
end

display("Lambda - Duracion de epidemia - Numero de Susptibles al final - Pico de infectados");
display(La_res);

% Segunda Parte: Graficar curvas
% Fijar el lambda que desea graficar
la = 0.1  %Lambdas; Usar la = [0.1 0.2 0.3]
[t X] = estimacion_SIR_con_vacuna(a,b,h,X0,r,g,la,tv);
figure(1);
subplot(2,1,1);
plot(t, X);              % Grafico de S(t) I(t)
title(sprintf("Con vacunas (Lambda = %f)", la));
legend("S(t)", "I(t)");
xlabel ("Tiempo");

subplot (2,1,2);
plot (X(:,1), X(:,2));     %Grafico de S(I(t))
legend ("S(I(t)");
xlabel ("Suceptibles");
ylabel ("Infectados");


% Tercera parte: Vacunas aparecen apartir de t = 10
tv = 10
[t X_v10] = estimacion_SIR_con_vacuna(a,b,h,X0,r,g,la,tv);
figure(2);
subplot(2,1,1);
plot(t, X_v10);              % Grafico de S(t) I(t)
xlabel ("Tiempo");
legend("S(t)", "I(t)");

title(sprintf("Con vacunas iniciando desde t = %f", tv));
subplot(2,1,2);
plot(X_v10(:,1), X_v10(:,2));     %Grafico de S(I(t))
xlabel ("Suceptibles");
ylabel ("Infectados");
legend("S(I(t)");
