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
fs = 360;
registromit='100m';
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoR(conexionBD, registromit, 22, fs, 0);
%Filtro pasa alta
[BWb,BWa] = butter(5,[1.0].*2/fs,'high');
%Aplicas
data = filtfilt(BWb,BWa,ecg);
%Filtro rechaza banda
[b1,a1]=fir1(100,[59 61]*2/fs,'stop');
%Aplicar a la senal anterior
ecgd=filtfilt(b1,a1,data);
%filtro pasabanda
[b2,a2]=fir1(10,[5 10]*2/fs);
%Graficar la figura 3
ecgs=filtfilt(b2,a2,ecgd);

ecgs=ecgs/max(abs(ecgs));
figure1 = figure;
hold on,plot(ecgs); title(strcat('Registro', 32,  registromit));
hold on,plot(S_index,ecgs(S_index),'r+');  %Grafica picos R sobre la curva ECG acondicionada
hold on,plot(Rindex,ecgs(Rindex),'go');
hold on, plot(Q_index, ecgs(Q_index),'r*');
legend('ECG','Punto S','Punto R','Punto Q');
datacursormode(figure1);