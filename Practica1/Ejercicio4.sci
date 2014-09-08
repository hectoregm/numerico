function Funcion1(x, y)
// Autores: Hector E. Gomez Morales
// Funcion que grafica la funcion 
//
//     f1(x) = 4*x^2 + y^2
//
// para un conjunto de argumentos dados x, y
//************************************************************************
//-> Entrada
// x (Vector Real) - Define los puntos donde se evaluara y graficara la funcion
// y (Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f1
//************************************************************************
xdel(winsid())

//Creamos la particion en el dominio en 2D
[X,Y] = meshgrid(x,y);

//Definimos la funcion que queremos graficar
Z = 4*(X.^2) + Y.^2;

//Graficamos utilizando mesh
mesh(X,Y,Z)
xlabel('$x$','fontsize',3.5)
ylabel('$y$','fontsize',3.5)
zlabel('$z$','fontsize',3.5)
title('$f(x,y) = 4x^2 + y^2$','fontsize',4)

// Abrimos una nueva ventana
figure()
//Graficamos utilizando surf
surf(X,Y,Z)
xlabel('$x$','fontsize',3.5)
ylabel('$y$','fontsize',3.5)
zlabel('$z$','fontsize',3.5)
title('$f(x,y) = 4x^2 + y^2$','fontsize',4)

//Cambiamos el mapa de colores de la grafica
f = gcf()
f.color_map = jetcolormap(32)
f.background = -2 //Color de fondo
endfunction

function Funcion2(x, y)
// Autores: Hector E. Gomez Morales
// Funcion que grafica la funcion 
//
//     f2(x) = (x^2 + 3y^2)e^(-x^2-y^2)
//
// para un conjunto de argumentos dados x, y
//************************************************************************
//-> Entrada
// x (Vector Real) - Define los puntos donde se evaluara y graficara la funcion
// y (Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f2
//************************************************************************
xdel(winsid())

//Creamos la particion en el dominio en 2D
[X,Y] = meshgrid(x,y);

//Definimos la funcion que queremos graficar
Z = (X.^2 + 3*(Y.^2)) * %e^-(X.^2 + Y.^2);

//Graficamos utilizando mesh
mesh(X,Y,Z)
xlabel('$x$','fontsize',3.5)
ylabel('$y$','fontsize',3.5)
zlabel('$z$','fontsize',3.5)
title('$f(x,y) = (x^2 + 3y^2)e^(-x^2-y^2)$','fontsize',4)

// Abrimos una nueva ventana
figure()
//Graficamos utilizando surf
surf(X,Y,Z)
xlabel('$x$','fontsize',3.5)
ylabel('$y$','fontsize',3.5)
zlabel('$z$','fontsize',3.5)
title('$f(x,y) = (x^2 + 3y^2)e^(-x^2-y^2)$','fontsize',4)

//Cambiamos el mapa de colores de la grafica
f = gcf()
f.color_map = jetcolormap(32)
f.background = -2 //Color de fondo
endfunction

function Funcion3(x, y)
// Autores: Hector E. Gomez Morales
// Funcion que grafica la funcion 
//
//     f3(x) = sin(x) + cos(y)
//
// para un conjunto de argumentos dados x, y
//************************************************************************
//-> Entrada
// x (Vector Real) - Define los puntos donde se evaluara y graficara la funcion
// y (Vector Real) - Define los puntos donde se evaluara y graficara la funcion
//
//-> Salida
// La grafica de f2
//************************************************************************
xdel(winsid())

//Creamos la particion en el dominio en 2D
[X,Y] = meshgrid(x,y);

//Definimos la funcion que queremos graficar
Z = sin(X) + cos(Y);

//Graficamos utilizando mesh
mesh(X,Y,Z)
xlabel('$x$','fontsize',3.5)
ylabel('$y$','fontsize',3.5)
zlabel('$z$','fontsize',3.5)
title('$f(x,y) = sin(x) + cos(y)$','fontsize',4)

// Abrimos una nueva ventana
figure()
//Graficamos utilizando surf
surf(X,Y,Z)
xlabel('$x$','fontsize',3.5)
ylabel('$y$','fontsize',3.5)
zlabel('$z$','fontsize',3.5)
title('$f(x,y) = sin(x) + cos(y)$','fontsize',4)

//Cambiamos el mapa de colores de la grafica
f = gcf()
f.color_map = jetcolormap(32)
f.background = -2 //Color de fondo
endfunction

// Script para utilizar la funciones 1, 2, 3 y 4
// Interfaz en consola
opc = 'n'
while opc ~= 's'
clc
opc = input('Indique que funcion (1..3) quiere graficar: ')
    while opc ~= 1 & opc ~= 2 & opc ~= 3
      disp('')
      disp('Opcion desconocida. Responda solamente 1, 2 o 3')
      opc = input('Indique que funcion (1..3) quiere graficar: ');
    end 

    disp('Evaluacion de la funcion')
    disp('')

    xliminf = input('Indique el valor inferior del intervalo de graficacion para x: ')
    disp('')
    xlimsup = input('Indique el valor superior del intervalo de graficacion para x: ')
    disp('')
    xnp = input('Indique el numero de puntos en el intervalo de graficacion para x: ')
    disp('')

    yliminf = input('Indique el valor inferior del intervalo de graficacion para y: ')
    disp('')
    ylimsup = input('Indique el valor superior del intervalo de graficacion para y: ')
    disp('')
    ynp = input('Indique el numero de puntos en el intervalo de graficacion para y: ')
    disp('')    
    
    x = linspace(xliminf,xlimsup,xnp)
    y = linspace(yliminf,ylimsup,ynp)
    
    select opc
    case 1
        Funcion1(x,y)
    case 2
        Funcion2(x,y)
    case 3
        Funcion3(x,y)
    end
    disp('La funcion se evaluo correctamente')
    disp('')
    opc = input('¿Quieres salir? (s/n) ','s');

    if opc == 's' then
        disp('El script se ejecuto satisfactoriamente')
    end
end