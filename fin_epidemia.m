% Calcula el t tiempo donde finaliza la epidemia (90% de la poblacion esta recuperada o vacunada)
% Para facilitar el codigo, se busca la inversa, que es el 10% de la poblacion sea suceptible o infectada
% Y --> Funciones SIR donde la primer columna es t y las siguientes son SIR, respectivamente

function [t,s]=fin_epidemia(Y, poblacion)
rec = 0.9; % Porcentaje de recuperados o vacunados necesarios para finalizar la epidemia
for i = 1:size(Y(:,1))
  if (Y(i,2) + Y(i,3) <= poblacion * (1 - rec))    % Se buscan cuando un 90% de la poblacion esta recuperada (o vacunada) (La epidemia termino)
    t = Y(i,1);
    s = Y(i,2);
    return
  end
end
end