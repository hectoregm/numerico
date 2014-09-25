function x = STI(A,b)
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

function [L,U,signo] = faclupp(A)
// Funcion que realiza la factorizacion LU de la matriz A (A = L*U) usando pivoteo parcial
//*****************************************************************************
//->Entrada
// A (Matriz Real) - Matriz de tamaño n x n con entradas reales.
//
//->Salida
// L (Matriz Real) - Matriz triangular inferior de tamaño n x n.
//
// U (Matriz Real) - Matriz triangular superior de tamaño n x n.
//
// signo (Real) - Indica el signo de la determinante de la matriz
//*****************************************************************************

n=size(A,'r');
signo = 1;
for i=1:n-1
    [val,r] = max(abs(A(i:n,i)));
    r = r + i - 1;
    if r ~= i
        signo = signo * -1
        A([i r],1:n) = A([r i],1:n);
    end
  
    for k=i+1:n
        A(k,i)=A(k,i)/A(i,i);            
        A(k,i+1:n)=A(k,i+1:n)-A(k,i)*A(i,i+1:n);
    end
end

// Se extrae L y U de A.
L = eye(n,n) + tril(A,-1);
U = triu(A);
endfunction


function x = lur(A,b)
// Funcion que resuelve un sistema de ecuaciones usando factorizacion LU 
// el sistema de ecuaciones lineales Ax = b mediante factorizacion LU, STI y STS 
//*****************************************************************************
//->Entrada
// A (Matriz Real) - Matriz de tamaño n x n con entradas reales.
//
//  b (Vector Real) - Vector de tamaño n con entradas reales.
//
// -> Salida
//  x (Vector Real) - Vector de tamaño n con entradas reales que representan la
//                    solucion al sistema de ecuaciones.
//*****************************************************************************
n=size(A,'r');
signo = 1;
for i=1:n-1
    [val,r] = max(abs(A(i:n,i)));
    r = r + i - 1;

    if r ~= i
        signo = signo * -1
        A([i r],1:n) = A([r i],1:n);
        b([i r]) = b([r i]);
    end
      
    for k=i+1:n
        A(k,i)=A(k,i)/A(i,i);            
        A(k,i+1:n)=A(k,i+1:n)-A(k,i)*A(i,i+1:n);
    end
end

// Se extrae L y U de A.
L = eye(n,n) + tril(A,-1);
U = triu(A);

disp(L)
disp(U)
disp(b)

y = STI(L,b)
x = STS(U,y)
endfunction

function d = mdet(A)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que realiza el calculo del determinante usando factorizacion LU
// y la propiedad de que el determinante de matrices escalonada es el producto
// de su diagonal y ademas que det(AB) = det(A)det(B)
//*****************************************************************************
//->Entrada
// A (Matriz Real) - Matriz de tamaño m x n con entradas reales.
//
//->Salida
// d (Real) - Valor del determinante de A cuando se puede calcular o %nan
//            en el caso contrario.
//*****************************************************************************
nr = size(A,'r');
if nr ~= size(A,'c'); //Matriz no cuadrada
    disp('La matriz no es cuadrada');
    d = %nan;
else
    select nr
		case 1 //Escalar
			d = A;
		else //Matriz nxn
      [L,U,signo] = faclupp(A)
      dl = prod(diag(L))
      du = prod(diag(U))
      d = dl*du
	end
end
endfunction 

A = [2,4,-2;4,9,-3;-2,-1,7;]
B = [4;8;-6]
C = [2,4,-2;4,-1,-3;-2,9,7;]
