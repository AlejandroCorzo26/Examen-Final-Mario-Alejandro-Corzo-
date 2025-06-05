%% Mario Alejandro Corzo 
%% Ingenieria en Sistemas

%% Definición de la función a integrar
mi_funcion = @(x) 10*x - 50*x.^2 + 100*x.^3 - 50*x.^4 + 5*x.^5;

%% Intervalo de integración
x_inicial = 0;
x_final = 1;

%% Número de subintervalos
num_intervalos = 4;
paso = (x_final - x_inicial)/num_intervalos;

%% Vector de nodos y evaluación de la función
xi = x_inicial:paso:x_final;
yi = mi_funcion(xi);

%% Cálculo de la integral con la regla de Simpson 1/3
aprox_integral = (paso/3) * (yi(1) + 4*sum(yi(2:2:end-1)) + 2*sum(yi(3:2:end-2)) + yi(end));

%% Valor exacto de la integral (dado)
valor_exacto = 3.0;

%% Cálculo simbólico de la cuarta derivada para estimar el error de truncamiento
syms X
funcion_simbolica = 10*X - 50*X^2 + 100*X^3 - 50*X^4 + 5*X^5;
cuarta_derivada = diff(funcion_simbolica, 4);

%% Valor medio de la cuarta derivada en el intervalo [x_inicial, x_final]
media_cuarta_derivada = double((subs(cuarta_derivada, x_inicial) + subs(cuarta_derivada, x_final))/2);

%% Estimación del error de truncamiento
error_truncamiento = -(paso^4)*(x_final - x_inicial)/(180) * media_cuarta_derivada;

%% Cálculo del error relativo porcentual
error_relativo = abs((valor_exacto - aprox_integral)/valor_exacto) * 100;

%% Mostrar resultados
fprintf('Resultado de la integral aproximada: %.6f\n', aprox_integral);
fprintf('Valor exacto: %.6f\n', valor_exacto);
fprintf('Error relativo porcentual: %.2f%%\n', error_relativo);
fprintf('Error de truncamiento estimado: %.6f\n', error_truncamiento);