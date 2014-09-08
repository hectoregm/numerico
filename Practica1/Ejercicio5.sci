// Dado que tenemos que tanto e^x - 1 y x tienden a cero cuando x tiende a cero podemos aplicar L'Hopital con lo que obtenemos lim x->0 e^x / 1 = lim x->0 e^x asi obtenemos que el limite de la expresion original es igual a 1.

// Los resultados concuerdan con la teoria tanto Funcion como FuncionR se ve que los valores
// de f(x) conforme x se va haciendo mas pequeño tienden a 1

// La funcion funcionR presenta una mejor, la razon que funcione mejor seria
// por errores de redondeo al ejecutar dos funciones log y exp al denominador.
// Dado que estamos manejando decimales al realizar las dos funciones.

function Funcion
// Autores: Jorge Zavaleta,Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//     f(x) = (e^x - 1) / x
//
// para un conjunto de argumentos dados x
//************************************************************************
//-> Salida
// La grafica de funcion
//************************************************************************
xdel(winsid())

k = 16;
t = linspace(1,k,k);
t = t(:)
x = t;
y = t;

for i = 1 : k
  x(i) = 10^(-t(i))
  disp(x(i))
  y(i) = (exp(x(i)) - 1) / x(i)
end

disp(x)
disp(y)
    
//Graficamos la funcion
plot2d(x,y,2)

// Damos formato a la grafica
// Creamos las etiquetas y titulo
str = "$f(x) = (e^x - 1) / x$"
xtitle(str);
endfunction

function FuncionR
// Autores: Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//     f(x) = (e^x - 1) / log(e^x)
//
// para un conjunto de argumentos dados x
//************************************************************************
//-> Salida
// La grafica de funcion
//************************************************************************
xdel(winsid())

k = 15;
t = linspace(1,k,k);
t = t(:)
disp(t)
x = t;
y = t;

for i = 1 : k
  x(i) = 10^(-t(i));
  disp(x(i))
  y(i) = (exp(x(i)) - 1) / log(exp(x(i)));
end

disp(x)
disp(y)
    
//Graficamos la funcion
plot2d(x,y,2)

// Damos formato a la grafica
// Creamos las etiquetas y titulo
str = "$f(x) = (e^x - 1) / x$"
xtitle(str);
endfunction

FuncionR()