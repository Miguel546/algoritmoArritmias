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

filename = 'DeteccionPuntoR48Registros.xlsx';
load('queriesAnotaciones');
A = {'registromit' 'Numero de latidos' 'VPR' 'FPR' 'FNR' 'Sensibilidad' 'Predictividad' 'Detección fallida(latidos)' 'Detección fallida(%)'};
xlswrite(filename,A);
mapper = @(x,y) strcat(char(64 + x),num2str(y));
for registro=1:length(registrosmit)
    registromit = registrosmit{registro};
    disp(registromit);
    %querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
    %anotaciones = select(conexionBD, strjoin(querieAnotacion, ''));
    
    fs = 360;
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
    anotacionRegistro = queries(numero - 1);
    anotacion = select(conexionBD, anotacionRegistro);
    picosRAlgoritmo=[];
    [ecg, Rindex, Q_index, QOn_index, S_index, K_index,  anotacion, locs, ecg_h, ecg_d, ecg_s, ecg_m, qrs_i, qrs_c, NOISL_buf, SIGL_buf, THRS_buf, qrs_i_raw,qrs_amp_raw, NOISL_buf1, SIGL_buf1, THRS_buf1] = pan_tompkin(conexionBD, registromit, numero, fs, 0);
    [VPR,FPR,FNR, SensiR, PredpR, VParregloR, FParregloR, FNarregloR] = sensiPred(qrs_i_raw, anotacion);
    %picosRAlgoritmo = [picosRAlgoritmo; registromit size(anotacion,1)  VPR FPR FNR SensiR PredpR (FPR + FNR) (size(anotacion,1)/(FPR + FNR))];
    picosRAlgoritmo{1} = registromit; 
picosRAlgoritmo{2} = size(anotacion,1);  
picosRAlgoritmo{3} = VPR; 
picosRAlgoritmo{4} = FPR; 
picosRAlgoritmo{5} = FNR;
picosRAlgoritmo{6} = SensiR; 
picosRAlgoritmo{7} = PredpR; 
picosRAlgoritmo{8} = (FPR + FNR); 
picosRAlgoritmo{9} = (FPR + FNR) * 100/(size(anotacion,1));
    
   % concatenar = [];
   %for y=1:size(picosRAlgoritmo,2)
   %    if(y==1)
   %        concatenar{y} = char(picosRAlgoritmo{y});
   %    elseif(y==2)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==3)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==4)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==5)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==6)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==7)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==8)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    elseif(y==9)
   %         concatenar{y} = str2double(picosRAlgoritmo{y});
   %    end
   % end
    
    data=xlsread(filename,'Hoja1', 'C:C');  % read the column of interest
    row=length(data)+1;
    xlswrite(filename,picosRAlgoritmo, 'Hoja1', mapper(1,(row+1)));
end
disp('Se analizo toda la base de datos');