function [arregloAnalizar, picos]= picosArritmias(anotaciones, anotaciones2, abreviatura);
picos = [];
picosindex = 1;
for i=1:height(anotaciones)
    for y=1:width(anotaciones)
        if(isequal(char(anotaciones{i,2}),abreviatura))
            if(y==11)
                picos(picosindex, 1) = table2array(anotaciones(i, y));
                
            elseif(y==12)
                picos(picosindex, 2) = table2array(anotaciones(i, y));
            elseif(y==13)
                picos(picosindex, 3) = table2array(anotaciones(i, y));
            elseif(y==14)
                picos(picosindex, 4) = table2array(anotaciones(i, y));
                picosindex = picosindex + 1;
            end
            
        end
    end
    
end

d = 1;
if(isempty(picos))
    arregloAnalizar = [];
else
    for z=1:size(picos,1)  
    for y=picos(z,1):picos(z,2)  
      arregloAnalizar{d, 1} = table2array(anotaciones2(y, 2));
      arregloAnalizar{d, 2} = anotaciones{z, 2};
      d = d + 1;
    end
end
end
