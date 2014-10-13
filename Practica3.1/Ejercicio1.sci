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

