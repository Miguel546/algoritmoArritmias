load('AnotacionesTotal.mat');
filename = 'AnotacionesTotal.xlsx';
%xlswrite(filename,A);
mapper = @(x,y) strcat(char(64 + x),num2str(y));
concatenar = [];

 for k=1:size(AnotacionesTotal,1)
           concatenar{k, 1} = AnotacionesTotal{k,1};
            concatenar{k, 2} = string(AnotacionesTotal{k,2});
            concatenar{k, 3} = AnotacionesTotal{k,3};
 end
 xlswrite(filename,concatenar, 'Hoja1', mapper(1,1));