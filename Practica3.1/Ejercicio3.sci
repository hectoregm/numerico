function [m,b] = createmat()
// Autores: Hector E. Gomez Morales
// Funcion que una matriz a partir de los datos del problema
x = [1.02; 0.95; 0.87; 0.77; 0.67; 0.56; 0.44; 0.30; 0.16; 0.01]
y = [0.39; 0.32; 0.27; 0.22; 0.18; 0.15; 0.13; 0.12; 0.13; 0.15]
n = size(x, 'r')
m = ones(n, 5)
b = ones(n, 1)

for i=1:n
  m(i,1) = y(i)^2
  m(i,2) = x(i)*y(i)
  m(i,3) = x(i)
  m(i,4) = y(i)
  b(i) = x(i)^2
end
endfunction

function h = fun2(x,y)
// Autores: Hector E. Gomez Morales
// Funcion que obtiene los coeficientes de la ecuacion cuadratica y que obtiene el valor del punto (x,y) dado.
[m,b] = createmat()
x = -m\b
h = x^2 + c(2)*x*y + c(1)*y^2 + c(3)*x + c(4)*y + c(5)
endfunction

function h = fun(x,y)
// Autores: Hector E. Gomez Morales
// Funcion equivalente a la funcion fun2 pero que tiene ya definidos los coeficientes que hallamos esto para hacer mas rapida la graficacion
h = x^2 - 0.143*x*y + 2.635*y^2 - 0.551*x - 3.222*y + 0.432
endfunction

x = [1.02; 0.95; 0.87; 0.77; 0.67; 0.56; 0.44; 0.30; 0.16; 0.01]
y = [0.39; 0.32; 0.27; 0.22; 0.18; 0.15; 0.13; 0.12; 0.13; 0.15]

xset("wdim",400,400);
xset("fpf"," ");
square(-1,0,1.5,1.2);

data = linspace(-2, 2, 512);
contour2d(data, data, fun, [0,0], style=color("red"), axesflag=1);
plot2d(x, y, -1, leg="Data")
