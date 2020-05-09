% doR --> Si este parametro es falso, no se estima R

function [t X]=estimacion_SIR_con_vacuna(a,b,h,X0,r,g,la,tv)
N = (a+b) / h;

fS = @(t, S_t, I_t) (-r * S_t * I_t - la * S_t * (t > tv));
fI = @(t, S_t, I_t) (r * S_t * I_t - g * I_t);

F = @(t, y) [fS(t, y(1), y(2)) fI(t, y(1), y(2))];

% Aproximacion de las funciones
[t, X] = rk4_edo(F, a, b, X0, N, h);

endfunction
