function [Q,R] = qrhouse(A)
// Funcion que realiza la factorizacion QR mediante transformaciones de 
// Householder.
// ****************************************************************************
// Entrada
//   A (Matriz Real) - Matriz de tamaño m x n con entradas reales.
//
// Salida
//   Q (Matriz Real) - Matriz ortogonal de tamaño m x m con entradas reales.
//
//   R (Matriz Real) - Matriz triangular superior de tamaño m x n con entradas 
//                     reales.
// ****************************************************************************
funcprot(0)
[m,n] = size(A);
Q = eye(m,m);
R = A;
for k = 1 : min([m,n])
    v = R(k:m,k);
    aux = length(v);
    alpha = -sign(v(1))*norm(v);
    v = v - alpha * [1; zeros(aux-1,1)];
    v = v/norm(v);
    R(k:m,k:n) = R(k:m,k:n) - 2 * v * (v' * R(k:m,k:n));
    R(k+1:m,k) = 0;
    Q(:,k:m) = Q(:,k:m)  - 2 * (Q(:,k:m)* v) * v';
end
endfunction

function x = STS(A,b)
// Autores: Jorge Zavaleta
// Funcion que resuelve el sistema triangular superior (STS) de ecuaciones
// lineales Ax = b (sustitucion hacia atras)
//*****************************************************************************
// -> Entrada
//  A (Matriz Real) - Matriz triangular superior de tamaño n x n con entradas 
//                    reales.
//
//  b (Vector Real) - Vector de tamaño n con entradas reales.
//
// -> Salida
//  x (Vector Real) - Vector de tamaño n con entradas reales que representan la
//                    solucion al sistema de ecuaciones.
//*****************************************************************************
funcprot(0)
n = size(A,'c');
x = zeros(n,1);
for i = n:-1:1 //(*)
    x(i) = (b(i) - A(i,i+1:n)*x(i+1:n))/A(i,i);
end
endfunction

function x = sol_ec_normales(A,b)
// Autores: Hector E. Gomez Morales
// Funcion que resuelve el sistema Ax = b usando ecuaciones normales
//*****************************************************************************
// -> Entrada
//  A (Matriz Real) - Matriz de mxn
//
//  b (Vector Real) - Vector de tamaño m con entradas reales.
//
// -> Salida
//  x (Vector Real) - Vector de tamaño n con entradas reales que representan la
//                    solucion al sistema de ecuaciones.
//*****************************************************************************
  funcprot(0)
  At = A'
  bp = At*b
  B = At*A
  chol(B)
  disp("Cholesky")
  disp(chol(B))
  x = inv(B)*bp
endfunction

function x = sol_manual_ecn(epsilon)
// Autores: Hector E. Gomez Morales
// Funcion genera la solucion exacta usando ecuaciones normales, las ecuaciones
// se obtuvieron a mano
//*****************************************************************************
// -> Entrada
//  epsilon (Valor Real) - Valor de epsilon en la matriz
//
// -> Salida
//  x (Vector Real) - la solucion exacta de la matriz del inciso a)
//*****************************************************************************
funcprot(0)
x = zeros(3,1)
x(3) = (((2*e^2)+e^4)*(1+(e^2)) - 2*e^4) / (((2*e^2 + e^4)*(1 + e^2)^2) - 2*e^4)
x(2) = (e^2 - (e^2*x(3))) / ((2*e^2) + e^4)
x(1) = (1 - x(2) - x(3)) / (1 + e^2)
endfunction

function G = make_givens(v,i,j,n)
// Autores: Hector E. Gomez Morales
// Funcion genera una matriz de rotacion de givens dado un vector, las posicion i y j del vector
// en las cuales se quiere hacer 0 al valor en j. Siendo n el tamaño de la matriz de givens
//*****************************************************************************
// -> Entrada
//  v (Vector Real) - Vector al cual se le realiza la rotacion
//
//  i (Valor Real) - Elemento i del vector v que es el pivote
//
//  j (Valor Real) - Elemento j del vector v que se convertira en un cero al realizar la rotacion
//
// -> Salida
//  G (Matriz Real) - Matriz de Givens que realiza la operacion deseada
//*****************************************************************************
G = eye(n,n)
num = sqrt(v(i)^2 + v(j)^2)

c = v(i) / num
s = v(j) / num

G(i,i) = c
G(i,j) = s
G(j,i) = -s
G(j,j) = c
endfunction

function [Q,R] = fac_givens(A)
// Autores: Hector E. Gomez Morales
// Funcion realiza la factorizacion de una matriz usando rotaciones de Givens
//*****************************************************************************
// -> Entrada
//  A (Matriz Real) - Matriz a realizar la factorizacion
//
// -> Salida
//  Q (Matriz Real) - Parte de la factorizacion es una matriz ortogonal
//
//  R (Matriz Real) - Es una matriz triangular superior de tal forma que QR = A
//*****************************************************************************
  n = size(A, 'r')
  R = A
  G = ones(n,n)
  
  for i=1:n-1
    for j=i+1:n
      v = R(1:4,i)
      
      if R(j,i) ~= 0
        GP = make_givens(v,i,j,n)
        G = GP*G
        R = GP*R
      end
    end
  end
  
  Q = G'
  R = triu(R)

endfunction

e = 0.1
A = [1 1 1; e 0 0; 0 e 0; 0 0 e]
b = [1; 0; 0; 0]

disp("Matriz A es:")
disp(A)

disp("El vector b es:")
disp(b)

disp("Epsilon es:")
disp(e)

disp("La solución exacta al problema de mínimos cuadrados lineales de A:")
disp(sol_manual_ecn(e))

disp("Solución del sistema por ecuaciones normales:")
disp(sol_ec_normales(A,b))

disp("Solucion del sistema por factorizacion QR con Householder:")
[Q,R] = qrhouse(A)

y = Q'*b
x = STS(R,y)
disp(x)

[Q,R] = fac_givens(A)
y = Q'*b
x = STS(R,y)
disp("Solucion del sistema por factorizacion por Givens:")
disp(x)


e = 1D-7
A = [1 1 1; e 0 0; 0 e 0; 0 0 e]
b = [1; 0; 0; 0]

disp("Epsilon es:")
disp(e)

disp("La solución exacta al problema de mínimos cuadrados lineales de A:")
disp(sol_manual_ecn(e))

disp("Solución del sistema por ecuaciones normales:")
disp(sol_ec_normales(A,b))

disp("Solucion del sistema por factorizacion QR con Householder:")
[Q,R] = qrhouse(A)

y = Q'*b
x = STS(R,y)
disp(x)

[Q,R] = fac_givens(A)
y = Q'*b
x = STS(R,y)
disp("Solucion del sistema por factorizacion por Givens:")
disp(x)

e = %eps
A = [1 1 1; e 0 0; 0 e 0; 0 0 e]
b = [1; 0; 0; 0]

disp("Epsilon es:")
disp(e)

disp("La solución exacta al problema de mínimos cuadrados lineales de A:")
disp(sol_manual_ecn(e))

disp("Solucion del sistema por factorizacion QR con Householder:")
[Q,R] = qrhouse(A)

y = Q'*b
x = STS(R,y)
disp(x)

[Q,R] = fac_givens(A)
y = Q'*b
x = STS(R,y)
disp("Solucion del sistema por factorizacion por Givens:")
disp(x)

e = sqrt(%eps)
A = [1 1 1; e 0 0; 0 e 0; 0 0 e]
b = [1; 0; 0; 0]

disp("Epsilon es:")
disp(e)

disp("La solución exacta al problema de mínimos cuadrados lineales de A:")
disp(sol_manual_ecn(e))

disp("Solucion del sistema por factorizacion QR con Householder:")
[Q,R] = qrhouse(A)

y = Q'*b
x = STS(R,y)
disp(x)

[Q,R] = fac_givens(A)
y = Q'*b
x = STS(R,y)
disp("Solucion del sistema por factorizacion por Givens:")
disp(x)