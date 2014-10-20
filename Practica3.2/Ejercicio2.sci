function v = vandermonde(a,n)
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
s = size(a, 'r')
v = ones(s,n)

for k=2:n
  v(1:s, k) = (a.^(k-1))
end
endfunction

function x = applypol(c, t)
// Autores: Hector E. Gomez Morales
// Funcion dado un vector de los coeficientes de un polinomio de grado n-1 con n el tamaño del vector c y un t obtiene el valor del polinomio en el punto t.
//*****************************************************************************
//->Entrada
// c (Vector Real) - Vector con los coeficientes del polinomio de grado n-1 (n el tamaño del vector)
//
// t (Real) - Un real
//
//->Salida
// x (Real) - Valor que toma el polinomio en el punto t
//
//*****************************************************************************
n = size(c, 'r')
x = c(1)
for k=2:n
  x = x + (c(k) * (t^(k-1)))
end
endfunction

function v = getsol(c,p)
// Autores: Hector E. Gomez Morales
// Funcion dado un vector de los coeficientes de un polinomio de grado n-1 con n el tamaño del vector c y un t obtiene el valor del polinomio en el punto t.
//*****************************************************************************
//->Entrada
// c (Vector Real) - Vector con los coeficientes del polinomio de grado n-1 (n el tamaño del vector)
//
// p (Vector Real) - Un vector con puntos en R
//
//->Salida
// v (Vector Real) - Un vector con el resultado de calcular el valor del polinomio en cada punto del vector p.
//
//*****************************************************************************
n = size(p, 'r')
v = zeros(n, 1)

for k=1:n
  v(k) = applypol(c, p(k))
end
endfunction

x = [0; 1; 2; 3; 4; 5]
y = [1.0; 2.7; 5.8; 6.6; 7.5; 9.9]

v0 = vandermonde(x,1)
v1 = vandermonde(x,2)
v2 = vandermonde(x,3)
v3 = vandermonde(x,4)
v4 = vandermonde(x,5)
v5 = vandermonde(x,6)

s0 = v0\y
s1 = v1\y
s2 = v2\y
s3 = v3\y
s4 = v4\y
s5 = v5\y

disp(v0)
disp(v1)
disp(v2)
disp(v3)
disp(v4)
disp(v5)

disp("Solucion para n = 0:")
disp(s0)
disp("Solucion para n = 1:")
disp(s1)
disp("Solucion para n = 2:")
disp(s2)
disp("Solucion para n = 3:")
disp(s3)
disp("Solucion para n = 4:")
disp(s4)
disp("Solucion para n = 5:")
disp(s5)

plot2d(x,[y getsol(s0,x) getsol(s1,x) getsol(s2,x) getsol(s3,x) getsol(s4,x) getsol(s5,x)],[4 1 3 -2 5 6 -1], leg="Data@P0@P1@P2@P3@P4@P5")

disp("Se puede ver que conforme n crece se tiene una mejor aproximacion a los datos proporcionados siendo P5 la aproximacion exacta a los datos.")
disp("Pero esto es como un sobreajuste a los datos dados pienso que P2 que son los X en la grafica presentan la tendencia general usando solamente")
disp("Un polinomio cuadratico este polinomio se mantiene dentro de la franja de los valores de los datos.")
