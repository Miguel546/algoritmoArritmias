clear;
clc;
close all;

global conexionBD;
global click;
global ecgs;
global ecgs2;
global Pindex;
global mayor;
global dbname;
global username;
global password;
global driver;
global dburl;
global ecg;
global PicoR;
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl); 
arritmiasAlgoritmo = [];
NSyRAlgoritmo = [];
SyBrAlgoritmo = [];
AtFlAlgoritmo = [];
AtFibAlgoritmo = [];
VTaAlgoritmo = [];
VFlAlgoritmo = [];
OARRAlgoritmo = [];

registrosmit = {'100m' '101m' '102m' '103m' '104m' '105m' '106m' '107m' '108m' '109m' '111m' '112m' '113m' '114m' '115m' '116m' '117m' '118m' '119m' '121m' '122m' '123m' '124m' '200m' '201m' '202m' '203m' '205m' '207m' '208m' '209m' '210m' '212m' '213m' '214m' '215m' '217m' '219m' '220m' '221m' '222m' '223m' '228m' '230m' '231m' '232m' '233m' '234m'};

pruebasTesis = [1800 3600 7200 18000 36000 72000 180000 360000];
pruebasRandom = [648200 646400 642800 632000 614000 578000 470000 290000];
cuadroMandoArreglo = {'Cuadro de mando 5 segundos' 'Cuadro de mando 10 segundos' 'Cuadro de mando 20 segundos' 'Cuadro de mando 50 segundos' 'Cuadro de mando 100 segundos' 'Cuadro de mando 200 segundos' 'Cuadro de mando 500 segundos' 'Cuadro de mando 1000 segundos'};
%filenameArreglo = {'5segundosRSinCondicional.xlsx' '10segundosRSinCondicional.xlsx' '20segundosRSinCondicional.xlsx' '50segundosRSinCondicional.xlsx' '100segundosRSinCondicional.xlsx' '200segundosRSinCondicional.xlsx' '500segundosRSinCondicional.xlsx' '1000segundosRSinCondicional.xlsx'};
filenameArreglo = {'5segundosR.xlsx' '10segundosR.xlsx' '20segundosR.xlsx' '50segundosR.xlsx' '100segundosR.xlsx' '200segundosR.xlsx' '500segundosR.xlsx' '1000segundosR.xlsx'};

for pruebas=1:length(pruebasTesis)
for registro=1:length(registrosmit)
picosRAlgoritmo = [];
resultadosRegistro = [];
for vueltas=1:100
anotacionAnalizar = [];
registromit = registrosmit{registro};
disp(registromit);
disp(vueltas);

querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
anotaciones = select(conexionBD,  strjoin(querieAnotacion, ''));

fs = 360;
random = randi([0,pruebasRandom(pruebas)]);
%random = 340254;
%random = 436135;
%random = 360833;
%random = 32186;
%arregloRandom(vueltas) = random;
arregloRandom(vueltas) = random;
muestras = pruebasTesis(pruebas);

if(registromit == '100m')
    numero = 2;
elseif(registromit == '101m')
    numero = 3;
elseif(registromit == '102m')
    numero = 4;
elseif(registromit == '103m')
    numero = 5;
elseif(registromit == '104m')
    numero = 6;
elseif(registromit == '105m')
    numero = 7;
elseif(registromit == '106m')
    numero = 8;
elseif(registromit == '107m')
    numero = 9;
elseif(registromit == '108m')
    numero = 10;
elseif(registromit == '109m')
    numero = 11;
elseif(registromit == '111m') 
    numero = 12;
elseif(registromit == '112m') 
    numero = 13;
elseif(registromit == '113m') 
    numero = 14;
elseif(registromit == '114m') 
    numero = 15;
elseif(registromit == '115m') 
    numero = 16;
elseif(registromit == '116m')
    numero = 17;
elseif(registromit == '117m')
    numero = 18;
elseif(registromit == '118m')
    numero = 19;
elseif(registromit == '119m')
    numero = 20;
elseif(registromit == '121m') 
    numero = 21;
elseif(registromit == '122m')
    numero = 22;
elseif(registromit == '123m')
    numero = 23;
elseif(registromit == '124m')
    numero = 24;
elseif(registromit == '200m')
    numero = 25;
elseif(registromit == '201m')
    numero = 26;
elseif(registromit == '202m')
    numero = 27;
elseif(registromit == '203m')
    numero = 28;
elseif(registromit == '205m')
    numero = 29;
elseif(registromit == '207m')
     numero = 30;
elseif(registromit == '208m')
    numero = 31;
elseif(registromit == '209m')
    numero = 32;
elseif(registromit == '210m')
    numero = 33;
elseif(registromit == '212m')
    numero = 34;
elseif(registromit == '213m')
    numero = 35;
elseif(registromit == '214m')
    numero = 36;
elseif(registromit == '215m')
    numero = 37;
elseif(registromit == '217m')
    numero = 38;
elseif(registromit == '219m')
    numero = 39;
elseif(registromit == '220m')
    numero = 40;
elseif(registromit == '221m')
    numero = 41;
elseif(registromit == '222m')
    numero = 42;
elseif(registromit == '223m')
    numero = 43;
elseif(registromit == '228m')
    numero = 44;
elseif(registromit == '230m')
    numero = 45;
elseif(registromit == '231m')
    numero = 46;
elseif(registromit == '232m')
    numero = 47;
elseif(registromit == '233m')
    numero = 48;
elseif(registromit == '234m')
    numero = 49;
end

%ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoRVentanasSC(conexionBD, registromit, numero, fs, 0, random, muestras);
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoRVentanas(conexionBD, registromit, numero, fs, 0, random, muestras);
y=1;
for i=1:size(anotacion,1)
    if(random<=anotacion{i, 2} && (random + muestras)>=anotacion{i, 2})
        anotacionAnalizar{y,1} = anotacion{i,1};
        anotacionAnalizar{y,2} = anotacion{i,2};
        anotacionAnalizar{y,3} = anotacion{i,3};
        anotacionAnalizar{y,4} = anotacion{i,4};
        anotacionAnalizar{y,5} = anotacion{i,5};
        anotacionAnalizar{y,6} = anotacion{i,6};
        anotacionAnalizar{y,7} = anotacion{i,7};
        anotacionAnalizar{y,8} = anotacion{i,8};
        %anotacionAnalizar{y,9} = anotacion{i,9};
        y = y + 1;
    end
end
anotacionAnalizar = cell2table(anotacionAnalizar);
anotacionAnalizar.Properties.VariableNames = anotacion.Properties.VariableNames;
Rindex = Rindex + random;
[VPR,FPR,FNR, SensiR, PredpR, VParregloR, FParregloR, FNarregloR] = sensiPred(Rindex, anotacionAnalizar);
picosRAlgoritmo = [picosRAlgoritmo; "Pico R" vueltas registromit random random+muestras  (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPR FPR FNR SensiR PredpR];
end
filename = filenameArreglo{pruebas};
A = {'Pico R'	'Vuelta'	'Registro'	'Muestra inicio' 'Muestra final' 'Segundos inicio' 'Segundos final'	'VP'	'FP'	'FN'	'Sensibilidad'	'Predictividad'};
xlswrite(filename,A, registromit);
xlswrite(filename,picosRAlgoritmo, registromit, 'A2');
promedio = xlsread(filename, registromit);
sensibilidad = 0;
predictividad = 0;
vp = 0;
fp = 0;
fn = 0;
for i=1:length(promedio)
    vp = vp + promedio(i,7);
    fp = fp + promedio(i,8);
    fn = fn + promedio(i,9);
    sensibilidad = sensibilidad + promedio(i,10);
    predictividad = predictividad + promedio(i,11);
    
end
sensibilidad = sensibilidad/length(promedio);
predictividad = predictividad/length(promedio);
disp(vp);
disp(fp);
disp(fn);

resultadosRegistro = {registromit vp fp fn sensibilidad predictividad};
cuadroRegistro = {'Registro' 'VP' 'FP' 'FN'	'Sensibilidad' 'Predictividad'};
cuadromando = cuadroMandoArreglo{pruebas};
xlswrite(filename,cuadroRegistro, cuadromando);
%resultados = xlsread(filename, cuadromando);
[~, resultados] = xlsread(filename,cuadromando);
concatenar = strcat('A',num2str(size(resultados,1) +1));
xlswrite(filename,resultadosRegistro, cuadromando, concatenar);
disp(sensibilidad);
disp(predictividad);
end
end