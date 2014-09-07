function Funcion1(x)
// Autores: Jorge Zavaleta,Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//             | cos(2x)     si 0 <= x <= Pi/4
//     f1(x) = |
//             | 0           si Pi/4 < x <= Pi/2
//
// para un conjunto de argumentos dados x
//************************************************************************
//-> Entrada
// x ( Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f1
//************************************************************************
xdel(winsid())

x = x(:);
s = length(x)
x1 = x; //Definimos el espacio para los puntos mayores o iguales 0 y menores o iguales a Pi/4
x2 = x; //Definimos el espacio para los puntos mayores a Pi/4 y menores o iguales a Pi/2
y1 = x; //Definimos el espacio para la evaluacion para cos(2x)
y2 = x; //Definimos el espacio para la constante 0
c1 = 0; //Contador de puntos en x1
c2 = 0; //Contador de puntos en x2

// Utilizamos la definicion para separar los puntos
for i = 1 : s
  if x(i) <= %pi/4  & x(i) >= 0 then
    c1 = c1 + 1;
    x1(c1) = x(i);
    y1(c1) = cos(2*x(i));
  elseif x(i) <= %pi/2  & x(i) > %pi/4
    c2 = c2 + 1;
    x2(c2) = x(i);
    y2(c2) = 0;
  end
end

// Eliminamos los espacios sobrantes con las siguienetes lineas
x2(c2+1:s) = [];
x1(c1+1:s) = [];
y2(c2+1:s) = [];
y1(c1+1:s) = [];
    
//Graficamos la funcion
if c1 == 0 & c1 == 0  then // No hay puntos del dominio
  plot2d(0,0,1,rect=[-1 -1 1 1])
  str = "$\mbox{Los argumentos no se encuentran en el dominio}[0,pi/2]$"
  xtitle(str);
  a = gca()
  a.title.font_size = 3
  a.x_location = "origin"
  a.y_location = "origin"
  a.isoview = "on"
  return
elseif c2 == 0 // Solo hay puntos en el intervalo [0,pi/4]
  plot2d(x1,y1,2)
elseif c1 == 0 // Solo hay puntos en el intervalo (pi/4,pi/2]
  plot2d(x2,y2,2)
else // Hay puntos para en los dos intervalos
  plot2d(x1,y1,2)
  plot2d(x2,y2,2)
end

// Damos formato a la grafica
// Creamos las etiquetas y titulo
str = "$ f1(x) = \left\{\begin{array}{rl}"+...
      " cos(2x)  & \mbox{ si } x \in [0,pi/4] \\"+...
      " & \\"+...
      " 0 & \mbox{ si } x \in (pi/4,pi/2] \end{array}\right.$"
xtitle(str);
//Obtenemos las propiedades de la figura y cambiamos algunos valores
a = gca() 
a.title.font_size = 3
a.x_label.font_size = 3;
a.y_label.font_size = 3;
a.isoview = "on"
endfunction

function Funcion2(x)
// Autores: Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//             |  10     si -2 <= x <= 0
//     f2(x) = |
//             | -10     si 0 < x <= 2
//
// para un conjunto de argumentos dados x
//************************************************************************
//-> Entrada
// x ( Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f2
//************************************************************************
xdel(winsid())

x = x(:);
s = length(x)
x1 = x; //Definimos el espacio para los puntos mayores o iguales -2 y menores o iguales a 0
x2 = x; //Definimos el espacio para los puntos mayores a 0 y menores o iguales a 2
y1 = x; //Definimos el espacio para la constante  10
y2 = x; //Definimos el espacio para la constante -10
c1 = 0; //Contador de puntos en x1
c2 = 0; //Contador de puntos en x2

// Utilizamos la definicion para separar los puntos
for i = 1 : s
  if x(i) <= 0  & x(i) >= -2 then
    c1 = c1 + 1;
    x1(c1) = x(i);
    y1(c1) = 10;
  elseif x(i) <= 2  & x(i) > 0
    c2 = c2 + 1;
    x2(c2) = x(i);
    y2(c2) = -10;
  end
end

// Eliminamos los espacios sobrantes con las siguienetes lineas
x2(c2+1:s) = [];
x1(c1+1:s) = [];
y2(c2+1:s) = [];
y1(c1+1:s) = [];
    
//Graficamos la funcion
if c1 == 0 & c1 == 0  then // No hay puntos del dominio
  plot2d(0,0,1,rect=[-1 -1 1 1])
  str = "$\mbox{Los argumentos no se encuentran en el dominio}[-2,2]$"
  xtitle(str);
  a = gca()
  a.title.font_size = 3
  a.x_location = "origin"
  a.y_location = "origin"
  a.isoview = "on"
  return
elseif c2 == 0 // Solo hay puntos en el intervalo [-2,0]
  plot2d(x1,y1,2)
elseif c1 == 0 // Solo hay puntos en el intervalo (0,2]
  plot2d(x2,y2,2)
else // Hay puntos para en los dos intervalos
  plot2d(x1,y1,2)
  plot2d(x2,y2,2)
end

// Damos formato a la grafica
// Creamos las etiquetas y titulo
str = "$ f2(x) = \left\{\begin{array}{rl}"+...
      " 10  & \mbox{ si } x \in [-2,0] \\"+...
      " & \\"+...
      " -10 & \mbox{ si } x \in (0,2] \end{array}\right.$"
xtitle(str);
//Obtenemos las propiedades de la figura y cambiamos algunos valores
a = gca() 
a.title.font_size = 3
a.x_label.font_size = 3;
a.y_label.font_size = 3;
a.isoview = "on"
endfunction

function Funcion3(x)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//             | 4*(x+1)     si -1 <= x <= 0
//     f3(x) = |
//             | 4*(x-1)     si 0 < x <= 1
//
// para un conjunto de argumentos dados x
//************************************************************************
//-> Entrada
// x ( Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f3
//************************************************************************
xdel(winsid())

x = x(:);
s = length(x)
x1 = x; //Definimos el espacio para los puntos mayores o iguales -1 y menores o iguales a 0
x2 = x; //Definimos el espacio para los puntos mayores a 0 y menores o iguales a 1
y1 = x; //Definimos el espacio para la evaluacion 4*(x+1)
y2 = x; //Definimos el espacio para la evaulacion 4*(x-1)
c1 = 0; //Contador de puntos en x1
c2 = 0; //Contador de puntos en x2

// Utilizamos la definicion para separar los puntos
for i = 1 : s
  if x(i) <= 0  & x(i) >= -1 then
    c1 = c1 + 1;
    x1(c1) = x(i);
    y1(c1) = 4*(x(i)+1);
  elseif x(i) <= 1  & x(i) > 0
    c2 = c2 + 1;
    x2(c2) = x(i);
    y2(c2) = 4*(x(i)-1);
  end
end

// Eliminamos los espacios sobrantes con las siguienetes lineas
x2(c2+1:s) = [];
x1(c1+1:s) = [];
y2(c2+1:s) = [];
y1(c1+1:s) = [];
    
//Graficamos la funcion
if c1 == 0 & c1 == 0  then // No hay puntos del dominio
  plot2d(0,0,1,rect=[-1 -1 1 1])
  str = "$\mbox{Los argumentos no se encuentran en el dominio}[-1,1]$"
  xtitle(str);
  a = gca()
  a.title.font_size = 3
  a.x_location = "origin"
  a.y_location = "origin"
  a.isoview = "on"
  return
elseif c2 == 0 // Solo hay puntos en el intervalo [-1,0]
  plot2d(x1,y1,2)
elseif c1 == 0 // Solo hay puntos en el intervalo (0,1]
  plot2d(x2,y2,2)
else // Hay puntos para en los dos intervalos
  plot2d(x1,y1,2)
  plot2d(x2,y2,2)
end

// Damos formato a la grafica
// Creamos las etiquetas y titulo
str = "$ f3(x) = \left\{\begin{array}{rl}"+...
      " 4*(x+1)  & \mbox{ si } x \in [-1,0] \\"+...
      " & \\"+...
      " 4*(x-1) & \mbox{ si } x \in (0,1] \end{array}\right.$"
xtitle(str);
//Obtenemos las propiedades de la figura y cambiamos algunos valores
a = gca() 
a.title.font_size = 3
a.x_label.font_size = 3;
a.y_label.font_size = 3;
a.isoview = "on"
endfunction

function Funcion4(x)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//             | ln(-x)     si -Infinito < x < -1
//     f4(x) = | x^2 - 1    si -1 <= x <= 1
//             | ln(x)      si  1 < x < Infinito
//
// para un conjunto de argumentos dados x
//************************************************************************
//-> Entrada
// x ( Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f3
//************************************************************************
xdel(winsid())

x = x(:);
s = length(x)
x1 = x; //Definimos el espacio para los puntos menores a -1
x2 = x; //Definimos el espacio para los puntos mayores o iguales a -1 y menores o iguales a 1
x3 = x; //Definimos el espacio para los puntos mayores a 1
y1 = x; //Definimos el espacio para la evaluacion ln(-x)
y2 = x; //Definimos el espacio para la evaluacion x^2-1
y3 = x; //Definimos el espacio para la evaluacion ln(x)
c1 = 0; //Contador de puntos en x1
c2 = 0; //Contador de puntos en x2
c3 = 0; //Contador de puntos en x3

// Utilizamos la definicion para separar los puntos
for i = 1 : s
  if x(i) < -1 then
    c1 = c1 + 1;
    x1(c1) = x(i);
    y1(c1) = log(-x(i));
  elseif x(i) <= 1  & x(i) >= -1
    c2 = c2 + 1;
    x2(c2) = x(i);
    y2(c2) = (x(i)^2)-1;
  else
    c3 = c3 + 1;
    x3(c3) = x(i);
    y3(c3) = log(x(i))
  end
end

// Eliminamos los espacios sobrantes con las siguienetes lineas
x3(c3+1:s) = [];
x2(c2+1:s) = [];
x1(c1+1:s) = [];
y3(c3+1:s) = [];
y2(c2+1:s) = [];
y1(c1+1:s) = [];

if c1 > 0
  plot2d(x1,y1,2)
end

if c2 > 0
  plot2d(x2,y2,2)
end

if c3 > 0
  plot2d(x3,y3,2)
end

// Damos formato a la grafica
// Creamos las etiquetas y titulo
str = "$ f4(x) = \left\{\begin{array}{rl}"+...
      " ln(-x)  & \mbox{ si } x \in [-\infty,-1] \\"+...
      " & \\"+...
      " ln(x) & \mbox{ si } x \in (1,\infty] \end{array}\right.$"
xtitle(str);
//Obtenemos las propiedades de la figura y cambiamos algunos valores
a = gca() 
a.title.font_size = 3
a.x_label.font_size = 3;
a.y_label.font_size = 3;
a.isoview = "on"
endfunction

// Script para utilizar la funciones 1, 2, 3 y 4
// Interfaz en consola
opc = 'n'
while opc ~= 's'
clc
opc = input('Indique que funcion (1..4) quiere graficar: ')
    while opc ~= 1 & opc ~= 2 & opc ~= 3 & opc ~= 4
      disp('')
      disp('Opcion desconocida. Responda solamente 1, 2, 3 o 4')
      opc = input('Indique que funcion (1..4) quiere graficar: ');
    end 

    disp('Evaluacion de la funcion')
    disp('')
    liminf = input('Indique el valor inferior del intervalo de graficacion: ')
    disp('')
    limsup = input('Indique el valor superior del intervalo de graficacion: ')
    disp('')
    np = input('Indique el numero de puntos en el intervalo de graficacion: ')
    disp('')
    x = linspace(liminf,limsup,np)
    select opc
    case 1
        Funcion1(x)
    case 2
        Funcion2(x)
    case 3
        Funcion3(x)
    case 4
        Funcion4(x)
    end
    disp('La funcion se evaluo correctamente')
    disp('')
    opc = input('¿Quieres salir? (s/n) ','s');

    if opc == 's' then
        disp('El script se ejecuto satisfactoriamente')
    end
end
