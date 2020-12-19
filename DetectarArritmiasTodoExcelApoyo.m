registrosmit = {'100m' '101m' '102m' '103m' '104m' '105m' '106m' '107m' '108m' '109m' '111m' '112m' '113m' '114m' '115m' '116m' '117m' '118m' '119m' '121m' '122m' '123m' '124m' '200m' '201m' '202m' '203m' '205m' '207m' '208m' '209m' '210m' '212m' '213m' '214m' '215m' '217m' '219m' '220m' '221m' '222m' '223m' '228m' '230m' '231m' '232m' '233m' '234m'};
filename = 'DeteccionArritmiasTotal.xlsx';
A = {'Registro' 'Arritmia' 'Sensibilidad' 'Predictividad' 'VP' 'FP' 'FN' 'Detección fallida(latidos)' 'Detección fallida(%)'};
xlswrite(filename,A);
data=xlsread('DeteccionArritmiasTotal.xlsx','Hoja1', 'A:A');  % read the column of interest
row=length(data)+1;
disp(row);
col_header={'Temperature','Pressure','X','Y'}; 
mapper = @(x,y) strcat(char(64 + x),num2str(y));
xlswrite(filename,col_header, 'Hoja1', mapper(1,(row +1)));
data=xlsread('DeteccionArritmiasTotal.xlsx','Hoja1', 'A:A');  % read the column of interest
row=length(data)+1;
disp(row);
xlswrite(filename,col_header, 'Hoja1', mapper(1,(row +1)));