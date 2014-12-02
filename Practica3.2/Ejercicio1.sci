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
  funcprot(0)
  At = A'
  bp = At*b
  B = At*A
  x = inv(B)*bp
endfunction

function x = sol_manual_ecn(epsilon)
funcprot(0)
x = zeros(3,1)
x(3) = (((2*e^2)+e^4)*(1+(e^2)) - 2*e^4) / (((2*e^2 + e^4)*(1 + e^2)^2) - 2*e^4)
x(2) = (e^2 - (e^2*x(3))) / ((2*e^2) + e^4)
x(1) = (1 - x(2) - x(3)) / (1 + e^2)
endfunction

e = 1D-3
A = [1 1 1; e 0 0; 0 e 0; 0 0 e]
b = [1; 0; 0; 0]
[Q,R] = qrhouse(A)

y = Q'*b
x = STS(R,y)

c = (e^2) / ((2*e^2) + e^4)
s = [c; c; 0]

c3 = (((2*e^2)+e^4)*(1+(e^2)) - 2*e^4) / (((2*e^2 + e^4)*(1 + e^2)^2) - 2*e^4)
c2 = (e^2 - (e^2*c3)) / ((2*e^2) + e^4)
c1 = (1 - c2 - c3) / (1 + e^2)

disp("Matriz A es:")
disp(A)

disp("El vector b es:")
disp(b)

disp("La solución exacta al problema de mínimos cuadrados lineales de A:")
disp(sol_manual_ecn(%eps))

disp("Solución del sistema por ecuaciones normales")
B = A'*A
bp = A'*b


//disp("Su solucion usando ecuaciones normales es:")
//disp(sol_ec_normales(A))