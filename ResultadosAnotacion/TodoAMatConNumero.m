resultados1 = xlsread('Todo.xlsx', 'Hoja1');
[~, resultados] = xlsread('Todo.xlsx', 'Hoja1');
%resultadosTodoConNumero = {'numero', 'registro', 'muestra', 'PRms', 'QRSms', 'Ritmo Cardiaco', 'Onda P', 'Ritmo Regular'};

for i=1:length(resultados)
    resultadosTodoConNumero{i,1} = i;
    resultadosTodoConNumero{i,2} = resultados1(i,1);
resultadosTodoConNumero{i,3} = resultados(i,1);
resultadosTodoConNumero{i,4} = resultados1(i,3);
resultadosTodoConNumero{i,5} = resultados1(i,4);
resultadosTodoConNumero{i,6} = resultados1(i,5);
resultadosTodoConNumero{i,7} = resultados1(i,6);
resultadosTodoConNumero{i,8} = resultados1(i,7);
resultadosTodoConNumero{i,9} = resultados1(i,8);
resultadosTodoConNumero{i,10} = resultados(i,8);
end
