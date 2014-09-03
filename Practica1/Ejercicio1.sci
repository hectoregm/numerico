function suma = Ejercicio1(opc,vec)
// Autor: Jorge Zavaleta
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

// Script que realiza una interfaz en consola para probar la funcion
opc = 0 // Damos un valor para entrar al menu recursivo
while opc ~= 3
    clc //Limpiamos la consola
    disp('Funcion que suma las componentes de un vector')
    disp('')
    disp('Opciones que se encuentra dentro de la funcion')
    disp('1.- Suma de todas las componentes')
    disp('2.- Suma de todas las componentes al cuadrado')
    disp('3.- Salir')
    disp('')
    opc = input('Elije una opcion: ')
    disp('')
    if opc == 1 | opc == 2 then
        disp('Opciones de vectores de prueba')
        disp('1.- Vector con todas las entradas igual a 1')
        disp('2.- Vector de enteros [1,...,n]')
        disp('3.- Dar un vector')
        disp('')
        vopc = input('Elije una opcion: ')
        disp('')
        if vopc == 1 then
            vec = input('Defina el tama~no del vector: ')
            vec = ones(1,vec);
        elseif vopc == 2
            vec = input('Defina el valor de n: ')
            vec = [1 : vec];
        elseif vopc == 3
            vec = input('De un vector valido: ')
        else
            disp('Opcion no valida. Presione una tecla para continuar')
            input('')
            continue
        end
        s = Ejercicio1(opc,vec)
        disp('El valor de la suma es:')
        disp(s)
        disp('')
        disp('Presione una tecla para continuar')
        input('')
    elseif opc ~= 3
        disp('Opcion no valida. Presione una tecla para continuar')
        input('')
    end
end
