% Constantes
r = 0.0002;
g = 0.2;

% Valores Iniciales
S0 = 10000;
I0 = 2;
R0 = 0;
X0 = [S0, I0];  

% Intervalo de Integracion y Paso de Integracion
a = 0;
b = 70;
h = 0.02; % h inicial (no optimizado)

% Optimizacion Intervalo de Integracion
[t, X] = estimacion_SIR(a,b,h,X0,R0,r,g, false);
for i = 1:size(t)
  if(X(i,2) < 1)
    b = t(i);
    break
  end
end

optimizar = false;

% Optimizacion del h
if(optimizar)
error = 10e-8
E = [];
H = [];
display("Optimizando h");
while (size(E) == 0 || E(end) > error)
  [t, X1] = estimacion_SIR(a,b,h,X0,R0,r,g, false);
  h = h/2;
  [t, X2] = estimacion_SIR(a,b,h,X0,R0,r,g, false);
  E = [E;max(my_diff(X1(:,1),X2(:,1)(1:2:end)), my_diff(X1(:,2),X2(:,2)(1:2:end)))];
  X1 = X2;
  H = [H; h E(end)];
end

h = H(end,1); % h optimizado
end

% Estimo utilizando el paramentro adecuado
display("Estimando SIR");
[t X] = estimacion_SIR(a,b,h,X0,R0,r,g, true);
Y = [t X];

% Para graficar, se crea un matriz reducida, para facilitar la ejecucion
skip = 1;
X_plot = [X(:,1)(1:skip:end) X(:,2)(1:skip:end) X(:,3)(1:skip:end)];

% Graficar resultados
subplot(2,1,1);
title("Modelo S I R")
plot(t(1:skip:end), X_plot);                    % Grafico de S(t) I(t) R(t)
xlabel ("Tiempo");
legend("S(t)", "I(t)", "R(t)");

subplot(2,1,2);
plot(X(:,1)(1:skip:end), X(:,2)(1:skip:end))      % Grafico de S(I(t))
xlabel ("Suceptibles");
ylabel ("Infectados");
legend("S(I(t)");