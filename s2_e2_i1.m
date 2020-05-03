% Parametros
r = 0.0002;
g = 0.2;

% Valores Iniciales
S0 = 10000;
I0 = 2;
R0 = 0;
X0 = [S0, I0];  
C = S0 + I0 + R0;

% Intervalo de Integracion
a = 0;
b = 60;
N = 200;
h = (a+b) / N; 

% Funciones S' e I'
fS = @(t, S_t, I_t) (-r * S_t * I_t);
fI = @(t, S_t, I_t) (r * S_t * I_t - g * I_t);

h_vals = []
e_vals = []

F = @(t, y) [fS(t, y(1), y(2)) fI(t, y(1), y(2))];

% Aproximacion de las funciones
[t, E] = rk4_edo(F, a, b, X0, N, h);


% Calculo R (Se utiliza que S + I + R = Cte)
R = [R0]; 
for e = 2:(N+1)
  R = [R;(C - E(e,1) - E(e, 2))];
end
E = [E R];


plot(t, E);

% TODO: Plotear I en funcion de S
% TODO: Sacar h utilizando la estrategia de comparar los resultados usando h y h/2