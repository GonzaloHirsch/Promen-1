% doR --> Si este parametro es falso, no se estima R

function [t X]=estimacion_SIR(a,b,h,X0,R0,r,g, doR)
C = X0(1) + X0(2) + R0;

N = (a+b) / h;

fS = @(t, S_t, I_t) (-r * S_t * I_t);
fI = @(t, S_t, I_t) (r * S_t * I_t - g * I_t);

F = @(t, y) [fS(t, y(1), y(2)) fI(t, y(1), y(2))];

% Aproximacion de las funciones
[t, X] = rk4_edo(F, a, b, X0, N, h);

if(doR)
  % Calculo R (Se utiliza que S + I + R = Cte)
  R = [R0]; 
  for e = 2:(N+1)
    R = [R;(C - X(e,1) - X(e, 2))];
  end
  X = [X R];
end

endfunction
