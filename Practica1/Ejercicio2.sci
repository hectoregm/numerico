function [A, signo] = escalonar(A)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que toma una matriz cuadrada A y regresa la matriz asociada en forma escalonada.
//************************************************************************
//-> Entrada
//  A (Matriz) - Matriz cuadrada a escalonar
//
//-> Salida
//  A (Matriz) - Matriz en forma escalonada derivada de la matriz de entrada C
//
//  signo (Real) - Indica el signo de la determinante de la matriz escalonada
//************************************************************************
n = size(A, 'r'); // Determina el numero de renglones en la matriz
signo = 1;
for i = 1 : n-1
  // Obtiene el valor maximo (en valor absoluto) de la columna i-esima tomando los valores en [i:n],
  // y su posicion en el vector columna en que se encuentra el valor maximo
  [val,r] = max(abs(A(i:n,i)));
  // Dado r era el renglon con respecto al vector columna A(i:n,i) que era de rango [i:n]
  // se suma i y -1 para obtener el renglon en referencia a la matriz A.
  r = r + i - 1;
  
  // Si intercambiamos renglones el signo de la determinante cambia de signo
  if r ~= i
    signo = signo * -1
    // Hacemos la operacion elemental de intercambiar dos renglones r y i desde la columna i hasta la columna final
    // Asi en la posicion A(i,i) se tiene el mayor valor en termino absolutos de la submatriz A(i:n,i:n)
    A([i r], i:n) = A([r i], i:n);
  end
  
  for k = i+1 : n
    // Obtenemos el factor entre el maximo valor obtenido previamente y el valor que se encuentra en la misma columna
    // Pero en un renglon k inferior
    fac = A(k,i)/A(i,i);
    // Hacemos la operacion elemental al multiplicar por el factor obtenido anteriormente al renglon i y esto es restado
    // al renglon k, asi hacemos cero al valor A(k,i) y actualizamos los demas valores en el renglon k
    A(k,i+1:n) = A(k,i+1:n) - fac*A(i,i+1:n);
  end
  // Aqui finalmente actualizamos la matriz dado que hicimos cero a todos los valores del vector columna debajo de A(i,i) dado las operaciones del ciclo anterior
  A(i+1:n,i) = 0;
end
endfunction

function d = mdet(A)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que realiza el calculo del determinante usando la propiedad de las matrices escalonadas
// en las cuales su determinante es igual al producto de los elementos de la diagonal principal
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
			d = 0;
      [AE,signo] = escalonar(A)
      d = signo * prod(diag(AE))
	end
end
endfunction 

M = [-3,2,-1;3,0.25,-0.80;0.666,7,-5;]
M2 = [-3,0,-1,0;2,0,1,2;4,0,-5,0;0,1,0,0;]

disp("Tenemos la siguiente matriz 3x3")
disp(M)
[RM, signo] = escalonar(M)
disp("Su forma escalonada es:")
disp(RM)
disp("Su determinante es:")
disp(mdet(M))

disp("Tenemos la siguiente matriz 4x4")
disp(M2)
[RM, signo] = escalonar(M2)
disp("Su forma escalonada es:")
disp(RM)
disp("Su determinante es:")
disp(mdet(M2))