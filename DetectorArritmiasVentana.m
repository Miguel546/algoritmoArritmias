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
%registrosmit = {'205m' '207m' '208m' '209m' '210m' '212m' '213m' '214m' '215m' '217m' '219m' '220m' '221m' '222m' '223m' '228m' '230m' '231m' '232m' '233m' '234m'};

registrosmit = {'100m' '103m' '112m' '201m' '207m' '221m' '222m' '223m' '232m'};
pruebasTesis = [1800 3600 7200 18000 36000 72000 180000 360000];
pruebasRandom = [648200 646400 642800 632000 614000 578000 470000 290000];
cuadroMandoArreglo = {'Cuadro de mando 5 segundos' 'Cuadro de mando 10 segundos' 'Cuadro de mando 20 segundos' 'Cuadro de mando 50 segundos' 'Cuadro de mando 100 segundos' 'Cuadro de mando 200 segundos' 'Cuadro de mando 500 segundos' 'Cuadro de mando 1000 segundos'};
%filenameArreglo = {'5segundosArritmias.xlsx' '10segundosArritmias.xlsx' '20segundosArritmias.xlsx' '50segundosArritmias.xlsx' '100segundosArritmias.xlsx' '200segundosArritmias.xlsx' '500segundosArritmias.xlsx' '1000segundosArritmias.xlsx'};
filenameArreglo = {'5segundosArritmias.xlsx' '10segundosArritmiasLiteratura.xlsx' '20segundosArritmiasLiteratura.xlsx' '50segundosArritmiasLiteratura.xlsx' '100segundosArritmiasLiteratura.xlsx' '200segundosArritmiasLiteratura.xlsx' '500segundosArritmiasLiteratura.xlsx' '1000segundosArritmiasLiteratura.xlsx'};
for pruebas=1:length(pruebasTesis)
for registro=1:length(registrosmit)
    arritmiasAlgoritmo = {};
for vueltas=1:100
registromit = registrosmit{registro};
disp(registromit);

querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
anotaciones = select(conexionBD, strjoin(querieAnotacion, ''));

fs = 360;
random = randi([0,pruebasRandom(pruebas)]);
%random = 450388;
%random = 510484;
%random = 504982;
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

[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoRVentanas(conexionBD, registromit, numero, fs, 0, random, muestras);
Tindex = 0;
Pindex = 0;
[ecgs2, Rindex2, Tindex, Pindex, anotacionesP] = detectarOndasPT(conexionBD, registromit, numero, ecgnormal, fs, Rindex, Q_index, S_index, K_index,0);
% for i=1:muestras
%      ecgs2(i,2) = random + i -1;
% end

%[ritmoregular, bradicardiamatriz, taquicardiamatriz, PicoR, NSyR, SyBr, SyTa, SyAr, AtFl, AtFib, VTa, VFl, B1Gr, OtraArritmia]= detectarArritmias(conexionBD, registromit, numero, ecgs2, fs, Rindex2, Pindex, S_index, Q_index, Tindex, K_index);
[ritmoregular, bradicardiamatriz, taquicardiamatriz, PicoR, NSyR, SyBr, SyTa, SyAr, AtFl, AtFib, VTa, VFl, B1Gr, OtraArritmia]= detectarArritmiasLiteratura(conexionBD, registromit, numero, ecgs2, fs, Rindex2, Pindex, S_index, Q_index, Tindex, K_index);
querieAnotacion1 = ["SELECT * FROM mitarrythmiadatabase.anotaciones" registromit ";"];
assignin('base','querieAnotacion1', strjoin(querieAnotacion1, ''));
anotaciones2 = select(conexionBD, strjoin(querieAnotacion1, ''));
assignin('base','anotaciones2', anotaciones2);
arregloAnalizarNSyR = [];
arregloAnalizarAtFib = [];
arregloAnalizarVFl = [];
arregloAnalizarVTa = [];
arregloAnalizarSyBr = [];
arregloAnalizarAtFl = [];
arregloAnalizarOtraArritmia = [];
arregloAux = unique(anotaciones(:,2));
contAtFib = 1;
contNSyR = 1;
contVFl = 1;
contVTa = 1;
contSyBr = 1;
contAtFl = 1;
contOtraArritmia = 1;

for y=1:size(anotaciones,1)
    if(isequal(anotaciones{y,2}, {'(N'}))
        for z=anotaciones{y,11}:anotaciones{y,12}
            anotacion{find(anotacion.id==z,8), 9} = {'(N'};
        end
    elseif(isequal(anotaciones{y,2}, {'(AFIB'}))
         for z=anotaciones{y,11}:anotaciones{y,12}
                anotacion{find(anotacion.id==z,8), 9} = {'(AFIB'};
         end
    elseif(isequal(anotaciones{y,2}, {'(VFL'}))
         for z=anotaciones{y,11}:anotaciones{y,12}
                anotacion{find(anotacion.id==z,8), 9} = {'(VFL'};
         end
    elseif(isequal(anotaciones{y,2}, {'(VT'}))
         for z=anotaciones{y,11}:anotaciones{y,12}
                anotacion{find(anotacion.id==z,8), 9} = {'(VT'};
         end
    elseif(isequal(anotaciones{y,2}, {'(SBR'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                anotacion{find(anotacion.id==z,8), 9} = {'(SBR'};
            end
    elseif(isequal(anotaciones{y,2}, {'(AFL'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                anotacion{find(anotacion.id==z,8), 9} = {'(AFL'};
            end
    else
            for z=anotaciones{y,11}:anotaciones{y,12}
                anotacion{find(anotacion.id==z,8), 9} = {'(OARR'};
            end
    end
end

idx=all(cellfun(@isempty,anotacion{:,9}),2);
anotacion(idx,:)=[];
y=1;
anotacionAnalizar = {};
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
        anotacionAnalizar{y,9} = anotacion{i,9};
        y = y + 1;
    end
end

if(exist('anotacionAnalizar'))
   anotacionAnalizar{1,1} = '00:01.364';
   anotacionAnalizar{1,2} = 0;
   anotacionAnalizar{1,3} = 'A';
   anotacionAnalizar{1,4} = '0';
   anotacionAnalizar{1,5} = '0';
   anotacionAnalizar{1,6} = '0';
   anotacionAnalizar{1,7} = '0';
   anotacionAnalizar{1,8} = '0';
   anotacionAnalizar{1,9} = '0'; 
end
%anotacionAnalizar = anotacionAnalizar(:);
%random = random + muestras;

%%%-----------------%%%
for y=1:size(anotacionAnalizar,1)
    if(isequal(anotacionAnalizar{y,9}, {'(N'}))
       arregloAnalizarNSyR(contNSyR) = cell2mat(anotacionAnalizar(y,2));
       contNSyR = contNSyR + 1;
    elseif(isequal(anotacionAnalizar{y,9}, {'(AFIB'}))
       arregloAnalizarAtFib(contAtFib) = cell2mat(anotacionAnalizar(y,2));
       contAtFib = contAtFib + 1;
    elseif(isequal(anotacionAnalizar{y,9}, {'(VFL'}))
       arregloAnalizarVFl(contVFl) = cell2mat(anotacionAnalizar(y,2));
       contVFl = contVFl + 1;
    elseif(isequal(anotacionAnalizar{y,9}, {'(VT'}))
       arregloAnalizarVTa(contVTa) = cell2mat(anotacionAnalizar(y,2));
       contVTa = contVTa + 1;
     elseif(isequal(anotacionAnalizar{y,9}, {'(SBR'}))
       arregloAnalizarSyBr(contSyBr) = cell2mat(anotacionAnalizar(y,2));
       contSyBr = contSyBr + 1;
     elseif(isequal(anotacionAnalizar{y,2}, {'(AFL'}))
       arregloAnalizarAtFl(contAtFl) = cell2mat(anotacionAnalizar(y,2));
       contAtFl = contAtFl + 1;
    else
       arregloAnalizarOtraArritmia(contOtraArritmia) = cell2mat(anotacionAnalizar(y,2));
       contOtraArritmia = contOtraArritmia + 1;
    end
        
end
%%%-----------------%%%

arregloAnalizarNSyR = arregloAnalizarNSyR(:);
arregloAnalizarAtFib = arregloAnalizarAtFib(:);
arregloAnalizarVFl = arregloAnalizarVFl(:);
arregloAnalizarVTa = arregloAnalizarVTa(:);
arregloAnalizarSyBr = arregloAnalizarSyBr(:);
arregloAnalizarAtFl = arregloAnalizarAtFl(:);
arregloAnalizarOtraArritmia = arregloAnalizarOtraArritmia(:);
% for i=1:size(arregloAnalizarNSyR,1)
%     arregloAnalizarNSyR{i} = arregloAnalizarNSyR{i} - random;
% end
% hold on, plot(ecg);
% hold on, plot(Rindex2,ecg(Rindex2),'r+');  %Grafica picos R sobre la curva ECG acondicionada
% 
% if(~isempty(AtFib))
%     hold on, plot(AtFib(:,2),ecg(AtFib(:,2)),'b*');
%     hold on, plot(arregloAnalizarAtFib - random, ecg(arregloAnalizarAtFib - random), 'ko');
% end


%go
% hold on, plot(Q_index, ecgs(Q_index),'r*');
% hold on, plot(K_index,ecgs(K_index),'b+');  %K_amp_ECG
% hold on, plot(Pindex,ecgs(Pindex),'ko');
% hold on, plot(Tindex,ecgs(Tindex),'m^');
%hold on,plot(anotacionesP.('Sample'),ecg(a
if(~isempty(NSyR))
NSyR(:,2) = NSyR(:,2) + random;
end
if(~isempty(SyBr))
SyBr(:,2) = SyBr(:,2) + random;
end
if(~isempty(AtFl))
AtFl(:,2) = AtFl(:,2) + random;
end
if(~isempty(AtFib))
AtFib(:, 2) = AtFib(:,2) + random;
end
if(~isempty(VTa))
VTa(:,2) = VTa(:,2) + random;
end
if(~isempty(VFl))
VFl(:,2) = VFl(:,2) + random;
end

if(~isempty(NSyR))
    [matrizNSyR, VPNSyR, FPNSyR, FNNSyR, SensiNSyR, PredpNSyR, VParregloNSyR, FParregloNSyR, FNarregloNSyR]=sensiPredAlgoritmo(NSyR(:,2), arregloAnalizarNSyR, '(N');
    if(~isempty(SensiNSyR) && ~isnan(SensiNSyR))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Ritmo Sinusal Normal" random random+muestras  (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPNSyR FPNSyR FNNSyR SensiNSyR PredpNSyR];
        NSyRAlgoritmo = [NSyRAlgoritmo; vueltas registromit "Ritmo Sinusal Normal" random random+muestras  (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPNSyR FPNSyR FNNSyR SensiNSyR PredpNSyR];
    end
elseif(isempty(NSyR))
    [matrizNSyR, VPNSyR, FPNSyR, FNNSyR, SensiNSyR, PredpNSyR, VParregloNSyR, FParregloNSyR, FNarregloNSyR]=sensiPredAlgoritmo(0, arregloAnalizarNSyR, '(N');
    if(~isempty(SensiNSyR) && ~isnan(SensiNSyR))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Ritmo Sinusal Normal" random random+muestras  (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPNSyR FPNSyR FNNSyR SensiNSyR PredpNSyR];
        NSyRAlgoritmo = [NSyRAlgoritmo; vueltas registromit "Ritmo Sinusal Normal" random random+muestras  (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPNSyR FPNSyR FNNSyR SensiNSyR PredpNSyR];
    end
end
if(~isempty(SyBr))
    [matrizSyBr, VPSyBr, FPSyBr, FNSyBr, SensiSyBr, PredpSyBr, VParregloSyBr, FParregloSyBr, FNarregloSyBr]=sensiPredAlgoritmo(SyBr(:,2), arregloAnalizarSyBr, '(SBR');
    if(~isempty(SensiSyBr) && ~isnan(SensiSyBr))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Bradicardia Sinusal" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPSyBr FPSyBr FNSyBr SensiSyBr PredpSyBr];
        SyBrAlgoritmo = [SyBrAlgoritmo; vueltas registromit "Bradicardia Sinusal" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPSyBr FPSyBr FNSyBr SensiSyBr PredpSyBr];
    end
elseif(isempty(SyBr))
    [matrizSyBr, VPSyBr, FPSyBr, FNSyBr, SensiSyBr, PredpSyBr, VParregloSyBr, FParregloSyBr, FNarregloSyBr]=sensiPredAlgoritmo(0, arregloAnalizarSyBr, '(SBR');
    if(~isempty(SensiSyBr) && ~isnan(SensiSyBr))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Bradicardia Sinusal" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPSyBr FPSyBr FNSyBr SensiSyBr PredpSyBr];
        SyBrAlgoritmo = [SyBrAlgoritmo; vueltas registromit "Bradicardia Sinusal" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPSyBr FPSyBr FNSyBr SensiSyBr PredpSyBr];
    end
end
if(~isempty(AtFl))
    [matrizAtFl, VPAtFl, FPAtFl, FNAtFl, SensiAtFl, PredpAtFl, VParregloAtFl, FParregloAtFl, FNarregloAtFl]=sensiPredAlgoritmo(AtFl(:,2), arregloAnalizarAtFl, '(AFL');
    if(~isempty(SensiAtFl) && ~isnan(SensiAtFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Aleteo Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFl FPAtFl FNAtFl SensiAtFl PredpAtFl];
        AtFlAlgoritmo = [AtFlAlgoritmo; vueltas registromit "Aleteo Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFl FPAtFl FNAtFl SensiAtFl PredpAtFl];
    end
elseif(isempty(AtFl))
    [matrizAtFl, VPAtFl, FPAtFl, FNAtFl, SensiAtFl, PredpAtFl, VParregloAtFl, FParregloAtFl, FNarregloAtFl]=sensiPredAlgoritmo(0, arregloAnalizarAtFl, '(AFL');
    if(~isempty(SensiAtFl) && ~isnan(SensiAtFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Aleteo Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFl FPAtFl FNAtFl SensiAtFl PredpAtFl];
        AtFlAlgoritmo = [AtFlAlgoritmo; vueltas registromit "Aleteo Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFl FPAtFl FNAtFl SensiAtFl PredpAtFl];
    end
end
if(~isempty(AtFib))
   [matrizAtFib, VPAtFib, FPAtFib, FNAtFib, SensiAtFib, PredpAtFib, VParregloAtFib, FParregloAtFib, FNarregloAtFib]=sensiPredAlgoritmo(AtFib(:,2), arregloAnalizarAtFib, '(AFIB');
    if(~isempty(SensiAtFib) && ~isnan(SensiAtFib))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Fibrilacion Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFib FPAtFib FNAtFib SensiAtFib PredpAtFib];
        AtFibAlgoritmo = [AtFibAlgoritmo; vueltas registromit "Fibrilacion Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFib FPAtFib FNAtFib SensiAtFib PredpAtFib];
    end
elseif(isempty(AtFib))
    [matrizAtFib, VPAtFib, FPAtFib, FNAtFib, SensiAtFib, PredpAtFib, VParregloAtFib, FParregloAtFib, FNarregloAtFib]=sensiPredAlgoritmo(0, arregloAnalizarAtFib, '(AFIB');
    if(~isempty(SensiAtFib) && ~isnan(SensiAtFib))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Fibrilacion Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFib FPAtFib FNAtFib SensiAtFib PredpAtFib];
        AtFibAlgoritmo = [AtFibAlgoritmo; vueltas registromit "Fibrilacion Auricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPAtFib FPAtFib FNAtFib SensiAtFib PredpAtFib];
    end
end
if(~isempty(VTa))
    [matrizVTa, VPVTa, FPVTa, FNVTa, SensiVTa, PredpVTa, VParregloVTa, FParregloVTa, FNarregloVTa]=sensiPredAlgoritmo(VTa(:,2), arregloAnalizarVTa, '(VT');
    if(~isempty(SensiVTa) && ~isnan(SensiVTa))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Taquicardia ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVTa FPVTa FNVTa SensiVTa PredpVTa];
        VTaAlgoritmo = [VTaAlgoritmo; vueltas registromit "Taquicardia ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVTa FPVTa FNVTa SensiVTa PredpVTa];
    end
elseif(isempty(VTa))
    [matrizVTa, VPVTa, FPVTa, FNVTa, SensiVTa, PredpVTa, VParregloVTa, FParregloVTa, FNarregloVTa]=sensiPredAlgoritmo(0, arregloAnalizarVTa, '(VT');
    if(~isempty(SensiVTa) && ~isnan(SensiVTa))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Taquicardia ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVTa FPVTa FNVTa SensiVTa PredpVTa];
        VTaAlgoritmo = [VTaAlgoritmo; vueltas registromit "Taquicardia ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVTa FPVTa FNVTa SensiVTa PredpVTa];
    end
end
if(~isempty(VFl))
    [matrizVFl, VPVFl, FPVFl, FNVFl, SensiVFl, PredpVFl, VParregloVFl, FParregloVFl, FNarregloVFl]=sensiPredAlgoritmo(VFl(:,2), arregloAnalizarVFl, '(VFL');
    if(~isempty(SensiVFl) && ~isnan(SensiVFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Flutter ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVFl FPVFl FNVFl SensiVFl PredpVFl];
        VFlAlgoritmo = [VFlAlgoritmo; vueltas registromit "Flutter ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVFl FPVFl FNVFl SensiVFl PredpVFl];
    end
elseif(isempty(VFl))
    [matrizVFl, VPVFl, FPVFl, FNVFl, SensiVFl, PredpVFl, VParregloVFl, FParregloVFl, FNarregloVFl]=sensiPredAlgoritmo(0, arregloAnalizarVFl, '(VFL');
    if(~isempty(SensiVFl) && ~isnan(SensiVFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "Flutter ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVFl FPVFl FNVFl SensiVFl PredpVFl];
        VFlAlgoritmo = [VFlAlgoritmo; vueltas registromit "Flutter ventricular" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPVFl FPVFl FNVFl SensiVFl PredpVFl];
    end
end
if(~isempty(OtraArritmia))
    if(arregloAnalizarOtraArritmia == 0)
    else
        [matrizOtraArritmia, VPOtraArritmia, FPOtraArritmia, FNOtraArritmia, SensiOtraArritmia, PredpOtraArritmia, VParregloOtraArritmia, FParregloOtraArritmia, FNarregloOtraArritmia]=sensiPredAlgoritmo(OtraArritmia(:,2), arregloAnalizarOtraArritmia, '(OARR');
    if(~isempty(SensiOtraArritmia) && ~isnan(SensiOtraArritmia))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "OtraArritmia" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPOtraArritmia FPOtraArritmia FNOtraArritmia SensiOtraArritmia PredpOtraArritmia];
        OARRAlgoritmo = [OARRAlgoritmo; vueltas registromit "OtraArritmia" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPOtraArritmia FPOtraArritmia FNOtraArritmia SensiOtraArritmia PredpOtraArritmia];
    end
    end
    
elseif(isempty(OtraArritmia))
    if(arregloAnalizarOtraArritmia == 0)
    else
        [matrizOtraArritmia, VPOtraArritmia, FPOtraArritmia, FNOtraArritmia, SensiOtraArritmia, PredpOtraArritmia, VParregloOtraArritmia, FParregloOtraArritmia, FNarregloOtraArritmia]=sensiPredAlgoritmo(0, arregloAnalizarOtraArritmia, '(OARR');
        if(~isempty(SensiOtraArritmia) && ~isnan(SensiOtraArritmia))
            arritmiasAlgoritmo = [arritmiasAlgoritmo; vueltas registromit "OtraArritmia" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPOtraArritmia FPOtraArritmia FNOtraArritmia SensiOtraArritmia PredpOtraArritmia];
            OARRAlgoritmo = [OARRAlgoritmo; vueltas registromit "OtraArritmia" random random+muestras (random*1805.55/650000) ((random+muestras)*1805.55/650000) VPOtraArritmia FPOtraArritmia FNOtraArritmia SensiOtraArritmia PredpOtraArritmia];
        end
    end    
end

assignin('base','arregloAnalizarNSyR', arregloAnalizarNSyR);
assignin('base','arregloAnalizarAtFib', arregloAnalizarAtFib);
assignin('base','arregloAnalizarVFl', arregloAnalizarVFl);
assignin('base','arregloAnalizarVTa', arregloAnalizarVTa);
assignin('base','arregloAnalizarSyBr', arregloAnalizarSyBr);
assignin('base','arregloAnalizarAtFl', arregloAnalizarAtFl);
assignin('base','arregloAnalizarOtraArritmia', arregloAnalizarOtraArritmia);
assignin('base','arritmiasAlgoritmo', arritmiasAlgoritmo);

concatenar = [];
for i=1:size(arritmiasAlgoritmo,1)
   for y=1:size(arritmiasAlgoritmo,2)
       if(y==1)
            concatenar{i,y} = char(arritmiasAlgoritmo(i,y));
       elseif(y==2)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==3)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       end
   end
end
disp(random);
disp(muestras);
disp(vueltas);
end


VPRSN = 0;
FPRSN = 0;
FNRSN = 0;
RSN = 0;
SENSRSN = 0;
PREDIRSN = 0;

VPSYBR = 0;
FPSYBR = 0;
FNSYBR = 0;
SYBR = 0;
SENSSYBR = 0;
PREDISYBR = 0;

VPALAUR = 0;
FPALAUR = 0;
FNALAUR = 0;
ALAUR = 0;
SENSALAUR = 0;
PREDIALAUR = 0;

VPSAFIB = 0;
FPAFIB = 0;
FNAAFIB = 0;
AFIB = 0;
SENSAFIB = 0;
PREDIAFIB = 0;

VPTV = 0;
FPTV = 0;
FNTV = 0;
TV = 0;
SENSTV = 0;
PREDITV = 0;

VPFV = 0;
FPFV = 0;
FNFV = 0;
FV = 0;
SENSFV = 0;
PREDIFV = 0;

VPOARR = 0;
FPOARR = 0;
FNOARR = 0;
OARR = 0;
SENSOARR = 0;
PREDIOARR = 0;
for i=1:size(arritmiasAlgoritmo,1)
    if(isequal(arritmiasAlgoritmo(i,3), "Ritmo Sinusal Normal"))
        RSN = RSN + 1;
        VPRSN = VPRSN + str2double(arritmiasAlgoritmo(i,8));
        FPRSN = FPRSN + str2double(arritmiasAlgoritmo(i,9));
        FNRSN = FNRSN + str2double(arritmiasAlgoritmo(i,10));
        SENSRSN = SENSRSN + str2double(arritmiasAlgoritmo(i,11));
        PREDIRSN = PREDIRSN + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Bradicardia Sinusal"))
        VPSYBR = VPSYBR + str2double(arritmiasAlgoritmo(i,8));
        FPSYBR = FPSYBR + str2double(arritmiasAlgoritmo(i,9));
        FNSYBR = FNSYBR + str2double(arritmiasAlgoritmo(i,10));
        SYBR = SYBR + 1;
        SENSSYBR = SENSSYBR + str2double(arritmiasAlgoritmo(i,11));
        PREDISYBR = PREDISYBR + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Aleteo Auricular"))
        VPALAUR = VPALAUR + str2double(arritmiasAlgoritmo(i,8));
        FPALAUR = FPALAUR + str2double(arritmiasAlgoritmo(i,9));
        FNALAUR = FNALAUR + str2double(arritmiasAlgoritmo(i,10));
        ALAUR = ALAUR + 1;
        SENSALAUR = SENSALAUR + str2double(arritmiasAlgoritmo(i,11));
        PREDIALAUR = PREDIALAUR + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Fibrilacion Auricular"))
        VPSAFIB = VPSAFIB + str2double(arritmiasAlgoritmo(i,8));
        FPAFIB = FPAFIB + str2double(arritmiasAlgoritmo(i,9));
        FNAAFIB = FNAAFIB + str2double(arritmiasAlgoritmo(i,10));
        AFIB = AFIB + 1;
        SENSAFIB = SENSAFIB + str2double(arritmiasAlgoritmo(i,11));
        PREDIAFIB = PREDIAFIB + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Taquicardia ventricular"))
        VPTV = VPTV + str2double(arritmiasAlgoritmo(i,8));
        FPTV = FPTV + str2double(arritmiasAlgoritmo(i,9));
        FNTV = FNTV + str2double(arritmiasAlgoritmo(i,10));
        TV = TV + 1;
        SENSTV = SENSTV + str2double(arritmiasAlgoritmo(i,11));
        PREDITV = PREDITV + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "Flutter ventricular"))
        VPFV = VPFV + str2double(arritmiasAlgoritmo(i,8));
        FPFV = FPFV + str2double(arritmiasAlgoritmo(i,9));
        FNFV = FNFV + str2double(arritmiasAlgoritmo(i,10));
        FV = FV + 1;
        SENSFV = SENSFV + str2double(arritmiasAlgoritmo(i,11));
        PREDIFV = PREDIFV + str2double(arritmiasAlgoritmo(i,12));
    elseif(isequal(arritmiasAlgoritmo(i,3), "OtraArritmia"))
        VPOARR = VPOARR + str2double(arritmiasAlgoritmo(i,8));
        FPOARR = FPOARR + str2double(arritmiasAlgoritmo(i,9));
        FNOARR = FNOARR + str2double(arritmiasAlgoritmo(i,10));
        OARR = OARR + 1;
        SENSOARR = SENSOARR + str2double(arritmiasAlgoritmo(i,11));
        PREDIOARR = PREDIOARR + str2double(arritmiasAlgoritmo(i,12));
    end
end
PREDIRSN = PREDIRSN/RSN;
SENSRSN = SENSRSN/RSN;

SENSSYBR = SENSSYBR/SYBR;
PREDISYBR = PREDISYBR/SYBR;

SENSALAUR = SENSALAUR/ALAUR;
PREDIALAUR = PREDIALAUR/ALAUR;

SENSAFIB = SENSAFIB/AFIB;
PREDIAFIB = PREDIAFIB/AFIB;

SENSTV = SENSTV/TV;
PREDITV = PREDITV/TV;

SENSFV = SENSFV/FV;
PREDIFV = PREDIFV/FV;

SENSOARR = SENSOARR/OARR;
PREDIOARR = PREDIOARR/OARR;

globalArritmiasAlgoritmo=[];

if(~isempty(SENSRSN) && ~isnan(SENSRSN))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Ritmo Sinusal Normal" VPRSN FPRSN FNRSN SENSRSN PREDIRSN];
end

if(~isempty(SENSSYBR) && ~isnan(SENSSYBR))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Bradicardia Sinusal" VPSYBR FPSYBR FNSYBR SENSSYBR PREDISYBR];
end

if(~isempty(SENSALAUR) && ~isnan(SENSALAUR))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Aleteo Auricular" VPALAUR FPALAUR FNALAUR SENSALAUR PREDIALAUR];
end

if(~isempty(SENSAFIB) && ~isnan(SENSAFIB))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Fibrilacion Auricular" VPSAFIB FPAFIB FNAAFIB SENSAFIB PREDIAFIB];
end

if(~isempty(SENSTV) && ~isnan(SENSTV))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Taquicardia ventricular" VPTV FPTV FNTV SENSTV PREDITV];
end

if(~isempty(SENSFV) && ~isnan(SENSFV))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "Flutter ventricular" VPFV FPFV FNFV SENSFV PREDIFV];
end

if(~isempty(SENSOARR) && ~isnan(SENSOARR))
    globalArritmiasAlgoritmo = [globalArritmiasAlgoritmo; registromit "OtraArritmia" VPOARR FPOARR FNOARR SENSOARR PREDIOARR];
end

filename = filenameArreglo{pruebas};
A = {'Arritmia'	'Vuelta' 'Registro'	'Muestra inicio' 'Muestra final' 'Segundos inicio' 'Segundos final'	'VP' 'FP' 'FN' 'Sensibilidad' 'Predictividad'};
xlswrite(filename,A, registromit);
xlswrite(filename,arritmiasAlgoritmo, registromit, 'A2');
promedio = xlsread(filename, registromit);
% sensibilidad = 0;
% predictividad = 0;
% vp = 0;
% fp = 0;
% fn = 0;
% for i=1:length(promedio)
%     vp = vp + promedio(i,7);
%     fp = fp + promedio(i,8);
%     fn = fn + promedio(i,9);
%     sensibilidad = sensibilidad + promedio(i,10);
%     predictividad = predictividad + promedio(i,11);
%     
% end
% sensibilidad = sensibilidad/length(promedio);
% predictividad = predictividad/length(promedio);
% disp(vp);
% disp(fp);
% disp(fn);

%resultadosRegistro = {registromit vp fp fn sensibilidad predictividad};
cuadroRegistro = {'Registro' 'Arritmia' 'VP' 'FP' 'FN'	'Sensibilidad' 'Predictividad'};
cuadromando = cuadroMandoArreglo{pruebas};
xlswrite(filename,cuadroRegistro, cuadromando);
%resultados = xlsread(filename, cuadromando);
[~, resultados] = xlsread(filename,cuadromando);
concatenar = strcat('A',num2str(size(resultados,1) +1));
xlswrite(filename,globalArritmiasAlgoritmo, cuadromando, concatenar);
disp(globalArritmiasAlgoritmo);
%disp(sensibilidad);
%disp(predictividad);

end
end