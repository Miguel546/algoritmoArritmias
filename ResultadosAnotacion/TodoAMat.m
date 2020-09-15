resultados1 = xlsread('Todo.xlsx', 'Hoja1');
[~, resultados] = xlsread('Todo.xlsx', 'Hoja1');

for i=1:length(resultados)
resultadosTodo{i,1} = resultados(i,1);
resultadosTodo{i,2} = resultados1(i,1);
resultadosTodo{i,3} = resultados1(i,2);
resultadosTodo{i,4} = resultados1(i,3);
resultadosTodo{i,5} = resultados1(i,4);
resultadosTodo{i,6} = resultados1(i,5);
resultadosTodo{i,7} = resultados1(i,6);
resultadosTodo{i,8} = resultados(i,8);
end
