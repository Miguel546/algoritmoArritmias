filename = '5segundos.xlsx';

promedio = xlsread(filename, '100m');
sensibilidad = 0;
predictividad = 0;
vp = 0;
fp = 0;
fn = 0;
for i=1:length(promedio)
    vp = vp + promedio(i,7);
    fp = fp + promedio(i,8);
    fn = fn + promedio(i,9);
    sensibilidad = sensibilidad + promedio(i,10);
    predictividad = predictividad + promedio(i,11);
    
end
sensibilidad = sensibilidad/length(promedio);
predictividad = predictividad/length(promedio);
disp(vp);
disp(fp);
disp(fn);
resultadosRegistro = [vp fp fn sensibilidad predictividad];
cuadroRegistro = {'Registro' 'VP' 'FP' 'FN'	'Sensibilidad' 'Predictividad'};
cuadromando = 'Cuadro de mando 5 segundos';
xlswrite(filename,cuadroRegistro, cuadromando);

[~, resultados] = xlsread('5segundos.xlsx','Cuadro de mando 5 segundos');
concatenar = strcat('A',num2str(size(resultados,1) +1));
xlswrite(filename,resultadosRegistro, cuadromando, concatenar);
disp(sensibilidad);
disp(predictividad);