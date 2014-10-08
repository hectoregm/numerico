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
n = size(A,'r');
x = zeros(n,1);
for i = n:-1:1 //(*)
    x(i) = (b(i) - A(i,i+1:n)*x(i+1:n))/A(i,i);
end
endfunction

function [H,b] = hilbert(n)
// Autores: Hector Enrique Gomez Morales
// Funcion que genera una matriz de Hilbert de tamaño nxn
//*****************************************************************************
// -> Entrada
//  n (Real) - Indica el tamaño de la matriz de Hilbert deseada
//
// -> Salida
//  H (Matriz Real) - Una matriz de Hilbert de nxn
//  
//  b (Vector Real) - Vector que es la solucuion de H para Hx = b con todas sus componentes uno.
//*****************************************************************************
H = ones(n,n)
for i=1:n
  for j=1:n
    H(i,j) = 1 / (i+j-1)
  end
end

b = H * (ones(n,1))
endfunction

function r = rhilbert(n)
[H,b] = hilbert(n)
CT = chol(H)

y = STI(CT.', b)
x = STS(CT, y)

disp("Vector b")
disp(b)
disp("H*x")
disp(H*x)
disp("Vector x resuelto:")
disp(x)
disp("b - (H*x)")
disp(b-(H*x))
r = norm(b - (H*x), 'inf')
err = x - ones(n,1)
disp("Normal residual:")
disp(r)
disp("Error dado x:")
disp(err)
disp("Norma del error")
disp(norm(err))
disp("Condicion de H")
disp(cond(H))
endfunction