load('ResultadosTotal.mat');
filename = 'ResultadosTotal.xlsx';
%xlswrite(filename,A);
mapper = @(x,y) strcat(char(64 + x),num2str(y));
concatenar = [];

 for k=1:size(ResultadosTotal,1)
           concatenar{k,1} = ResultadosTotal{k,1};
           
            concatenar{k,2} = ResultadosTotal{k,2};
       
            concatenar{k,3} = ResultadosTotal{k,3};
      
            concatenar{k,4} = ResultadosTotal{k,4};
    
            concatenar{k,5} = ResultadosTotal{k,5};
       
            concatenar{k,6} = ResultadosTotal{k,6};
       
            concatenar{k,7} = ResultadosTotal{k,7};
     
            concatenar{k,8} = string(ResultadosTotal{k,8});
   
            concatenar{k,9} = ResultadosTotal{k,9};
       
            concatenar{k,10} = string(ResultadosTotal{k,10});
     
    %if(k == 1)
        
    %else
    %    data=xlsread('ResultadosTotal.xlsx','Hoja1', 'C:C');  % read the column of interest
    %row=length(data)+1;
    %xlswrite(filename,concatenar, 'Hoja1', mapper(1,(row+1)));
    %end
    
 end
 xlswrite(filename,concatenar, 'Hoja1', mapper(1,1));