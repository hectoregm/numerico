function c = interphermite(x,f,fp)
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
funcprot(0)
n = size(x, 'r')
nm = 2*n

z = zeros(1,nm)
Q = zeros(nm,nm)

// Paso 1
for i=1:n

  // Paso 2
  z(2*i-1) = x(i)
  z(2*i) = x(i)
  Q(2*i-1, 1) = f(i)
  Q(2*i,1) = f(i)
  Q(2*i,2) = fp(i)
  
  // Paso 3
  if i ~= 1
    Q(2*i-1, 2) = (Q(2*i-1,1)-Q(2*i-2,1))/(z(2*i-1)-z(2*i-2))
  end
  
end

disp("desplegando z")
disp(z)

for i=3:nm
  for j=3:i
    disp(i,j)
    disp(z(i),z(i-j+1))
    Q(i,j) = (Q(i,j-1)-Q(i-1,j-1))/(z(i)-z(i-j+1))
    disp("Display Q(i,j)")
    disp(Q(i,j))
  end
end

disp("Matriz final")
disp(Q)

c = diag(Q)
endfunction

function [x,f] = plotsolutiona(P)
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
funcprot(0)

X = [-0.5; -0.25; 0]
F = [-0.0247500; 0.3349375; 1.101]
FP = [0.751; 2.189; 4.002]

c = interphermite(X,F,FP)
x = linspace(-0.5,0,P)
f = zeros(1,P)

n = size(c,'r')

for k=1:P
result = c(1)
accum = 1

  for i=2:n
    l = floor(i/2)
    accum = accum * (x(k) - X(l))
    result = result + (c(i) * accum)
  end
  
  f(k) = result
end

plot(X,F, "+-r")
plot(x,f)

endfunction

function [x,f] = plotsolutionb(P)
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
funcprot(0)

X = [0.1; 0.2; 0.3; 0.4]
F = [-0.62049958; -0.28398668; 0.00660095; 0.24842440]
FP = [3.58502082; 3.14033271; 2.66668043; 0.24842440]

c = interphermite(X,F,FP)
x = linspace(0,0.5,P)
f = zeros(1,P)

n = size(c,'r')

for k=1:P
result = c(1)
accum = 1

  for i=2:n
    l = floor(i/2)
    accum = accum * (x(k) - X(l))
    result = result + (c(i) * accum)
  end
  
  f(k) = result
end

plot(X,F, "+-r")
plot(x,f)

endfunction





X = [-0.5; -0.25; 0]
F = [-0.0247500; 0.3349375; 1.101]
FP = [0.751; 2.189; 4.002]
X1 = [0.1; 0.2; 0.3; 0.4]
F1 = [-0.62049958; -0.28398668; 0.00660095; 0.24842440]
FP1 = [3.58502082; 3.14033271; 2.66668043; 0.24842440]
X2 = [1.3; 1.6; 1.9]
F2 = [0.620086; 0.4554022; 0.2818186]
FP2 = [-0.5220232; -0.5698959; -0.5811571]

//disp(interpnewton(X,Y))
//disp(interpnewton(X2,Y2))
interphermite(X2,F2,FP2)
scf(0)
plotsolutiona(100)
scf(1)
plotsolutionb(100)