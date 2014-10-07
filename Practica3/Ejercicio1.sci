function L = cholesky(A)
// Autores: Hector E. Gomez Morales
// Funcion que realiza la factorizacion de cholesky ie A = LL^t (L triangular inferior)
// Regresa L una matriz triangular inferior
// A debe ser una matriz cuadrada, simetrica y definida positiva para que se pueda realizar esta factorizacion
//*****************************************************************************
//->Entrada
// A (Matriz Real) - Matriz de tamaño n x n con entradas reales.
//
// -> Salida
// L (Matriz Real) - Matriz tal que L*L^t = A A la matriz original
//*****************************************************************************
n=size(A,'c');
for k=1:n
  A(k,k) = sqrt(A(k,k))
  for i=k+1:n
    A(i,k) = A(i,k) / A(k,k)
  end
  for j=k+1:n
    for i=k+1:n
      A(i,j) = A(i,j) - (A(i,k) * A(j,k))
    end
  end
end

L = tril(A)
endfunction

A = [4 1 1 1; 1 3 -1 1; 1 -1 2 0; 1 1 0 2]
B = [4 1 -1 0; 1 3 -1 0; -1 -1 5 2; 0 0 2 4]
C = [6 2 1 -1; 2 4 1 0; 1 1 4 -1; -1 0 -1 3]
D = [3 -1 -1; -1 3 -1; -1 -1 3]

disp("Matriz A:")
disp(A)
disp("Factorizacion de Cholesky de A:")
disp(cholesky(A))

disp("Matriz B:")
disp(B)
disp("Factorizacion de Cholesky de B:")
disp(cholesky(B))

disp("Matriz C:")
disp(C)
disp("Factorizacion de Cholesky de C:")
disp(cholesky(C))

