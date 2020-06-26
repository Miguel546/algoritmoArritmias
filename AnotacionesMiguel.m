for i=1:height(anotaciones)
    for y=1:width(anotaciones)
        if(y==11)
            picos(i, 1) = anotaciones(i, y);
        elseif(y==12)
            picos(i, 2) = anotaciones(i, y);
        elseif(y==13)
            picos(i, 3) = anotaciones(i, y);
        elseif(y==14)
            picos(i, 4) = anotaciones(i, y);
        end
    end
end
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl);
querieAnotacion1 = ["SELECT * FROM mitarrythmiadatabase.anotaciones207m;"];
assignin('base','querieAnotacion1', strjoin(querieAnotacion1, ''));
anotaciones2 = select(conexionBD, strjoin(querieAnotacion1, ''));
%z = 1;
d = 1;
for z=1:height(picos)
    %mayor = table2array(picos(z,2)) - 1;
    for y=table2array(picos(z,1)): table2array(picos(z,2))
        disp(y);
        arregloAnalizar{d, 1} = table2array(anotaciones2(y, 2));
        arregloAnalizar{d, 2} = anotaciones{z, 2};
        d = d + 1;
    end
end

for z=1:size(arregloAnalizar,1)
    
end