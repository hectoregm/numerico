function c = interpnewton(x,f)
// Autores: Hector E. Gomez Morales
// Funcion que crea una matriz de vandermonde segun un vector de coeficientes
// y un tamaño del grado de polinomio que queremos.
//*****************************************************************************
//->Entrada
// a (Vector Real) - Vector con los coeficientes alpha de la matriz de vandermonde
//
// n (Real) - Grado del polinomio asociado a la matriz de vandermonde
//
//->Salida
// v (Matriz Real) - Matriz de vandermonde con los coeficientes dados.
//
//*****************************************************************************
funcprot(0)
n = size(x, 'r')
F = zeros(n,n)

F(1:n,1) = f

disp("Matriz inicial")
disp(F)

for j=2:n
  for i=j:n
    F(i,j) = (F(i,j-1) - F(i-1,j-1))/(x(i)-x(i-j+1))
    
    disp("Valor F(i,j)")
    disp(F(i,j))
  end
end

disp("Matriz final")
disp(F)

c = diag(F)
endfunction

function [x,f] = plotsolution(X,Y,P)
// Autores: Hector E. Gomez Morales
// Funcion que crea una matriz de vandermonde segun un vector de coeficientes
// y un tamaño del grado de polinomio que queremos.
//*****************************************************************************
//->Entrada
// a (Vector Real) - Vector con los coeficientes alpha de la matriz de vandermonde
//
// n (Real) - Grado del polinomio asociado a la matriz de vandermonde
//
//->Salida
// v (Matriz Real) - Matriz de vandermonde con los coeficientes dados.
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