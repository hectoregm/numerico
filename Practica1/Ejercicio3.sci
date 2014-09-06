function Funcion1(x)
// Autores: Jorge Zavaleta,Hector E. Gomez Morales
// Funcion que grafica la funcion definida en intervalos
//
//            | cos(2x)     si 0 <= x <= Pi/4
//     f1(x) = |
//            | 0           si Pi/4 < x <= Pi/2
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

// Script para utilizar la función EjemploE3
// Interfaz en consola
opc = 's'
while opc ~= 'n'
    clc
    disp('Evaluacion de la funcion Funcion1')
    disp('')
    liminf = input('Indique el valor inferior del intervalo de graficacion: ')
    disp('')
    limsup = input('Indique el valor superior del intervalo de graficacion: ')
    disp('')
    np = input('Indique el numero de puntos en el intervalo de graficacion: ')
    disp('')
    x = linspace(liminf,limsup,np)
    Funcion1(x)
    disp('La funcion se evaluo correctamente')
    disp('')
    // Solo es necesario poner s o n (sin '')
    opc = input('¿Quieres evaluar nuevamente la funcion? (s/n) ','s');
    while opc~='s' & opc ~='n'
        disp('')
        disp('Opcion desconocida. Responda solamente s o n')
        opc = input('¿Quieres evaluar nuevamente la funcion? (s/n) ','s');
    end
    if opc == 'n' then
        disp('El script se ejecuto satisfactoriamente')
    end
end
