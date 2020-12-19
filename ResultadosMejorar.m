registromit = '232m';
load(strcat('ResultadosRRMediaPicos/SinAnotaciones/', 'Resultados',registromit));
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
[conexionBD] = conexion(dbname, username, password, driver, dburl);
anotaciones = select(conexionBD, strjoin(querieAnotacion, ''));

for i=1:length(Resultados)
    Results{i,1} = registromit;
    Results{i,2} = Resultados(i,1);
    Results{i,3} = Resultados(i,2);
    Results{i,4} = Resultados(i,3);
    Results{i,5} = Resultados(i,4);
    Results{i,6} = Resultados(i,5);
    Results{i,7} = Resultados(i,6);
    for j=1:height(anotaciones)
        if(Resultados(i,1) > anotaciones{j,7} && Resultados(i,1) < anotaciones{j,8})
            if(isequal(anotaciones{j,2}, {'(N'}))
                Results{i,8} = {'(N'};
            elseif(isequal(anotaciones{j,2}, {'(AFIB'}))
                Results{i,8} = {'(AFIB'};  
            elseif(isequal(anotaciones{j,2}, {'(VFL'}))
                Results{i,8} = {'(VFL'};
            elseif(isequal(anotaciones{j,2}, {'(VT'}))
                Results{i,8} = {'(VT'};
            elseif(isequal(anotaciones{j,2}, {'(SBR'}))
                Results{i,8} = {'(SBR'};
            elseif(isequal(anotaciones{j,2}, {'(AFL'}))
                Results{i,8} = {'(AFL'};
            else
                Results{i,8} = {'(OARR'};
            end
        end
    end
end

Resultados232m = Results;
save(strcat('Resultados',registromit), 'Resultados232m')