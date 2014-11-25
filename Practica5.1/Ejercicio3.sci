function c = interphermite(x,f,fp)
// Autores: Hector E. Gomez Morales
// Funcion que realiza la interpolacion de Hermite dado un conjuntos de puntos y su primera derivada.
//*****************************************************************************
//->Entrada
// x (Vector Real) - Vector columna que contiene los numeros x(i)
//
// f (Vector Real) - Vector columna que contiene los valores (imagenes) su x(i) correspondiente
//
// fp (Vector Real) - Vector columna que contiene la derivada en los x(i) correspondientes
//
//->Salida
// c (Matriz Real) - Vector columna que contiene los coeficientes Q(i,i), ie los coeficientes de la interpolacion de Hermite
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

for i=3:nm
  for j=3:i
    Q(i,j) = (Q(i,j-1)-Q(i-1,j-1))/(z(i)-z(i-j+1))
  end
end

c = diag(Q)
endfunction

function [x,f] = plotsolutiona(P)
// Autores: Hector E. Gomez Morales
// Funcion que obtiene la interpolacion de Hermite del inciso a) del Ejercicio 3
// Obtiene los coeficientes y obtiene los puntos para graficar el polinomio
//*****************************************************************************
//->Entrada
// P (Real) - Numero de puntos a graficar de la interpolacion de la solucion a
//
//->Salida
// x (Vector Real) - Vector con los P puntos generados
//
// f (Vector Real) - Vector con las imagenes usando el polinomio de interpolacion de Hermite
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
title("Polinomio Interpolación Hermite Inciso a)","color","red","fontsize",4);
xlabel("Rojo datos, Azul interpolación")
endfunction

function [x,f] = plotsolutionb(P)
// Autores: Hector E. Gomez Morales
// Funcion que obtiene la interpolacion de Hermite del inciso b) del Ejercicio 3
// Obtiene los coeficientes y obtiene los puntos para graficar el polinomio
//*****************************************************************************
//->Entrada
// P (Real) - Numero de puntos a graficar de la interpolacion de la solucion b
//
//->Salida
// x (Vector Real) - Vector con los P puntos generados
//
// f (Vector Real) - Vector con las imagenes usando el polinomio de interpolacion de Hermite
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
title("Polinomio Interpolación Hermite Inciso b)","color","red","fontsize",4);
xlabel("Rojo datos, Azul interpolación")
endfunction

X2 = [1.3; 1.6; 1.9]
F2 = [0.620086; 0.4554022; 0.2818186]
FP2 = [-0.5220232; -0.5698959; -0.5811571]

//disp(interpnewton(X,Y))
//disp(interpnewton(X2,Y2))
scf(0)
plotsolutiona(100)
scf(1)
plotsolutionb(100)