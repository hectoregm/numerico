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


function [val,numiter] = secante(p0,p1,funcion,tol,iter)
// Funcion que realiza el metodo de la secante para el calculo de ceros de 
// funciones.
// Autor: Jorge Zavaleta
//*****************************************************************************
// ->Entrada
//  p0 (Real) - Numero real que denota el lado izq del intervalo de busqueda.
//
//  p1 (Real) - Numero real que denota el lado derecho del intervalo de busqueda.
//
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
numiter = 2;
cad1 = 'y=';
funcprot(0)
deff('[y]=f(x)',cad1 + funcion);

// Se calculan las valuaciones de las aproximaciones iniciales
q0 = f(p0);
q1 = f(p1);

// Se verifica si alguna de estas es la solucion
if q0 == 0 then
    val = p0;
    return
elseif q1 == 0
    val = p1;
    return
end

// Se mueven las aproximaciones iniciales en el caso que las valuaciones sean
// las mismas (en este caso la secante no corta al eje x)
while q0 == q1
    if p0 < p1 then
        p1 = p0 + (p1 - p0)/2
        q1 = f(p1);
    elseif p0 > p1
        p0 = p1 + (p0 - p1)/2
        q0 = f(p0);
    else
        val = p0;
        return
    end
end

// Comienza el metodo de la secante
while numiter < iter
    p = p1 - q1*(p1 - p0)/(q1 - q0);
    if abs(p - p1) < tol then
        val = p;
        return
    end
    q = f(p);
    p0 = p1;
    q0 = q1;
    p1 = p;
    q1 = q;
    numiter = numiter + 1;
end
val = p;
endfunction

function [val,numiter] = biseccion(a,b,funcion,tol,iter)
// Funcion que realiza el metodo de biseccion para el calculo de ceros de 
// funciones.
// Autor: Jorge Zavaleta
//*****************************************************************************
// ->Entrada
//  a (Real) - Numero real que denota el lado izq del intervalo de busqueda.
//
//  b (Real) - Numero real que denota el lado derecho del intervalo de busqueda.
//
//  funcion (String) - Es la funcion a la cual se le quiere encontrar un cero, 
//                     donde la variable dependiente siempre se denota por x.
//                     Ejemplo 'sin(x)' para calcular un cero de la funcion 
//                     seno(x).
//
//  tol (Real - Opcional) - Numero real que especifica la tolerancia para la 
//                         condicion de paro del metodo. Si no se especifica en 
//                         los parametros de entrada el valor por defecto es 
//                         1D-10.
//
//  iter (Real - Opcional) - Numero real que especifica el numero maximo de 
//                           iteraciones que realiza el metodo (Segunda 
//                           condicion de paro). Si no se especifica en los 
//                           parametros de entrada el valor por defecto es 100.
//
//->Salida
//  val (Real) - Numero real con el valor del cero encontrado (funcion(val)=0).
//
//  numiter (Real) - Numero real que da el numero de iteraciones que realizo el 
//                   metodo. numiter < iter si se alcanzo la tolerancia (tol) o 
//                   numiter = iter en caso contrario.
//*****************************************************************************

// Se verifica cuantos argumentos de entrada se tiene y se asignan valores por 
// defecto a los argumentos opcionales que no se hayan definido
rhs = argn(2); // Da el numero de argumentos de entrada
if rhs < 4 then // Solo se definio el intervalo de busqueda y la funcion
    tol = 1D-10;
    iter = 100;
elseif rhs < 5 then // Se definio adicionalmente la tolerancia
    iter = 100;
end

// Se define la funcion que se quiere evaluar y se inicializa el contador de 
// iteraciones
numiter = 0;
cad = 'y=';
funcprot(0)
deff('[y]=f(x)',cad + funcion);

//Comienza el metodo
while (b - a) > tol & numiter < iter
    numiter = numiter + 1;
    m = (b + a)/2;
    if f(m) == 0 then
        break;
    end
    if f(b)*f(m) <= 0 then
        a = m;
    else
        b = m;
    end
end
val = m;
endfunction

function [val,numiter] = reglafalsa(p0,p1,funcion,tol,iter)
// Funcion que realiza el metodo de la regla falsa para el calculo de ceros de 
// funciones.
// Autor: Jorge Zavaleta
//*****************************************************************************
// ->Entrada
//  p0 (Real) - Numero real que denota el lado izq del intervalo de busqueda.
//
//  p1 (Real) - Numero real que denota el lado derecho del intervalo de busqueda.
//
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
numiter = 2;
cad1 = 'y=';
funcprot(0)
deff('[y]=f(x)',cad1 + funcion);

// Se calculan las valuaciones de las aproximaciones iniciales
q0 = f(p0);
q1 = f(p1);

// Se verifica si alguna de estas es la solucion
if q0 == 0 then
    val = p0;
    return
elseif q1 == 0
    val = p1;
    return
end

// Se mueven las aproximaciones iniciales en el caso que las valuaciones sean
// las mismas (en este caso la secante no corta al eje x)
while q0 == q1
    if p0 < p1 then
        p1 = p0 + (p1 - p0)/2
        q1 = f(p1);
    elseif p0 > p1
        p0 = p1 + (p0 - p1)/2
        q0 = f(p0);
    else
        val = p0;
        return
    end
end

// Comienza el metodo de regla falsa
while numiter < iter
    p = p1 - q1*(p1 - p0)/(q1 - q0);
    if abs(p - p1) < tol then
        val = p;
        return
    end
    q = f(p);
    if q * q1 < 0 then
        p0 = p1;
        q0 = q1;
    end
    p1 = p;
    q1 = q;
    numiter = numiter + 1;
end
val = p;
endfunction


disp("Raíz obtenida intervalo [-1,0], usando método  biseccion")
[val, numiter] = biseccion(-1,0,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))
disp("Raíz obtenida intervalo [0,1], usando método biseccion")
[val, numiter] = biseccion(0,1,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))

disp("Raíz obtenida intervalo [-1,0], usando método secante")
[val, numiter] = secante(-1,0,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))
disp("Raíz obtenida intervalo [0,1], usando método secante")
[val, numiter] = secante(0.5,1,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))

disp("Raíz obtenida intervalo [-1,0], usando método  regla falsa")
[val, numiter] = reglafalsa(-1,0,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))
disp("Raíz obtenida intervalo [0,1], usando método regla falsa")
[val, numiter] = reglafalsa(0,1,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))

disp("Función: 230*x^4 + 18*x^3 + 9*x^2 - 221*x - 9")
disp("Raíz obtenida empezando en 0, usando método newton")
[val, numiter] = newton(0,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))
disp("Raíz obtenida empezando en 1, usando método newton")
[val, numiter] = newton(1,func,1D-7)
disp("Valor: "+string(val))
disp("Iteraciones: "+string(numiter))

disp("Como se puede ver el método de newton es muy bueno es el que menos iteraciones realiza para encontrar")
disp("El valor en que se hace cero la función ademas vemos que es super simple de implementar")
disp("Solo es necesario calcular la derivada de la función que se puede aproximar muy bien según la definición")
