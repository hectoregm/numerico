function c = interpnewton(x,f)
// Autores: Hector E. Gomez Morales
// Funcion que realiza la interpolacion de Newton dado un conjuntos de puntos y sus imagenes.
//*****************************************************************************
//->Entrada
// x (Vector Real) - Vector columna que contiene los numeros x(i)
//
// f (Vector Real) - Vector columna que contiene los valores (imagenes) su x(i) correspondiente
//
//->Salida
// c (Matriz Real) - Vector columna que contiene los coeficientes F(i,i), ie los coeficientes de la interpolacion de Hermite
//
//*****************************************************************************
funcprot(0)
n = size(x, 'r')
F = zeros(n,n)

F(1:n,1) = f

for j=2:n
  for i=j:n
    F(i,j) = (F(i,j-1) - F(i-1,j-1))/(x(i)-x(i-j+1))
  end
end

c = diag(F)
endfunction

function [x,f] = plotsolution(X,Y,P)
// Autores: Hector E. Gomez Morales
// Funcion que obtiene la interpolacion de Newton del inciso a) y b) del Ejercicio 2
// Obtiene los coeficientes y obtiene los puntos para graficar el polinomio
//*****************************************************************************
//->Entrada
// X (Vector Real) - Vector columna que contiene los numeros x(i)
//
// Y (Vector Real) - Vector columna que contiene las imagenes correspondientes a los numeros x(i)
//
// P (Real) - Numero de puntos a graficar de la interpolacion de la solucion
//
//->Salida
// x (Vector Real) - Vector con los P puntos generados
//
// f (Vector Real) - Vector con las imagenes usando el polinomio de interpolacion de Hermite
//
//*****************************************************************************
funcprot(0)

c = interpnewton(X,Y)
x = linspace(0,1.1,P)
f = zeros(1,P)

n = size(c,'r')

for k=1:P
result = c(1)
accum = 1

  for i=2:n
    accum = accum * (x(k) - X(i-1))
    result = result + (c(i) * accum)
  end
  
  f(k) = result
end

plot(X,Y, "+-r")
plot(x,f)
title("Polinomio Interpolación Newton","color","red","fontsize",4);
xlabel("Rojo datos, Azul interpolación")
endfunction

X = [0; 0.1; 0.3; 0.6; 1.0]
Y = [-6.0; -5.89483; -5.65014; -5.17788; -4.28172;]
X1 = [0; 0.1; 0.3; 0.6; 1.0; 1.1;]
Y1 = [-6.0; -5.89483; -5.65014; -5.17788; -4.28172; 3.99583]
X2 = [1.0;1.3;1.6;1.9;2.2]
Y2 = [0.7651977;0.6200860;0.4554022;0.2818186;0.1103623]

//disp(interpnewton(X,Y))
//disp(interpnewton(X2,Y2))
scf(0)
plotsolution(X,Y,100)
scf(1)
plotsolution(X1,Y1,200)