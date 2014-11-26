function [val,numiter] = newton(p0,funcion,tol,iter)
// Funcion que realiza el metodo de newton para el calculo de ceros de 
// funciones.
// Autor: Hector Gomez, Jorge Zavaleta
//*****************************************************************************
// ->Entrada
//  p0 (Real) - Numero real que denota el punto inicial.
////
//  funcion (String) - Es la funcion a la cual se le quiere encontrar un cero, 
//                     donde la variable dependiente siempre se denota por x.
//                     Ejemplo 'sin(x)' para calcular un cero de la funcion 
//                     seno(x).
//
//  tol (Real - Opcional) - Numero real que especifica la tolerancia para la 
//                          condicion de paro del metodo. Si no se especifica en 
//                          los parametros de entrada el valor por default es 
//                          1D-10.
//
//  iter (Real - Opcional) - Numero real que especifica el numero maximo de 
//                           iteraciones que realiza el metodo (Segunda condicion
//                           de paro). Si no se especifica en los parametros de 
//                           entrada el valor por default es 100.
//
// ->Salida
//  val (Real) - Numero real con el valor del cero encontrado (funcion(val)=0).
//
//  numiter (Real) - Numero real que da el numero de iteraciones que realizo el 
//                   metodo. numiter<iter si se alcanzo la tolerancia (tol) o 
//                   numiter=iter en caso contrario.
//*****************************************************************************

// Se verifica cuantos argumentos de entrada se tiene y se asignan valores por 
// defecto a los argumentos opcionales que no se hayan definido
rhs = argn(2);// Da el numero de argumentos de entrada
if rhs < 4 then // Solo se definio el intervalo de busqueda y la funcion
    tol = 1D-10;
    iter = 100;
elseif rhs < 5 then // Se definio adicionalmente la tolerancia
    iter = 100;
end

// Se define la funcion que se quiere evaluar y se inicializa el contador de 
// iteraciones
numiter = 1;
cad1 = 'y=';
funcprot(0)
deff('[y]=f(x)',cad1 + funcion);

p1 = 100000

//Comienza el metodo
while abs(p0 - p1) > tol & numiter < iter //(b - a) > tol & numiter < iter
    numiter = numiter + 1;
    
    if p0 ~= 0
      h = sqrt(%eps)*abs(p0)
    else
      h = sqrt(%eps)*abs(1)
    end 
    
    fp = (f(p0 + h) - f(p0)) / h
    
    if fp == 0
      val = p0
      disp("Derivada cero")
      return  
    end
    
    p1 = p0
    p0 = p0 - (f(p0)/fp)
end
val = p0
endfunction


disp("Haciendo uso de newton para encontrar el punto en que hace cero la función:")
disp("f(x) = 135000 - (1000/x)*(1-((1+x)^(-50)))")
disp("Raíz obtenida empezando en 1")
[val, numiter] = newton(1,"135000 - (1000/x)*(1-((1+x)^(-50)))",1D-7)
disp("Aunque tenemos que no converge dado que en un punto se tiene que la derivada es cero")
disp("Graficando g(x) = (1000/x)*(1-((1+x)^(-50))), tenemos que el la cantidad máxima que se puede acumular por")
disp("pagos de 1000 a 30 años es de 55,000 lo cual no se acerca por mucho a la hipoteca de 135000")
disp("Por lo tanto sin importar el método usado se tendría que no hay una taza de interés que satisfaga lo requerimientos puestos.")

x = linspace(-0.01,0.1,10000)
y = zeros(10000,1)

for i=1:10000
  if x(i) ~= 0
    y(i) = (1000/x(i))*(1-((1+x(i))^(-50)))
  else
    y(i) = 0
  end 
end


plot(x,y)

