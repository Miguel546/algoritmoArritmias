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


%registrosmit = {'100m' '101m' '102m' '103m' '104m' '105m' '106m' '107m' '108m' '109m' '111m' '112m' '113m' '114m' '115m' '116m' '117m' '118m' '119m' '121m' '122m' '123m' '124m' '200m' '201m' '202m' '203m' '205m' '207m' '208m' '209m' '210m' '212m' '213m' '214m' '215m' '217m' '219m' '220m' '221m' '222m' '223m' '228m' '230m' '231m' '232m' '233m' '234m'};
registrosmit = {'104m'};

%for registro=1:length(registrosmit)
picosRAlgoritmo = [];
resultadosRegistro = [];
%for vueltas=1:1
anotacionAnalizar = [];
%registromit = registrosmit{registro};
registromit = '104m';
disp(registromit);
%disp(vueltas);

querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
anotaciones = select(conexionBD,  strjoin(querieAnotacion, ''));

fs = 360;
random = randi([0,642800]);
%random = 360833;
%random = 32186;
%arregloRandom(vueltas) = random;
muestras = 7200;
%[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoRVentanas(conexionBD, registromit, 2, fs, 0, random, muestras);
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoRVentanas(conexionBD, registromit, 2, fs, 0, random, muestras);
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
picosRAlgoritmo = [picosRAlgoritmo; "Pico R" registromit random random+muestras  (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPR FPR FNR SensiR PredpR];
%end
%end

hold on, plot(ecg);
Rindex = Rindex - random;
hold on, plot(Rindex,ecg(Rindex),'r+');  %Grafica picos R sobre la curva ECG acondicionada
hold on, plot(anotacionAnalizar{:,2} - random,ecg(anotacionAnalizar{:,2}- random),'g^');  %Grafica picos R sobre la curva ECG acondicionada