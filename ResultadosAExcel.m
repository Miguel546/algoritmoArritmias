A = {'Indice Total'	'Indice Registro'	'Registro'	'Muestra' 'PRms' 'QRSms' 'Ritmo cardiaco'	'OndaP'	'Ritmo Regular'	'Anotacion'};
xlswrite('Resultados.xlsx',A, 'Hoja1');
xlswrite('Resultados.xlsx', Resultados, 'Hoja1', 'A2');