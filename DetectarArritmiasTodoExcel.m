diary(sprintf('run_%s_%d.txt',datestr(now,'yyyy_mm_dd_HH_MM_SS'),randi([1,10000],1)))


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

registrosmit = {'100m' '101m' '102m' '103m' '104m' '105m' '106m' '107m' '108m' '109m' '111m' '112m' '113m' '114m' '115m' '116m' '117m' '118m' '119m' '121m' '122m' '123m' '124m' '200m' '201m' '202m' '203m' '205m' '207m' '208m' '209m' '210m' '212m' '213m' '214m' '215m' '217m' '219m' '220m' '221m' '222m' '223m' '228m' '230m' '231m' '232m' '233m' '234m'};
%registrosmit = {'100m' '101m' '102m'};
filename = 'DeteccionArritmiasTotal.xlsx';
A = {'Registro' 'Arritmia' 'Sensibilidad' 'Predictividad' 'Numero de latidos' 'VP' 'FP' 'FN' 'Detección fallida(latidos)' 'Detección fallida(%)'};
xlswrite(filename,A);
mapper = @(x,y) strcat(char(64 + x),num2str(y));

contArritmiaTotal = 1;
contAnotaciones = 1;
for registro=1:length(registrosmit)
    clearvars -except registro registrosmit conexionBD dbname username password driver dburl filename mapper ResultadosTotal contArritmiaTotal contAnotaciones AnotacionesTotal;
    contArritmia = 1;
    registromit = registrosmit{registro};
    disp(registromit);

    %querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
    %anotaciones = select(conexionBD, strjoin(querieAnotacion, ''));

    fs = 360;
    if(registromit == '100m')
    numeroArr = 2;
elseif(registromit == '101m')
    numeroArr = 3;
elseif(registromit == '102m')
    numeroArr = 4;
elseif(registromit == '103m')
    numeroArr = 5;
elseif(registromit == '104m')
    numeroArr = 6;
elseif(registromit == '105m')
    numeroArr = 7;
elseif(registromit == '106m')
    numeroArr = 8;
elseif(registromit == '107m')
    numeroArr = 9;
elseif(registromit == '108m')
    numeroArr = 10;
elseif(registromit == '109m')
    numeroArr = 11;
elseif(registromit == '111m') 
    numeroArr = 12;
elseif(registromit == '112m') 
    numeroArr = 13;
elseif(registromit == '113m') 
    numeroArr = 14;
elseif(registromit == '114m') 
    numeroArr = 15;
elseif(registromit == '115m') 
    numeroArr = 16;
elseif(registromit == '116m')
    numeroArr = 17;
elseif(registromit == '117m')
    numeroArr = 18;
elseif(registromit == '118m')
    numeroArr = 19;
elseif(registromit == '119m')
    numeroArr = 20;
elseif(registromit == '121m') 
    numeroArr = 21;
elseif(registromit == '122m')
    numeroArr = 22;
elseif(registromit == '123m')
    numeroArr = 23;
elseif(registromit == '124m')
    numeroArr = 24;
elseif(registromit == '200m')
    numeroArr = 25;
elseif(registromit == '201m')
    numeroArr = 26;
elseif(registromit == '202m')
    numeroArr = 27;
elseif(registromit == '203m')
    numeroArr = 28;
elseif(registromit == '205m')
    numeroArr = 29;
elseif(registromit == '207m')
     numeroArr = 30;
elseif(registromit == '208m')
    numeroArr = 31;
elseif(registromit == '209m')
    numeroArr = 32;
elseif(registromit == '210m')
    numeroArr = 33;
elseif(registromit == '212m')
    numeroArr = 34;
elseif(registromit == '213m')
    numeroArr = 35;
elseif(registromit == '214m')
    numeroArr = 36;
elseif(registromit == '215m')
    numeroArr = 37;
elseif(registromit == '217m')
    numeroArr = 38;
elseif(registromit == '219m')
    numeroArr = 39;
elseif(registromit == '220m')
    numeroArr = 40;
elseif(registromit == '221m')
    numeroArr = 41;
elseif(registromit == '222m')
    numeroArr = 42;
elseif(registromit == '223m')
    numeroArr = 43;
elseif(registromit == '228m')
    numeroArr = 44;
elseif(registromit == '230m')
    numeroArr = 45;
elseif(registromit == '231m')
    numeroArr = 46;
elseif(registromit == '232m')
    numeroArr = 47;
elseif(registromit == '233m')
    numeroArr = 48;
elseif(registromit == '234m')
    numeroArr = 49;
end
[ecg, Rindex, Q_index, QOn_index, S_index, K_index,  anotacion] = pan_tompkin(conexionBD, registromit, numeroArr, fs, 0);
%[ecg, Rindex, Q_index, QOn_index, S_index, K_index,  anotacion, locs, ecg_h, ecg_d, ecg_s, ecg_m, qrs_i, qrs_c, NOISL_buf, SIGL_buf, THRS_buf, qrs_i_raw,qrs_amp_raw, NOISL_buf1, SIGL_buf1, THRS_buf1] = pan_tompkin(conexionBD, registromit, numeroArr, fs, 0);
%Rindex = qrs_i_raw;
[ecgs2, Rindex2, Tindex, Pindex, P_ON_index, anotacionesP] = detectarOndasPT(conexionBD, registromit, numeroArr, ecg, fs, Rindex, Q_index, S_index, K_index,0);
[NSyR, SyBr, AtFl, AtFib, VTa, VFl, OtraArritmia, Resultados]= detectarArritmias(conexionBD, registromit, numeroArr, ecgs2, fs, Rindex2, Pindex, P_ON_index, S_index, Q_index, QOn_index, Tindex, K_index);
%[ecgnormal, ecg, Rindex, Q_index, QOn_index, S_index, K_index,  anotacion] = detectarPuntoR(conexionBD, registromit, numeroArr, fs, 0);
%[ecgs2, Rindex2, Tindex, Pindex, P_ON_index, anotacionesP] = detectarOndasPT(conexionBD, registromit, numeroArr, ecgnormal, fs, Rindex, Q_index, S_index, K_index,0);
%[NSyR, SyBr, AtFl, AtFib, VTa, VFl, OtraArritmia, Resultados]= detectarArritmias(conexionBD, registromit, numeroArr, ecgs2, fs, Rindex2, Pindex, P_ON_index, S_index, Q_index, QOn_index, Tindex, K_index);
[conexionBD] = conexion(dbname, username, password, driver, dburl);
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
%arregloAux = unique(anotaciones(:,2));
contAtFib = 1;
contNSyR = 1;
contVFl = 1;
contVTa = 1;
contSyBr = 1;
contAtFl = 1;
contOtraArritmia = 1;

load('queriesArrAnotaciones');
%anotacionRegistro = queries(numero - 1);
%anotacion = select(conexionBD, anotacionRegistro);
if(registromit == '100m')
    numero = 1;
elseif(registromit == '101m')
    numero = 2;
elseif(registromit == '102m')
    numero = 3;
elseif(registromit == '103m')
    numero = 4;
elseif(registromit == '104m')
    numero = 5;
elseif(registromit == '105m')
    numero = 6;
elseif(registromit == '106m')
    numero = 7;
elseif(registromit == '107m')
    numero = 8;
elseif(registromit == '108m')
    numero = 9;
elseif(registromit == '109m')
    numero = 10;
elseif(registromit == '111m') 
    numero = 11;
elseif(registromit == '112m') 
    numero = 12;
elseif(registromit == '113m') 
    numero = 13;
elseif(registromit == '114m') 
    numero = 14;
elseif(registromit == '115m') 
    numero = 15;
elseif(registromit == '116m')
    numero = 16;
elseif(registromit == '117m')
    numero = 17;
elseif(registromit == '118m')
    numero = 18;
elseif(registromit == '119m')
    numero = 19;
elseif(registromit == '121m') 
    numero = 20;
elseif(registromit == '122m')
    numero = 21;
elseif(registromit == '123m')
    numero = 22;
elseif(registromit == '124m')
    numero = 23;
elseif(registromit == '200m')
    numero = 24;
elseif(registromit == '201m')
    numero = 25;
elseif(registromit == '202m')
    numero = 26;
elseif(registromit == '203m')
    numero = 27;
elseif(registromit == '205m')
    numero = 28;
elseif(registromit == '207m')
     numero = 29;
elseif(registromit == '208m')
    numero = 30;
elseif(registromit == '209m')
    numero = 31;
elseif(registromit == '210m')
    numero = 32;
elseif(registromit == '212m')
    numero = 33;
elseif(registromit == '213m')
    numero = 34;
elseif(registromit == '214m')
    numero = 35;
elseif(registromit == '215m')
    numero = 36;
elseif(registromit == '217m')
    numero = 37;
elseif(registromit == '219m')
    numero = 38;
elseif(registromit == '220m')
    numero = 39;
elseif(registromit == '221m')
    numero = 40;
elseif(registromit == '222m')
    numero = 41;
elseif(registromit == '223m')
    numero = 42;
elseif(registromit == '228m')
    numero = 43;
elseif(registromit == '230m')
    numero = 44;
elseif(registromit == '231m')
    numero = 45;
elseif(registromit == '232m')
    numero = 46;
elseif(registromit == '233m')
    numero = 47;
elseif(registromit == '234m')
    numero = 48;
end
querieAnotacion1 = queriesArr(numero);
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

%arregloAux = unique(anotaciones(:,2));
contAtFib = 1;
contNSyR = 1;
contVFl = 1;
contVTa = 1;
contSyBr = 1;
contAtFl = 1;
contOtraArritmia = 1;

for i = 1 : size(anotaciones2,1)
    numero(i) = i;
end
numero = numero(:);

anotaciones2.numero = numero;

z = 0;

for i = 1 : size(anotaciones2,1)
    if(strlength(anotaciones2{i,7}))
        z = z + 1;
        anotacionesRitmo(z,1) = anotaciones2(i,1);
        anotacionesRitmo(z,2) = anotaciones2(i,2);
        anotacionesRitmo(z,3) = anotaciones2(i,3);
        anotacionesRitmo(z,4) = anotaciones2(i,4);
        anotacionesRitmo(z,5) = anotaciones2(i,5);
        anotacionesRitmo(z,6) = anotaciones2(i,6);
        anotacionesRitmo(z,7) = anotaciones2(i,7);
        anotacionesRitmo(z,8) = anotaciones2(i,8);
        anotacionesRitmo(z,9) = anotaciones2(i,9);
    end
end

for i = 1 : size(anotacionesRitmo,1)
    if i == size(anotacionesRitmo,1)
        comienzo(i) = anotacionesRitmo{i,9} +1;
        final(i) = size(anotaciones2,1);
    else
        comienzo(i) = anotacionesRitmo{i,9} +1;
        final(i) = anotacionesRitmo{i+1,9} -1;
    end
end

comienzo = comienzo(:);
final = final(:);
anotacionesRitmo.comienzo = comienzo;
anotacionesRitmo.final = final;
assignin('base','anotacionesRitmo', anotacionesRitmo);
    for y=1:size(anotacionesRitmo,1)
        if(isequal(anotacionesRitmo{y,7}, {'(N'}))
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(N'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarNSyR{contNSyR} = anotaciones2{z,2};
                contNSyR = contNSyR + 1;
                contArritmia = contArritmia + 1;
                
            end
        elseif(isequal(anotacionesRitmo{y,7}, {'(AFIB'}))
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(AFIB'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarAtFib{contAtFib} = anotaciones2{z,2};
                contAtFib = contAtFib + 1;
                contArritmia = contArritmia + 1;
            end   
        elseif(isequal(anotacionesRitmo{y,7}, {'(VFL'}))
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(VFL'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarVFl{contVFl} = anotaciones2{z,2};
                contVFl = contVFl + 1;
                contArritmia = contArritmia + 1;
                
            end
        elseif(isequal(anotacionesRitmo{y,7}, {'(VT'}))
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(VT'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarVTa{contVTa} = anotaciones2{z,2};
                contVTa = contVTa + 1;
                contArritmia = contArritmia + 1;
            end   
        elseif(isequal(anotacionesRitmo{y,7}, {'(SBR'}))
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(SBR'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarSyBr{contSyBr} = anotaciones2{z,2};
                contSyBr = contSyBr + 1;
                contArritmia = contArritmia + 1;
            end
        elseif(isequal(anotacionesRitmo{y,7}, {'(AFL'}))
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(AFL'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarAtFl{contAtFl} = anotaciones2{z,2};
                contAtFl = contAtFl + 1;
                contArritmia = contArritmia + 1;
            end
        else
            for z=anotacionesRitmo{y,10}:anotacionesRitmo{y,11}
                arritmiasAnotaciones{contArritmia, 1} = anotaciones2{z,2};
                arritmiasAnotaciones{contArritmia, 2} = {'(OARR'};
                arritmiasAnotaciones{contArritmia, 3} = registromit;
                arregloAnalizarOtraArritmia{contOtraArritmia} = anotaciones2{z,2};
                contOtraArritmia = contOtraArritmia + 1;
                contArritmia = contArritmia + 1;
            end     
        end
    end

arregloAnalizarNSyR = arregloAnalizarNSyR(:);
arregloAnalizarAtFib = arregloAnalizarAtFib(:);
arregloAnalizarVFl = arregloAnalizarVFl(:);
arregloAnalizarVTa = arregloAnalizarVTa(:);
arregloAnalizarSyBr = arregloAnalizarSyBr(:);
arregloAnalizarAtFl = arregloAnalizarAtFl(:);
arregloAnalizarOtraArritmia = arregloAnalizarOtraArritmia(:);
arritmiasAlgoritmo = [];

for i=1:size(Resultados,1)
    for j=1:size(arritmiasAnotaciones,1)
        if(Resultados{i,2} >= arritmiasAnotaciones{j,1} -20 && Resultados{i,2} <= arritmiasAnotaciones{j,1} +20)
            Resultados{i,9} = arritmiasAnotaciones{j,1};
            Resultados{i,10} = arritmiasAnotaciones{j,2};
        end
    end
end

for i=1:size(Resultados,1)
    ResultadosTotal{contArritmiaTotal,1} = Resultados{i,1};
    ResultadosTotal{contArritmiaTotal,2} = Resultados{i,2};
    ResultadosTotal{contArritmiaTotal,3} = Resultados{i,3};
    ResultadosTotal{contArritmiaTotal,4} = Resultados{i,4};
    ResultadosTotal{contArritmiaTotal,5} = Resultados{i,5};
    ResultadosTotal{contArritmiaTotal,6} = Resultados{i,6};
    ResultadosTotal{contArritmiaTotal,7} = Resultados{i,7};
    ResultadosTotal{contArritmiaTotal,8} = Resultados{i,8};
    ResultadosTotal{contArritmiaTotal,9} = Resultados{i,9};
    ResultadosTotal{contArritmiaTotal,10} = Resultados{i,10};
    contArritmiaTotal = contArritmiaTotal + 1;
end

for i=1:size(arritmiasAnotaciones,1)
    AnotacionesTotal{contAnotaciones, 1} = arritmiasAnotaciones{i,1};
    AnotacionesTotal{contAnotaciones, 2} = arritmiasAnotaciones{i,2};
    AnotacionesTotal{contAnotaciones, 3} = arritmiasAnotaciones{i,3};
    contAnotaciones = contAnotaciones + 1;
end


if(~isempty(NSyR))
    [matrizNSyR, VPNSyR, FPNSyR, FNNSyR, SensiNSyR, PredpNSyR, VParregloNSyR, FParregloNSyR, FNarregloNSyR]=sensiPredAlgoritmos(NSyR(:,2), NSyR(:,3), NSyR(:,4), NSyR(:,5), NSyR(:,6), NSyR(:,7), cell2mat(arregloAnalizarNSyR), '(N');
    
    if(~isempty(SensiNSyR) && ~isnan(SensiNSyR))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Ritmo Sinusal Normal" SensiNSyR PredpNSyR size(arregloAnalizarNSyR,1) VPNSyR FPNSyR FNNSyR (FPNSyR + FNNSyR) ((FPNSyR + FNNSyR) * 100/size(arregloAnalizarNSyR,1))];
    end
end
if(~isempty(SyBr))
    [matrizSyBr, VPSyBr, FPSyBr, FNSyBr, SensiSyBr, PredpSyBr, VParregloSyBr, FParregloSyBr, FNarregloSyBr]=sensiPredAlgoritmos(SyBr(:,2), SyBr(:,3), SyBr(:,4), SyBr(:,5), SyBr(:,6), SyBr(:,7),cell2mat(arregloAnalizarSyBr), '(SBR');
    
    if(~isempty(SensiSyBr) && ~isnan(SensiSyBr))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Bradicardia Sinusal" SensiSyBr PredpSyBr size(arregloAnalizarSyBr,1) VPSyBr FPSyBr FNSyBr (FPSyBr + FNSyBr) ((FPSyBr + FNSyBr) * 100/size(arregloAnalizarSyBr,1))];
    end
end
if(~isempty(AtFl))
    [matrizAtFl, VPAtFl, FPAtFl, FNAtFl, SensiAtFl, PredpAtFl, VParregloAtFl, FParregloAtFl, FNarregloAtFl]=sensiPredAlgoritmos(AtFl(:,2), AtFl(:,3), AtFl(:,4), AtFl(:,5), AtFl(:,6), AtFl(:,7),cell2mat(arregloAnalizarAtFl), '(AFL'); 
   
    if(~isempty(SensiAtFl) && ~isnan(SensiAtFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Aleteo Auricular" SensiAtFl PredpAtFl size(arregloAnalizarAtFl,1) VPAtFl FPAtFl FNAtFl (FPAtFl + FNAtFl) ((FPAtFl + FNAtFl) * 100/size(arregloAnalizarAtFl,1))];
    end
end
if(~isempty(AtFib))
   [matrizAtFib, VPAtFib, FPAtFib, FNAtFib, SensiAtFib, PredpAtFib, VParregloAtFib, FParregloAtFib, FNarregloAtFib]=sensiPredAlgoritmos(AtFib(:,2), AtFib(:,3), AtFib(:,4), AtFib(:,5), AtFib(:,6), AtFib(:,7),cell2mat(arregloAnalizarAtFib), '(AFIB');
    
    if(~isempty(SensiAtFib) && ~isnan(SensiAtFib))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Fibrilacion Auricular" SensiAtFib PredpAtFib size(arregloAnalizarAtFib,1) VPAtFib FPAtFib FNAtFib (FPAtFib + FNAtFib) ((FPAtFib + FNAtFib) * 100/size(arregloAnalizarAtFib,1))];
    end
end
if(~isempty(VTa))
    [matrizVTa, VPVTa, FPVTa, FNVTa, SensiVTa, PredpVTa, VParregloVTa, FParregloVTa, FNarregloVTa]=sensiPredAlgoritmos(VTa(:,2), VTa(:,3), VTa(:,4), VTa(:,5), VTa(:,6), VTa(:,7), cell2mat(arregloAnalizarVTa), '(VT');
    
    if(~isempty(SensiVTa) && ~isnan(SensiVTa))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Taquicardia ventricular" SensiVTa PredpVTa size(arregloAnalizarVTa,1) VPVTa FPVTa FNVTa (FPVTa + FNVTa) ((FPVTa + FNVTa) * 100/size(arregloAnalizarVTa,1))];
    end
end
if(~isempty(VFl))
    [matrizVFl, VPVFl, FPVFl, FNVFl, SensiVFl, PredpVFl, VParregloVFl, FParregloVFl, FNarregloVFl]=sensiPredAlgoritmos(VFl(:,2), VFl(:,3), VFl(:,4), VFl(:,5), VFl(:,6), VFl(:,7), cell2mat(arregloAnalizarVFl), '(VFL');
    
    if(~isempty(SensiVFl) && ~isnan(SensiVFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Flutter ventricular" SensiVFl PredpVFl size(arregloAnalizarVFl,1) VPVFl FPVFl FNVFl (FPVFl + FNVFl) ((FPVFl + FNVFl) * 100/size(arregloAnalizarVFl,1))];
    end
end

if(~isempty(OtraArritmia))
    [matrizOtraArritmia, VPOtraArritmia, FPOtraArritmia, FNOtraArritmia, SensiOtraArritmia, PredpOtraArritmia, VParregloOtraArritmia, FParregloOtraArritmia, FNarregloOtraArritmia]=sensiPredAlgoritmos(OtraArritmia(:,2), OtraArritmia(:,3), OtraArritmia(:,4), OtraArritmia(:,5), OtraArritmia(:,6), OtraArritmia(:,7), cell2mat(arregloAnalizarOtraArritmia), '(OARR');
    
    if(~isempty(SensiOtraArritmia) && ~isnan(SensiOtraArritmia))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; registromit "Otra Arritmia" SensiOtraArritmia PredpOtraArritmia size(arregloAnalizarOtraArritmia,1) VPOtraArritmia FPOtraArritmia FNOtraArritmia (FPOtraArritmia + FNOtraArritmia) ((FPOtraArritmia + FNOtraArritmia) * 100/size(arregloAnalizarOtraArritmia,1))];
    end
end
assignin('base','arregloAnalizarNSyR', arregloAnalizarNSyR);
assignin('base','arregloAnalizarAtFib', arregloAnalizarAtFib);
assignin('base','arregloAnalizarVFl', arregloAnalizarVFl);
assignin('base','arregloAnalizarVTa', arregloAnalizarVTa);
assignin('base','arregloAnalizarSyBr', arregloAnalizarSyBr);
assignin('base','arregloAnalizarAtFl', arregloAnalizarAtFl);
assignin('base','arregloAnalizarOtraArritmia', arregloAnalizarOtraArritmia);
%assignin('base','arritmiasAlgoritmo', arritmiasAlgoritmo);

concatenar = [];
for i=1:size(arritmiasAlgoritmo,1)
   for y=1:size(arritmiasAlgoritmo,2)
       if(y==1)
           concatenar{i,y} = char(registromit);
       elseif(y==2)
            concatenar{i,y} = char(arritmiasAlgoritmo(i,y));
       elseif(y==3)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==4)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==5)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==6)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==7)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==8)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==9)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       elseif(y==10)
            concatenar{i,y} = str2double(arritmiasAlgoritmo(i,y));
       end
   end
end

data=xlsread(filename,'Hoja1', 'C:C');  % read the column of interest
row=length(data)+1;
xlswrite(filename,concatenar, 'Hoja1', mapper(1,(row+1)));

%clear;
%clc;
end

header = {'Registro mit', 'Latido algoritmo','PRms','QRSms', 'Frecuencia cardiaca', 'Onda P', 'Desviacion', 'Arritmia Algoritmo', 'Anotacion Latido', 'Arritmia Anotacion'};
ResultadosTotal = [header; ResultadosTotal];

header2 = {'Anotacion Latido', 'Anotacion Arritmia','Registro'};
AnotacionesTotal = [header2; AnotacionesTotal];

save('ResultadosTotal.mat','ResultadosTotal')
save('AnotacionesTotal.mat','AnotacionesTotal')

disp('Se analizo toda la base de datos de arritmias del MIT');
