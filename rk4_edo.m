%Entradas 
% - a y b son los extremos del intervalo de integración 
% - ya es la condición inicial y(a) 
% - N es el número de pasos 
% - h es el paso de integracion
% Salida 
% - T es el vector de las abscisas (eje x)
% - Y es el vector de la solución aproximada. 
function [T, Y]=rk4_edo(f,a,b,ya,N, h)
T=zeros(N+1,1); 
Y=zeros(N+1,length(ya)); 
T(1)=a; 
Y(1,:)=ya; 
for j=1:N
  T(j+1)=T(j)+h;
  K1=h*f(T(j),Y(j,:)); 
  K2=h*f(T(j)+(h/2),Y(j,:)+(K1/2)); 
  K3=h*f(T(j)+(h/2),Y(j,:)+(K2/2)); 
  K4=h*f(T(j)+h,Y(j,:)+K3);
  Y(j+1,:) = Y(j,:) + (K1+2*K2+2*K3+K4)/6; 
end 