% Constantes
r = 0.0002;    % g = 0.2    y   r: 0.0002, 0.0003 y 0.004
g = 0.2;      % r = 0.0002  y   g : 0.1, 0.2 y 0.3

% Valores Iniciales
S0 = 10000;
I0 = 2;
R0 = 0;
X0 = [S0, I0];
poblacion = S0 + I0 + R0;

% Intervalo de Integracion y Paso de Integracion
a = 0;  
b = 70;        % Utilizamos un intervalo lo suficientemente grande
h = 0.0015625; % h obtenido en la primera seccion


% Primera Parte
t1 = 0;
[t X] = estimacion_SIR(a,b,h,X0,R0,r,g, true);
Y = [t X];

[t1 s1]=fin_epidemia(Y, poblacion);
printf("Duracion de Epidemida: %f\n", t1);
printf("Maximo Infectados: %f\n", max(Y(:,3)));
printf("Nro de Suseptibles no contagiados: %f\n", s1);

% Segunda Parte: Fin de epidemida variando r.
Rs = [0.0002, 0.0003, 0.004];
g = 0.2;
R_res = [];
for r=Rs
  [t X] = estimacion_SIR(a,b,h,X0,R0,r,g, true);
  Y = [t X];
  [t2 s2]=fin_epidemia(Y, poblacion);
  R_res = [R_res; r t2];
end

display("Duracion de epidemia: r - tiempo");
display(R_res);

% Tercera Parte: Fin de epidemida variando gamma.
Gs = [0.1, 0.2, 0.3];
r = 0.0002;
G_res = [];
for g=Gs
  [t X] = estimacion_SIR(a,b,h,X0,R0,r,g, true);
  Y = [t X];
  [t3 s3]=fin_epidemia(Y, poblacion);
  G_res = [G_res; g t2];
end

display("Duracion de epidemia: gamma - tiempo");
display(G_res);
