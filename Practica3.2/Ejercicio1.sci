A = [0.16 0.10; 0.17 0.11; 2.02 1.29]
b = [0.26; 0.28; 3.31]
b2 = [0.27; 0.25; 3.33]

s = A\b
s2 = A\b2

disp("Tenemos la matriz A")
disp(A)
disp("Con b del sistema Ax = b:")
disp(b)
disp("La solucion del sistema es:")
disp(s)

disp("Ahora si cambiamos b por:")
disp(b2)
disp("La solucion del sistema es:")
disp(s2)

disp("Esta gran diferencia dada la ligera perturbacion es por la muy mala condicion de la matriz A y todavia peor de la matriz cuadrada inducida de A")
disp("Condicion de A:")
disp(cond(A))
disp("Condicion de AtA:")
disp(cond(A'*A))
