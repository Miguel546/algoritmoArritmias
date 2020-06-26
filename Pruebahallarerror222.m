global dbname;
global username;
global password;
global driver;
global dburl;
global conexionBD;
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl); 

seleccionarRegistro=42;
registromit = '222m';
disp(registromit);

querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
assignin('base','querieAnotacion', strjoin(querieAnotacion, ''));
anotaciones = select(conexionBD, strjoin(querieAnotacion, ''));
%assignin('base','anotaciones', anotaciones);
columnasArritmias = ["ranterior" "ractual" "segundoanterior" "restoanterior" "segundoactual" "restoactual" "tiemporr" "minutoanterior" "segundoanterior" "minutoactual" "segundoactual" "PRms" "QRSms" "Ritmo cardiaco" "f<0.5Hz" "f>1Hz" "1Hz<f<3Hz" "Ritmo regular"];
anotacionArritmia = [anotaciones(:,1) anotaciones(:,2) anotaciones(:,3) anotaciones(:,4) anotaciones(:,7) anotaciones(:,8) anotaciones(:,9) anotaciones(:,10) anotaciones(:,13) anotaciones(:,14)];

fs = 360;
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoR(conexionBD, registromit, seleccionarRegistro, fs, 0);
[ecgs2, Rindex2, Tindex, Pindex, anotacionesP] = detectarOndasPT(conexionBD, registromit, seleccionarRegistro, ecgnormal, fs, Rindex, Q_index, S_index, K_index,0);
[ritmoregular, bradicardiamatriz, taquicardiamatriz, NSyR, SyBr, SyTa, SyAr, AtFl, AtFib, VTa, VFib, B1Gr]= detectarArritmias(conexionBD, registromit, seleccionarRegistro, ecgs2, fs, Rindex2, Pindex, S_index, Q_index, Tindex, K_index);