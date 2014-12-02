// Dado que tenemos que tanto e^x - 1 y x tienden a cero cuando x tiende a cero podemos aplicar L'Hopital con lo que obtenemos lim x->0 e^x / 1 = lim x->0 e^x asi obtenemos que el limite de la expresion original es igual a 1.

// Los resultados concuerdan con la teoria tanto Funcion como FuncionR se ve que los valores
// de f(x) conforme x se va haciendo mas pequeño tienden a 1

// La funcion funcionR presenta una mejor, la razon que funcione mejor seria
// por errores de redondeo al ejecutar dos funciones log y exp al denominador.
// Dado que estamos manejando decimales al realizar las dos funciones.

function fp = derivada(funcion, x0, h)
// Autores: Hector E. Gomez Morales
// Funcion que calcula la derivada usando la formula de diferencias finitas
//
//     f'(x0) = (f(x0 + h) - f(x0)) / h
//
// con f siendo la funcion dada como cadenas, x0 un valor real y h
// la diferencia que se quiere.
//
//************************************************************************
//-> Salida
// El valor aproximado de la derivada de la funcion f en el punto x0
//************************************************************************

cad1 = 'y=';
funcprot(0)
deff('[y]=f(x)',cad1 + funcion);

fp = (f(x0 + h) - f(x0)) / h

endfunction

function fp = derivadacentrada(funcion, x0, h)
// Autores: Hector E. Gomez Morales
// Funcion que calcula la derivada usando la formula de diferencias centradas
//
//     f'(x0) = (f(x0 + h) - f(x0 - h)) / 2h
//
// con f siendo la funcion dada como cadenas, x0 un valor real y h
// la diferencia que se quiere.
//
//************************************************************************
//-> Salida
// El valor aproximado de la derivada de la funcion f en el punto x0
//************************************************************************

cad1 = 'y=';
funcprot(0)
deff('[y]=f(x)',cad1 + funcion);

fp = (f(x0 + h) - f(x0 - h)) / (2*h)

endfunction

function derivadaplot(n)
// Autores: Hector E. Gomez Morales
// Funcion que usa la funcion derivada para graficar la magnitud del error como funcion de h

h = 0.5
v = ones(1,n)
e = ones(1,n)

for i=1:n
  v(i) = h
  d = derivada("sin(x)", 1, h)
  e(i) = abs(cos(1) - d)
  h = h / 2
end

plot2d("ll",v,e)
xlabel("Valor h")
ylabel("Error en comparación a cos(1)")
endfunction

function derivadacentradaplot(n)
// Autores: Hector E. Gomez Morales
// Funcion que usa la funcion derivada centrada para graficar la magnitud del error como funcion de h

h = 0.5
v = ones(1,n)
e = ones(1,n)

for i=1:n
  v(i) = h
  d = derivadacentrada("sin(x)", 1, h)
  e(i) = abs(cos(1) - d)
  h = h / 2
end

plot2d("ll",v,e)
xlabel("Valor h")
ylabel("Error en comparación a cos(1)")
endfunction

scf(0)
derivadaplot(40)
disp("Derivada por diferencias finitas:")
disp("Vemos que si existe un mínimo para el error este se encuentra para una h en el rango de 1D-8 como se muestra en la gráfica")
disp("El valor de la regla general es decir h = sqrt(%eps)*1 es igual a 1.490D-08 que esta en la vecindad del mínimo que se tiene en la gráfica.")

scf(1)
derivadacentradaplot(40)
disp("Derivada por diferencias centradas:")
disp("Vemos que igual existe mínimo para el error pero se llega a este de forma mas rápida que con las diferencias finitas")