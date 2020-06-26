function varargout = DetectorArritmias(varargin)
% Escenario ideal intervalos elegidos
% DETECTORARRITMIAS MATLAB code for DetectorArritmias.fig
%      DETECTORARRITMIAS, by itself, creates a new DETECTORARRITMIAS or raises the existing
%      singleton*.
%
%      H = DETECTORARRITMIAS returns the handle to a new DETECTORARRITMIAS or the handle to
%      the existing singleton*.
%
%      DETECTORARRITMIAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETECTORARRITMIAS.M with the given input arguments.
%
%      DETECTORARRITMIAS('Property','Value',...) creates a new DETECTORARRITMIAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DetectorArritmias_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DetectorArritmias_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DetectorArritmias

% Last Modified by GUIDE v2.5 15-May-2020 10:01:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DetectorArritmias_OpeningFcn, ...
                   'gui_OutputFcn',  @DetectorArritmias_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before DetectorArritmias is made visible.
function DetectorArritmias_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DetectorArritmias (see VARARGIN)

% Choose default command line output for DetectorArritmias
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

handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DetectorArritmias wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DetectorArritmias_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in menuArritmias.
function menuArritmias_Callback(hObject, eventdata, handles)
% hObject    handle to menuArritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuArritmias contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuArritmias


% --- Executes during object creation, after setting all properties.
function menuArritmias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuArritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_Arritmias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_Arritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_Arritmias as text
%        str2double(get(hObject,'String')) returns contents of edit_x_Arritmias as a double


% --- Executes during object creation, after setting all properties.
function edit_x_Arritmias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_Arritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_Arritmias_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_Arritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_Arritmias as text
%        str2double(get(hObject,'String')) returns contents of edit_y_Arritmias as a double


% --- Executes during object creation, after setting all properties.
function edit_y_Arritmias_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_Arritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
global textoactual;
global textoant;
global ecg;
global ecgs;
global ecgs2;
global PicoR;

count = count + 1;

if(count == 1)
   disp('Primera vez');
   x = get(handles.edit_x_Arritmias,'String');
   %disp(x);
   posx = str2double(x);
   xlim([posx-1000 posx+1000]);
   %ecg = getappdata(0, 'ecg');
   %ecg = ecg(:);
   pos2 = [posx ecgs(posx) 0];
   set(handles.edit_y_Arritmias, 'String', pos2(2));
   ecgplothandles = handles.ecgArritmias;
   hold on;

   textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
   
    for k=1:length(PicoR)
        if(PicoR(k, 2)<=pos2(1)+20 && PicoR(k, 2)>=pos2(1)-20)
            set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
            set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
            set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
            set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
        end
    end
    
    
else
       s = strcat('Vez ', count);
       disp(s);
       disp(count);
   delete(textoant);
   delete(textoactual);
   x = get(handles.edit_x_Arritmias,'String');
   %disp(x);
   posx = str2double(x);
   xlim([posx-1000 posx+1000]);
  % ecg = getappdata(0, 'ecg');
   %ecg = ecg(:);
   pos2 = [posx ecgs(posx) 0];
   set(handles.edit_y_Arritmias, 'String', pos2(2));
   ecgplothandles = handles.ecgArritmias;
   hold on;
   textoactual = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
    for k=1:length(PicoR)
        if(PicoR(k, 2)<=pos2(1)+20 && PicoR(k, 2)>=pos2(1)-20)
            set(handles.prms, 'String', num2str(PicoR(k, 12)));
            set(handles.qrsms, 'String', num2str(PicoR(k, 13)));
            set(handles.ritmocardiaco, 'String', num2str(PicoR(k, 14)));
            set(handles.ritmoregular, 'String', num2str(PicoR(k, 18)));
        end
    end
end


% --- Executes on button press in btnAnalizarArritmias.
function btnAnalizarArritmias_Callback(hObject, eventdata, handles)
% hObject    handle to btnAnalizarArritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.arritmiaDetectada, 'String', '');
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

global NSyR;
global SyBr; 
global SyTa;
global SyAr;
global AtFl;
global AtFib;
global VTa; 
global VFl; 
global B1Gr; 
global OtraArritmia;

global VParregloNSyR;
global VParregloSyBr;
global VParregloAtFl;
global VParregloAtFib;
global VParregloVTa;
global VParregloVFl;
global VPArregloOtraArritmia;

click = true;
cla(handles.ecgArritmias);
ecgArritmias = handles.ecgArritmias;
items = get(handles.menuArritmias,'String');
seleccionarRegistro=get(handles.menuArritmias, 'value');
registromit = items{seleccionarRegistro};
disp(registromit);

querieAnotacion = ["SELECT * FROM mitarrythmiadatabase.anotacionesaux where registro = '" registromit "';"];
assignin('base','querieAnotacion', strjoin(querieAnotacion, ''));
anotaciones = select(conexionBD, strjoin(querieAnotacion, ''));
assignin('base','anotaciones', anotaciones);
columnasArritmias = ["picoR" "PRms" "QRSms" "Ritmo cardiaco" "Ritmo regular"];
columnasArritmiasFibAur = ["ranterior" "ractual" "segundoanterior" "restoanterior" "segundoactual" "restoactual" "tiemporr" "minutoanterior" "segundoanterior" "minutoactual" "segundoactual" "PRms" "QRSms" "Ritmo cardiaco" "Ritmo regular"];
anotacionArritmia = [anotaciones(:,1) anotaciones(:,2) anotaciones(:,3) anotaciones(:,4) anotaciones(:,5) anotaciones(:,6) anotaciones(:,7) anotaciones(:,8) anotaciones(:,9) anotaciones(:,10) anotaciones(:,11) anotaciones(:,12) anotaciones(:,13) anotaciones(:,14)];
set(handles.tablaAnotaciones,'ColumnName',anotacionArritmia.Properties.VariableNames);

%set(handles.tablaAnotaciones,'data',[])
set(handles.tablaAnotaciones, 'data', table2cell(anotacionArritmia));
fs = 360;
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoR(conexionBD, registromit, seleccionarRegistro, fs, 0);
[ecgs2, Rindex2, Tindex, Pindex, anotacionesP] = detectarOndasPT(conexionBD, registromit, seleccionarRegistro, ecgnormal, fs, Rindex, Q_index, S_index, K_index,0);
[ritmoregular, bradicardiamatriz, taquicardiamatriz, PicoR, NSyR, SyBr, SyTa, SyAr, AtFl, AtFib, VTa, VFl, B1Gr, OtraArritmia]= detectarArritmias(conexionBD, registromit, seleccionarRegistro, ecgs2, fs, Rindex2, Pindex, S_index, Q_index, Tindex, K_index);
%[ritmoregular, bradicardiamatriz, taquicardiamatriz, PicoR, NSyR, SyBr, SyTa, SyAr, AtFl, AtFib, VTa, VFl, B1Gr, OtraArritmia]= detectarArritmiasLiteratura(conexionBD, registromit, seleccionarRegistro, ecgs2, fs, Rindex2, Pindex, S_index, Q_index, Tindex, K_index);
assignin('base', 'ecgs', ecgs2);
%%
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

hold on,plot(ecgs); title(strcat('Registro', 32,  registromit));
hold on,plot(S_index,ecgs(S_index),'r+');  %Grafica picos R sobre la curva ECG acondicionada
hold on,plot(Rindex2,ecgs(Rindex2),'go');
hold on, plot(Q_index, ecgs(Q_index),'r*');
hold on,plot(K_index,ecgs(K_index),'b+');  %K_amp_ECG
hold on,plot(Pindex,ecgs(Pindex),'ko');
hold on,plot(Tindex,ecgs(Tindex),'m^');
%hold on,plot(anotacionesP.('Sample'),ecg(anotacionesP.('Sample')),'cx');
%legend('ECG','Punto S','Punto R','Punto Q','Punto K','Onda P', 'Onda T', 'Anotaciones T')
legend('ECG','Punto S','Punto R','Punto Q','Punto K','Onda P', 'Onda T');
handles.ecgArritmias.XRuler.Exponent = 0;

ecgPlot = datacursormode(handles.figure1);
R_amp= ecgs(Rindex2);
P_amp= ecgs(Pindex);
set(ecgPlot ,'UpdateFcn', {@myupdatefcn, handles.edit_x_Arritmias, handles.edit_y_Arritmias, 0});
Rindex2 = Rindex2(:);
assignin('base','Rindex',Rindex2);
assignin('base','Pindex',Pindex);
assignin('base','Tindex',Tindex);
assignin('base','RindexAmp', R_amp);
assignin('base','PindexAmp', P_amp);

for i = 1 : length(Pindex)
    AusenciaP(i, 1) = abs(P_amp(i)/R_amp(i));
    AusenciaP(i, 2) = Pindex(i);
end
indmayor = 1;
for i = 1 : length(Pindex)
    if(AusenciaP(i) < 0.01)
        mayor{indmayor, 1} = AusenciaP(i, 1);
        mayor{indmayor, 2} = AusenciaP(i, 2);
        indmayor = indmayor + 1;
    end
end


assignin('base','mayor', mayor);
assignin('base','ausenciaP', AusenciaP);
assignin('base','ritmoregular',ritmoregular);
assignin('base','bradicardiamatriz',bradicardiamatriz);
assignin('base','taquicardiamatriz',taquicardiamatriz);
assignin('base','PicoR', PicoR);
assignin('base','NSyR',NSyR);
assignin('base','SyBr',SyBr);
assignin('base','SyTa',SyTa);
assignin('base','SyAr',SyAr);
assignin('base','AtFl',AtFl);
assignin('base','AtFib',AtFib);
assignin('base','VTa',VTa);
assignin('base','VFl',VFl);
assignin('base','B1Gr',B1Gr);
assignin('base','OtraArritmia', OtraArritmia);

set(handles.tablaRSN,'ColumnName',columnasArritmias);
set(handles.tablaBS,'ColumnName',columnasArritmias);
set(handles.tablaAA,'ColumnName',columnasArritmias);
set(handles.tablaFA,'ColumnName',columnasArritmias);
set(handles.tablaTV,'ColumnName',columnasArritmias);
set(handles.tablaFV,'ColumnName',columnasArritmias);
set(handles.tablaOA,'ColumnName',columnasArritmias);
arritmiasAlgoritmo = [];
arregloAnalizarNSyR = [];
picosNSyR = [];
VPNSyR = [];
FPNSyR = [];
FNNSyR = []; 
SensiNSyR = [];
PredpNSyR = []; 
VParregloNSyR = []; 
FParregloNSyR = [] 
FNarregloNSyR = [];
matrizNSyR = [];
VPSyBr = [];
FPSyBr = [];
FNSyBr = []; 
SensiSyBr = [];
PredpSyBr = []; 
VParregloSyBr = [];
FParregloSyBr = []; 
FNarregloSyBr = [];
arregloAnalizarOtraArritmia = [];

%set(handles.tablaAnotaciones,'data',[])

set(handles.tablaRSN,'data',[]);
set(handles.tablaBS,'data', []);
%set(handles.tablaTS,'data', []);
set(handles.tablaAA,'data', []);
set(handles.tablaFA,'data', []);
set(handles.tablaTV,'data', []);
set(handles.tablaFV,'data', []);

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
                arregloAnalizarNSyR{contNSyR} = anotaciones2{z,2};
                contNSyR = contNSyR + 1;
            end
        elseif(isequal(anotaciones{y,2}, {'(AFIB'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                arregloAnalizarAtFib{contAtFib} = anotaciones2{z,2};
                contAtFib = contAtFib + 1;
            end   
        elseif(isequal(anotaciones{y,2}, {'(VFL'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                arregloAnalizarVFl{contVFl} = anotaciones2{z,2};
                contVFl = contVFl + 1;
                
            end
        elseif(isequal(anotaciones{y,2}, {'(VT'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                arregloAnalizarVTa{contVTa} = anotaciones2{z,2};
                contVTa = contVTa + 1;
            end   
        elseif(isequal(anotaciones{y,2}, {'(SBR'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                arregloAnalizarSyBr{contSyBr} = anotaciones2{z,2};
                contSyBr = contSyBr + 1;
            end
        elseif(isequal(anotaciones{y,2}, {'(AFL'}))
            for z=anotaciones{y,11}:anotaciones{y,12}
                arregloAnalizarAtFl{contAtFl} = anotaciones2{z,2};
                contAtFl = contAtFl + 1;
            end
        else
            for z=anotaciones{y,11}:anotaciones{y,12}
                arregloAnalizarOtraArritmia{contOtraArritmia} = anotaciones2{z,2};
                contOtraArritmia = contOtraArritmia + 1;
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
if(~isempty(NSyR))
    [matrizNSyR, VPNSyR, FPNSyR, FNNSyR, SensiNSyR, PredpNSyR, VParregloNSyR, FParregloNSyR, FNarregloNSyR]=sensiPredAlgoritmos(NSyR(:,2), NSyR(:,12), NSyR(:,13), NSyR(:,14), NSyR(:,15), cell2mat(arregloAnalizarNSyR), '(N');
    set(handles.tablaRSN, 'data', VParregloNSyR);
    if(~isempty(SensiNSyR) && ~isnan(SensiNSyR))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "Ritmo Sinusal Normal" SensiNSyR PredpNSyR];
    end
end
if(~isempty(SyBr))
    [matrizSyBr, VPSyBr, FPSyBr, FNSyBr, SensiSyBr, PredpSyBr, VParregloSyBr, FParregloSyBr, FNarregloSyBr]=sensiPredAlgoritmos(SyBr(:,2), SyBr(:,12), SyBr(:,13), SyBr(:,14), SyBr(:,15), cell2mat(arregloAnalizarSyBr), '(SBR');
    set(handles.tablaBS, 'data', VParregloSyBr);
    if(~isempty(SensiSyBr) && ~isnan(SensiSyBr))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "Bradicardia Sinusal" SensiSyBr PredpSyBr];
    end
end
if(~isempty(AtFl))
    [matrizAtFl, VPAtFl, FPAtFl, FNAtFl, SensiAtFl, PredpAtFl, VParregloAtFl, FParregloAtFl, FNarregloAtFl]=sensiPredAlgoritmos(AtFl(:,2), AtFl(:,12), AtFl(:,13), AtFl(:,14), AtFl(:,15), cell2mat(arregloAnalizarAtFl), '(AFL'); 
    set(handles.tablaAA, 'data', VParregloAtFl);
    if(~isempty(SensiAtFl) && ~isnan(SensiAtFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "Aleteo Auricular" SensiAtFl PredpAtFl];
    end
end
if(~isempty(AtFib))
   [matrizAtFib, VPAtFib, FPAtFib, FNAtFib, SensiAtFib, PredpAtFib, VParregloAtFib, FParregloAtFib, FNarregloAtFib]=sensiPredAlgoritmos(AtFib(:,2), AtFib(:,12), AtFib(:,13), AtFib(:,14), AtFib(:,15), cell2mat(arregloAnalizarAtFib), '(AFIB');
    set(handles.tablaFA, 'data', VParregloAtFib);
    if(~isempty(SensiAtFib) && ~isnan(SensiAtFib))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "Fibrilacion Auricular" SensiAtFib PredpAtFib];
    end
end
if(~isempty(VTa))
    [matrizVTa, VPVTa, FPVTa, FNVTa, SensiVTa, PredpVTa, VParregloVTa, FParregloVTa, FNarregloVTa]=sensiPredAlgoritmos(VTa(:,2), VTa(:,12), VTa(:,13), VTa(:,14), VTa(:,15), cell2mat(arregloAnalizarVTa), '(VT');
    set(handles.tablaTV, 'data', VParregloVTa);
    if(~isempty(SensiVTa) && ~isnan(SensiVTa))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "Taquicardia ventricular" SensiVTa PredpVTa];
    end
end
if(~isempty(VFl))
    [matrizVFl, VPVFl, FPVFl, FNVFl, SensiVFl, PredpVFl, VParregloVFl, FParregloVFl, FNarregloVFl]=sensiPredAlgoritmos(VFl(:,2), VFl(:,12), VFl(:,13), VFl(:,14), VFl(:,15), cell2mat(arregloAnalizarVFl), '(VFL');
    set(handles.tablaFV, 'data', VParregloVFl);
    if(~isempty(SensiVFl) && ~isnan(SensiVFl))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "Flutter ventricular" SensiVFl PredpVFl];
    end
end

if(~isempty(OtraArritmia))
    [matrizOtraArritmia, VPOtraArritmia, FPOtraArritmia, FNOtraArritmia, SensiOtraArritmia, PredpOtraArritmia, VParregloOtraArritmia, FParregloOtraArritmia, FNarregloOtraArritmia]=sensiPredAlgoritmos(OtraArritmia(:,2), OtraArritmia(:,12), OtraArritmia(:,13), OtraArritmia(:,14), OtraArritmia(:,15), cell2mat(arregloAnalizarOtraArritmia), '(OARR');
    set(handles.tablaOA, 'data', VParregloOtraArritmia);
    if(~isempty(SensiOtraArritmia) && ~isnan(SensiOtraArritmia))
        arritmiasAlgoritmo = [arritmiasAlgoritmo; "OtraArritmia" SensiOtraArritmia PredpOtraArritmia];
    end
end

assignin('base', 'ecgs', ecgs2);
assignin('base', 'VParregloNSyR', VParregloNSyR);
assignin('base', 'VParregloSyBr', VParregloSyBr);
assignin('base', 'VParregloAtFl', VParregloAtFl);
assignin('base', 'VParregloAtFib', VParregloAtFib);
assignin('base', 'VParregloVTa', VParregloVTa);
assignin('base', 'VParregloVFl', VParregloVFl);
assignin('base', 'VPArregloOtraArritmia', VPArregloOtraArritmia);


assignin('base','arregloAnalizarNSyR', arregloAnalizarNSyR);
assignin('base','arregloAnalizarAtFib', arregloAnalizarAtFib);
assignin('base','arregloAnalizarVFl', arregloAnalizarVFl);
assignin('base','arregloAnalizarVTa', arregloAnalizarVTa);
assignin('base','arregloAnalizarSyBr', arregloAnalizarSyBr);
assignin('base','arregloAnalizarAtFl', arregloAnalizarAtFl);
assignin('base','arregloAnalizarOtraArritmia', arregloAnalizarOtraArritmia);
assignin('base','picosNSyR', picosNSyR);
set(handles.tablaAlgoritmo,'ColumnName', ["Arritmia" "Sensibilidad" "Predictividad"]);
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
set(handles.tablaAlgoritmo,'data',[]);
set(handles.tablaAlgoritmo, 'data', concatenar);

% --- Executes when selected cell(s) is changed in tablaAnotaciones.
function tablaAnotaciones_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaAnotaciones (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;

global VParregloNSyR;
global VParregloSyBr;
global VParregloAtFl;
global VParregloAtFib;
global VParregloVTa;
global VParregloVFl;
global VPArregloOtraArritmia;

if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, y);
    disp(celdaValor);
    disp(x);
    disp(y);
    assignin('base','x', x);
    assignin('base','y', y);
    assignin('base','celdaValor', celdaValor);
end


function txt = myupdatefcn(obj,event_obj, h1, h2, opcion)
global textoactual;
global textoant;

delete(textoactual);
delete(textoant);
pos = get(event_obj,'Position');

I = get(event_obj, 'DataIndex');
set(h1, 'String', pos(1));
set(h2, 'String', pos(2));
txt = {};


% --- Executes when selected cell(s) is changed in tablaRSN.
function tablaRSN_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaRSN (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;

global VParregloNSyR;
global VParregloSyBr;
global VParregloAtFl;
global VParregloAtFib;
global VParregloVTa;
global VParregloVFl;
global VPArregloOtraArritmia;

set(handles.arritmiaDetectada, 'String', 'Ritmo sinusal normal');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
end


% --- Executes when selected cell(s) is changed in tablaBS.
function tablaBS_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaBS (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;

global VParregloNSyR;
global VParregloSyBr;
global VParregloAtFl;
global VParregloAtFib;
global VParregloVTa;
global VParregloVFl;
global VPArregloOtraArritmia;

set(handles.arritmiaDetectada, 'String', 'Bradicardia sinusal');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
    
%     disp(celdaValor);
%     disp(x);
%     disp(y);
%     assignin('base','x', x);
%     assignin('base','y', y);
%     assignin('base','celdaValor', celdaValor);
end


% --- Executes when selected cell(s) is changed in tablaAS.
function tablaAS_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaAS (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;

global VParregloNSyR;
global VParregloSyBr;
global VParregloAtFl;
global VParregloAtFib;
global VParregloVTa;
global VParregloVFl;
global VPArregloOtraArritmia;

set(handles.arritmiaDetectada, 'String', 'Arritmia sinusal');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        disp(pos2(1));
        disp(pos2(2));
        disp(celdaValor);
        disp(ecgs(celdaValor));
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
end


% --- Executes when selected cell(s) is changed in tablaTS.
function tablaTS_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaTS (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;
set(handles.arritmiaDetectada, 'String', 'Taquicardia sinusal');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.edit_x_Arritmias, 'String', num2str(pos1));
        set(handles.edit_y_Arritmias, 'String', num2str(pos2));
    end
end


% --- Executes when selected cell(s) is changed in tablaAA.
function tablaAA_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaAA (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;

global NSyR;
global SyBr; 
global SyTa;
global SyAr;
global AtFl;
global AtFib;
global VTa; 
global VFl; 
global B1Gr; 
global OtraArritmia;

global VParregloNSyR;
global VParregloSyBr;
global VParregloAtFl;
global VParregloAtFib;
global VParregloVTa;
global VParregloVFl;
global VPArregloOtraArritmia;

set(handles.arritmiaDetectada, 'String', 'Aleteo auricular');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        
        disp(celdaValor);
        %set(handles.prms, 'String', num2str(VParregloAtFl(find(VParregloAtFl(:,2)==celdaValor),12)));
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
end


% --- Executes when selected cell(s) is changed in tablaFA.
function tablaFA_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaFA (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;
set(handles.arritmiaDetectada, 'String', 'Fibrilación auricular');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
    
end


% --- Executes when selected cell(s) is changed in tablaTV.
function tablaTV_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaTV (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;
set(handles.arritmiaDetectada, 'String', 'Taquicardia ventricular');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
end


% --- Executes when selected cell(s) is changed in tablaFV.
function tablaFV_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaFV (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;
set(handles.arritmiaDetectada, 'String', 'Fibrilación ventricular');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_Arritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_Arritmias as text
%        str2double(get(hObject,'String')) returns contents of edit_y_Arritmias as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_Arritmias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected cell(s) is changed in tablaAusenciaP.
function tablaAusenciaP_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaAusenciaP (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;
global Pindex;
global mayor;
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = cell2mat(eventdata.Source.Data(x, 2));
    delete(textoant);
    if(y==2) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.edit_x_Arritmias, 'String', num2str(pos2(1)));
        set(handles.edit_y_Arritmias, 'String', num2str(pos2(2)));
    end
end


% --- Executes on selection change in seleccionarArritmia.
function seleccionarArritmia_Callback(hObject, eventdata, handles)
% hObject    handle to seleccionarArritmia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns seleccionarArritmia contents as cell array
%        contents{get(hObject,'Value')} returns selected item from seleccionarArritmia


% --- Executes during object creation, after setting all properties.
function seleccionarArritmia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seleccionarArritmia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected cell(s) is changed in tablaOA.
function tablaOA_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaOA (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecgs;
global textoant;
set(handles.arritmiaDetectada, 'String', 'Otra Arritmia');
if(click)
    click = false;
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4 || y == 5 || y==6 || y == 7 || y==8 || y == 9 || y==10 || y == 11 || y==12 || y == 13 || y==14 || y == 15 || y==16 || y==17 || y==18) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecgs(celdaValor) 0];
        ecgplothandles = handles.ecgArritmias;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        set(handles.prms, 'String', num2str(eventdata.Source.Data(x, 2)));
        set(handles.qrsms, 'String', num2str(eventdata.Source.Data(x, 3)));
        set(handles.ritmocardiaco, 'String', num2str(eventdata.Source.Data(x, 4)));
        set(handles.ritmoregular, 'String', num2str(eventdata.Source.Data(x, 5)));
    end
    
end
