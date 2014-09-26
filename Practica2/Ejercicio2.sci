function x = STIM(A)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que resuelve el sistema triangular inferior (STI) de ecuaciones
// lineales Ax = c (sustitucion hacia adelante)
// Resuelve el sistema creando un vector c de componentes 1 o -1 de tal forma
// que x sea de magnitud maxima.
//*****************************************************************************
// -> Entrada
//  A (Matriz Real) - Matriz triangular inferior de tamaño n x n con entradas 
//                    reales.
//
// -> Salida
//  x (Vector Real) - Vector de tamaño n con entradas reales que representan la
//                    solucion al sistema de ecuaciones, dado c con componentes 
//                    -1 o 1 que hace a x de magnitud maxima.
//*****************************************************************************
n = size(A,'r');
x = zeros(n,1);
for i = 1:n //(*)
    valone = (1 - A(i,1:i-1)*x(1:i-1))/A(i,i);
    valminus = (-1 - A(i,1:i-1)*x(1:i-1))/A(i,i);
    
    if abs(valone) >= abs(valminus)
      x(i) = valone
    else
      x(i) = valminus
    end
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
n = size(A,'r');
x = zeros(n,1);
for i = n:-1:1 //(*)
    x(i) = (b(i) - A(i,i+1:n)*x(i+1:n))/A(i,i);
end
endfunction

function x = mcond(A,opc)
// Autores: Hector E. Gomez Morales
// Funcion que calcula la condicion de la matriz A. Calcula norm A y estima 
// la norma de A inversa por medio de una aproximacion conocida.
//*****************************************************************************
// -> Entrada
//  A (Matriz Real) - Matriz triangular inferior de tamaño n x n con entradas 
//                    reales.
//
// opc (Real) - Opcion que se quiere realizar. 1 se obtiene una y segun el
//              metodo del inciso a) de la practica, 2 se obtiene y segun el
//              metodo del inciso b) de la practica.
// -> Salida
// x (Real) - Valor real que indica el numero de condicion de la matriz A
//*****************************************************************************

// Realizamos la factorizacion LU
[L,U,E] = lu(A)

// Segun la opcion ingresa es como obtenemos nuestra y para la estimacion.
select opc
case 1
  v = STIM(L.')
  y = STS(U.',v)
  
  // Obteniendo z dada la y encontrada
  w = STI(L,y)
  z = STS(U,w)
case 2
  n = size(A,'r');
  sv = zeros(n,1)
  maxc = 0
  maxv = []

  for j = 1:5
    for i = 1:n
      sv(i) = rand()
    end
  
    w = STI(L,sv)
    z = STS(U,w)
  
    if abs((norm(z)/norm(sv))) > maxc
      maxv = sv
      maxc = abs(norm(z)/norm(sv))
    end
  end

  //disp(maxv)
  y = maxv

  // Obteniendo z dada la y seleccionada
  w = STI(L,y)
  z = STS(U,w)
end

// Estimacion norm A inversa
estAinv = norm(z) / norm(y)

x= norm(A)*estAinv
endfunction

A = [0.641 0.242; 0.321 0.121;]
B = [10 -7 0; -3 2 6; 5 -1 5;]

disp("Matriz A:")
disp(A)

disp("Condicion A (Inciso a):")
disp(mcond(A,1))

disp("Condicion A (Inciso b):")
disp(mcond(A,2))

disp("Condicion A (Scilab)")
disp(cond(A))

disp("Error dado Inciso a):")
disp((cond(A)-mcond(A,1))/cond(A))

disp("Matriz B:")
disp(B)

disp("Condicion B (Inciso a):")
disp(mcond(B,1))

disp("Condicion B (Inciso b):")
disp(mcond(B,2))

disp("Condicion B (Scilab)")
disp(cond(B))

disp("Error dado Inciso b):")
disp((cond(B)-mcond(B,2))/cond(B))

disp("Vemos que la estimacion con inciso a) es mucho mejor para la matrix A")
disp("pero vemos que la estimacion con inciso b) resulta mejor para la matrix B")
