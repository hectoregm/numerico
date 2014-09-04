function suma = Ejercicio1(opc,vec)
// Autores: Jorge Zavaleta, Hector E. Gomez Morales
// Funcion que realiza la suma sobre las componenetes de un vector.
// Para opc = 1 realiza la suma de todas las componentes, es decir,
//                  $\sum_{k = 0}^n x_{k}$
// Para opc = 2 se realiza la suma de sus componenetes al cuadrado, esto es,
//                  $\sum_{k = 0}^n x_{k}^{2}$
// Para cualquier otro caso la funcion regresa %nan
//************************************************************************
//-> Entrada
// opc (Real) - Opcion que se quiere realizar.
//
// vec (Vector Real) - Vector de tama~no n
//
//-> Salida
//  suma (Real) - Contiene el resultado de sumar todas las componentes del 
//                vector vec con alguna de la opciones dada en opc
//************************************************************************
select opc
case 1
    suma = sum(vec);
case 2
    suma = sum(vec.^2);
else
    suma = %nan
end
endfunction

vec = [1,2,3,4,5]
disp('Tenemos el vector:')
disp(vec)
disp('Usando la funcion suma con opcion 1 obtenemos:')
disp(Ejercicio1(1,vec))

