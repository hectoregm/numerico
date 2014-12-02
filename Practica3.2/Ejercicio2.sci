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

function x = STI(A,b)
// Autores: Jorge Zavaleta
// Funcion que resuelve el sistema triangular inferior (STI) de ecuaciones
// lineales Ax = b (sustitucion hacia adelante)
//*****************************************************************************
// -> Entrada
//  A (Matriz Real) - Matriz triangular inferior de tamaño n x n con entradas 
//                    reales.
//
//  b (Vector Real) - Vector de tamaño n con entradas reales.
//
// -> Salida
//  x (Vector Real) - Vector de tamaño n con entradas reales que representan la
//                    solucion al sistema de ecuaciones.
//*****************************************************************************
n = size(A,'r');
x = zeros(n,1);
for i = 1:n //(*)
    x(i) = (b(i) - A(i,1:i-1)*x(1:i-1))/A(i,i);
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

function [A,b] = generate_matrix(m,n,epsilon)
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
  A = ones(m,n)
  t = zeros(m,1)
  y = zeros(m,1)
  
  rand("uniform")
  
  for i=1:m
    t(i) = (i-1) / (m-1)
    
    y(i) = 1
    
    for k=1:n-1
      y(i) = y(i) + t(i)^k
    end
  end
  
  for i=1:m
    y(i) = y(i) + epsilon*(2*rand() - 1)
  end
    
  b = y
  
  for k=2:n
    A(1:m, k) = (t.^(k-1))
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

  Lt = chol(B)
  L = Lt'
  y = STI(L,bp)
  x = STS(Lt, y)
endfunction

function x = sol_qr(A,b)
// Autores: Hector E. Gomez Morales
// Funcion que resuelve el sistema Ax = b usando factorizacion QR mediante Householder
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
  [Q,R] = qrhouse(A)
  y = Q'*b
  x = STS(R,y)
endfunction 

[A,b] = generate_matrix(27,12,1D-10)
disp("Generando matriz:")
disp(A)
disp("Generando vector y:")
disp(b)

disp("Solucionando usando ecuaciones normales con Cholesky:")
x = sol_ec_normales(A,b)
disp(x)

r = norm(b - (A*x), 'inf')
err = x - ones(12,1)
disp("Normal residual:")
disp(r)
disp("Norma del error")
disp(norm(err, 'inf'))

disp("Solucionando usando factorizacion QR:")
x = sol_qr(A,b)
disp(x)
r = norm(b - (A*x), 'inf')
err = x - ones(12,1)
disp("Normal residual:")
disp(r)
disp("Norma del error")
disp(norm(err, 'inf'))

disp("Se tiene que el metodo de ecuaciones normales tiene la mayor perturbacion en contraste con el metodo QR")
disp("El metodo que esta mas proximo a recuperar la solucion exacta es el metodo QR, su error es menor a 1D-4")
disp("Esta diferencia si afecta el ajuste puesto que la solucion es realmente los coeficientes de los terminos del polinomio")
disp("Asi se tienen otro tipo de funcion polinomio con una muy pequeña perturbacion de y")