function [val, numiter] = puntofijo(p0, tol, iter)
// Funcion que encuentra el punto fijo de una funcion g(x) = 1 + 0.5*sin(x)
// Autor: Hector Gomez, Jorge Zavaleta
//*****************************************************************************
// ->Entrada
//  p0 (Real) - Numero real que denota el punto inicial de busqueda.
////
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
//  val (Real) - Numero real con el valor del cero encontrado (g(val)=val).
//
//  numiter (Real) - Numero real que da el numero de iteraciones que realizo el 
//                   metodo. numiter<iter si se alcanzo la tolerancia (tol) o 
//                   numiter=iter en caso contrario.
//*****************************************************************************

// Se verifica cuantos argumentos de entrada se tiene y se asignan valores por 
// defecto a los argumentos opcionales que no se hayan definido
rhs = argn(2);// Da el numero de argumentos de entrada
if rhs < 2 then // Solo se definio el intervalo de busqueda y la funcion
    tol = 1D-10;
    iter = 100;
elseif rhs < 3 then // Se definio adicionalmente la tolerancia
    iter = 100;
end

// Se define la funcion que se quiere evaluar y se inicializa el contador de 
// iteraciones
numiter = 0;
cad1 = 'y=';
funcprot(0)
deff('[y]=g(x)',cad1 + "1 + 0.5*sin(x)");

p1 = 10D10

//Comienza el metodo
while abs(p0 - p1) > tol & numiter < iter //(b - a) > tol & numiter < iter
    numiter = numiter + 1;
    
    if p0 ~= 0
      h = sqrt(%eps)*abs(p0)
    else
      h = sqrt(%eps)*abs(1)
    end 
    
    gp = (g(p0 + h) - g(p0)) / h
    
    if abs(gp) < 1
      p1 = p0
      p0 = g(p0)
    else
      return
    end
end
val = p0

endfunction

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
      return  
    end
    
    p1 = p0
    p0 = p0 - (f(p0)/fp)
end
val = p0
endfunction

disp("Para un prestamo de a = $100,000.00 y pagos anuales de p = $10,000.00 y taza de r = 0.06 cuanto tiempo tarda en pagar el prestamo")
disp("Dado f(n) = a*(1+r)^n - p*(((1+r)^n - 1)/r)")
disp("Raíz obtenida empezando en 100, usando método newton")
[val, numiter] = newton(100,"(100000*(1.06^x)) - 10000*(((1.06^x)-1)/0.06)",1D-7)
disp("Años para pagar: "+string(val))

disp("Para un prestamo de a = $100,000.00 y pagos anuales de p = $10,000.00 y que se pague en 20 años cual debe ser la taza de interes r")
disp("Dado g(r) = a*(1+r)^n - p*(((1+r)^n - 1)/r)")
disp("Raíz obtenida empezando en 100, usando método newton")
[val, numiter] = newton(100,"(100000*((1+x)^20)) - 10000*((((1+x)^20)-1)/x)",1D-7)
disp("Taza de interes: "+string(val))

disp("Para un prestamo de a = $100,000.00 que tan grandes deben ser los pagos anuales p para que el prestamo sea liquidado en n = 20 años con r = 0.06")
disp("Dado h(p) = a*(1+r)^n - x*(((1+r)^n - 1)/r)")
disp("Raíz obtenida empezando en 100, usando método newton")
[val, numiter] = newton(100,"(100000*((1.06)^20)) - x*((((1.06)^20)-1)/0.06)",1D-7)
disp("Pagos Anuales: "+string(val))

