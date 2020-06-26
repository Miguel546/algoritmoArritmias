clear;
clc;
close all;

dbname = 'mitarrythmiadatabase'; 
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
minis = table();
conn = database(dbname, username, password, driver, dburl);

%registros = select(conn, "SELECT registro FROM mitarrythmiadatabase.picosr group by registro");
registros = select(conn, "SELECT registro FROM mitarrythmiadatabase.ondasp group by registro");
for i=1: height(registros)
%querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.picosr where registro = '" registros{i, 1} "';"];
querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.ondasp where registro = '" registros{i, 1} "';"];
anotacion = select(conn, strjoin(querieAnotacion, ''));

    for j=1 : height(anotacion)
        if(table2array(anotacion(j,11)) == min(table2array(anotacion(:,11))))
            %registrosmin(i)= table2cell(anotacion(i,:));
            %addrow(registrosmin, anotacion(i,:));
            minis= [minis; anotacion(j,:)];
        end
    end
end

[a, b] = unique(minis(:, 1:11), 'rows');

minis = minis(b,:);
%filename = 'picosr.xlsx';
filename = 'ondasp.xlsx';
if isfile(filename)
     % File exists.
     delete(filename);
     xlswrite(filename, minis.Properties.VariableNames, 'Hoja1', 'A1');
     xlswrite(filename, table2cell(minis), 'Hoja1', 'A2');
else
     % File does not exist.
     xlswrite(filename, minis.Properties.VariableNames, 'Hoja1', 'A1');
     xlswrite(filename, table2cell(minis), 'Hoja1', 'A2');
end