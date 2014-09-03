// Autor: Jorge Zavaleta
// Script que realiza la suma sobre las componenetes de un vector. Para opc = 1 
// realiza la suma de todas las componentes, es decir, $\sum_{k = 0}^n x_{k}$.
// Para opc = 2 se realiza la suma de sus componenetes al cuadrado, esto es, 
// $\sum_{k = 0}^n x_{k}^{2}$. Para cualquier otro caso la funcion regresa %nan

// Variables que pueden ser cambiadas por el usuario
opc = 1 // Definimos la opcion
opcvec = 1 // Definimos la opcion del vector de prueba
n = 10 //Definimos el tama~no del vector

//Definimos el vector de prueba
if opcvec == 1 then
    vec = ones(1,n) 
else
    vec = [1:n];
end

// Hacemos la suma correspondiente a la opcion seleccionada
select opc
case 1
    suma = sum(vec);
case 2
    suma = sum(vec.^2);
else
    suma = %nan
end

//Desplegamos el resultado en consola
disp('El valor de la suma es')
disp(suma)
