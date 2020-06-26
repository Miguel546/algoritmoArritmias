function varargout = OndasPT(varargin)
% ONDASPT MATLAB code for OndasPT.fig
%      ONDASPT, by itself, creates a new ONDASPT or raises the existing
%      singleton*.
%
%      H = ONDASPT returns the handle to a new ONDASPT or the handle to
%      the existing singleton*.
%
%      ONDASPT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONDASPT.M with the given input arguments.
%
%      ONDASPT('Property','Value',...) creates a new ONDASPT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OndasPT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OndasPT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OndasPT

% Last Modified by GUIDE v2.5 04-Aug-2019 19:09:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @OndasPT_OpeningFcn, ...
                   'gui_OutputFcn',  @OndasPT_OutputFcn, ...
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


% --- Executes just before OndasPT is made visible.
function OndasPT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to OndasPT (see VARARGIN)
global count;
count = 0;
% Choose default command line output for OndasPT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OndasPT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OndasPT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in menuOndaPT.
function menuOndaPT_Callback(hObject, eventdata, handles)
% hObject    handle to menuOndaPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuOndaPT contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuOndaPT


% --- Executes during object creation, after setting all properties.
function menuOndaPT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuOndaPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_PT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_PT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_PT as text
%        str2double(get(hObject,'String')) returns contents of edit_x_PT as a double


% --- Executes during object creation, after setting all properties.
function edit_x_PT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_PT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_PT_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_PT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_PT as text
%        str2double(get(hObject,'String')) returns contents of edit_y_PT as a double


% --- Executes during object creation, after setting all properties.
function edit_y_PT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_PT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in irAMuestraPT.
function irAMuestraPT_Callback(hObject, eventdata, handles)
% hObject    handle to irAMuestraPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
global textoactual;
global textoant;
global ecg;
global VParregloP; 
global FParregloP; 
global FNarregloP;

count = count + 1;

if(count == 1)
       disp('Primera vez');
       x = get(handles.edit_x_R,'String');
   %disp(x);
   posx = str2double(x);
   xlim([posx-1000 posx+1000]);
   %ecg = getappdata(0, 'ecg');
   %ecg = ecg(:);
   pos2 = [posx ecg(posx) 0];
   set(handles.edit_y_R, 'String', pos2(2));
   ecgplothandles = handles.ecgPlotR;
   hold on;

   textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);

else
       s = strcat('Vez ', count);
       disp(s);
       disp(count);
   delete(textoant);
       delete(textoactual);
       x = get(handles.edit_x_R,'String');
   %disp(x);
   posx = str2double(x);
   xlim([posx-1000 posx+1000]);
  % ecg = getappdata(0, 'ecg');
   %ecg = ecg(:);
   pos2 = [posx ecg(posx) 0];
   set(handles.edit_y_R, 'String', pos2(2));
   ecgplothandles = handles.ecgPlotR;
   hold on;
   textoactual = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
end

% --- Executes on button press in AnalizarPT.
function AnalizarPT_Callback(hObject, eventdata, handles)
% hObject    handle to AnalizarPT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ecg;
global VParregloP;
global FParregloP; 
global FNarregloP;
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl); 

cla(handles.ecgPlotPT);
ecgPlotPT = handles.ecgPlotPT;
items = get(handles.menuOndaPT,'String');
seleccionarRegistro=get(handles.menuOndaPT, 'value');
registromit = items{seleccionarRegistro};

fs = 360;
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoR(conexionBD, registromit, seleccionarRegistro, fs, 0);
[ecgs2, Rindex2, Tindex, Pindex, anotacionesP] = detectarOndasPT(conexionBD, registromit, seleccionarRegistro, ecgnormal, fs, Rindex, Q_index, S_index, K_index,0);

[VPP,FPP,FNP, SensiP, PredpP, VParregloP, FParregloP, FNarregloP] = sensiPred(Pindex, anotacionesP);
assignin('base','VParregloP',VParregloP);
assignin('base','FParregloP',FParregloP);
assignin('base','FNarregloP',FNarregloP);

axes(ecgPlotPT);

hold on,plot(ecg); title(strcat('Registro', 32,  registromit));
hold on,plot(S_index,ecg(S_index),'r+');  %Grafica picos R sobre la curva ECG acondicionada
hold on,plot(Rindex2,ecg(Rindex2),'go');
hold on, plot(Q_index, ecg(Q_index),'r*');
hold on,plot(K_index,ecg(K_index),'b+');  %K_amp_ECG
hold on,plot(Pindex,ecg(Pindex),'ko');
hold on,plot(Tindex,ecg(Tindex),'mo');
hold on,plot(anotacionesP.('Sample'),ecg(anotacionesP.('Sample')),'cx');
legend('ECG','Punto S','Punto R','Punto Q','Punto K','Onda P', 'Onda T', 'Anotaciones T')
handles.ecgPlotPT.XRuler.Exponent = 0;

ecgPlot =datacursormode(handles.figure1);

set(ecgPlot ,'UpdateFcn', {@myupdatefcn, handles.edit_x_PT, handles.edit_y_PT, 0});

set(handles.textSensibilidadPT, 'String', ['Sensibilidad: ' num2str(SensiP)]);
set(handles.textPredictividadPT, 'String', ['Predictividad: ' num2str(PredpP)]);
set(handles.textVPPT, 'String', ['VP: ' num2str(VPP)]);
set(handles.textFPPT, 'String', ['FP: ' num2str(FPP)]);
set(handles.textFNPT, 'String', ['FN: ' num2str(FNP)]);

dia= datestr(now,'ddmmyy');
hora = datestr(now,'HH:MM:SS');
nuevahora = erase(hora, ':');
fechahora = strcat(dia, '_', nuevahora);

mkdir(strcat('ondasPT/',fechahora));

copyfile('OndasPT.fig', strcat('ondasPT/',fechahora, '/', 'OndasPT.fig'));
copyfile('OndasPT.m', strcat('ondasPT/',fechahora, '/', 'OndasPT.m'));
copyfile('detectarOndasPT.m',strcat('ondasPT/',fechahora, '/', 'detectarOndasPT.m'));
copyfile('queriesAnotacionesP.mat', strcat('ondasPT/',fechahora, '/', 'queriesAnotacionesP.mat'));

querie = evalin('base', 'anotacionRegistroP');
nombresCol = {'registro','latidos','sensibilidad','predictividad','vp','fn','fp','errorsensibilidad','errorpredictividad','deteccionfallidalatidos','deteccionfallidaporc','tiempo', 'querie'};
dataInsertar = {registromit, height(anotacionesP), SensiP, PredpP, VPP, FNP, FPP, 100-SensiP, 100-PredpP, FPP+FNP, (((FPP+FNP)/height(anotacionesP))*100), fechahora, querie};
datainsert(conexionBD, 'ondasp', nombresCol, dataInsertar);

set(handles.tablaVPP,'data',[])
set(handles.tablaVPP, 'data', VParregloP);

set(handles.tablaFPP,'data',[])
set(handles.tablaFPP, 'data', FParregloP);

set(handles.tablaFNP,'data',[])

if(FNarregloR(1) == 0)
else
    for i = 1 : size(FNarregloR,1)
        for y = 1 : 5
            if(y == 5)
            else
                FNarregloRR(i,y) = FNarregloP(i,y);
            end        
         end
    end
    set(handles.tablaFNR, 'data', FNarregloRR);

end


function txt = myupdatefcn(obj,event_obj, h1, h2, opcion)
% Customizes text of data tips
%disp('Hola');
%disp(opcion);
%if (opcion == 0)
global textoactual;
global textoant;

delete(textoactual);
delete(textoant);
pos = get(event_obj,'Position');
%assignin('base','pos', pos);
I = get(event_obj, 'DataIndex');
set(h1, 'String', pos(1));
set(h2, 'String', pos(2));
%txt = {['X: ',num2str(pos(1), 6)]
%       ['Y: ',num2str(pos(2), 6)]};
txt = {};


% --- Executes when selected cell(s) is changed in tablaVPP.
function tablaVPP_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaVPP (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecg;
global textoant;
global VParregloP; 
global FParregloP; 
global FNarregloP;
if(click)
    click = false;
else
    
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecg(celdaValor) 0];
        ecgplothandles = handles.ecgPlotR;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
    end
end


% --- Executes when selected cell(s) is changed in tablaFNP.
function tablaFNP_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaFNP (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecg;
global textoant;
global VParregloP; 
global FParregloP; 
global FNarregloP;
if(click)
    click = false;
    if(size(FNarregloP,1) == 1)
        x = eventdata.Indices(1);
        y = eventdata.Indices(2);
        celdaValor = cell2mat(eventdata.Source.Data(x, 1));
        delete(textoant);
        if(y == 1 || y==2 || y == 3 || y==4) 
            xlim([celdaValor-1000 celdaValor+1000]);
            pos2 = [celdaValor ecg(celdaValor) 0];
            ecgplothandles = handles.ecgPlotPT;
            hold on;
            textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        end
    end
else
x = eventdata.Indices(1);
y = eventdata.Indices(2);
celdaValor = cell2mat(eventdata.Source.Data(x, 1));
delete(textoant);
if(y == 1 || y==2 || y == 3 || y==4) 
   xlim([celdaValor-1000 celdaValor+1000]);
   pos2 = [celdaValor ecg(celdaValor) 0];
   ecgplothandles = handles.ecgPlotPT;
   hold on;
   textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
end
end

% --- Executes when selected cell(s) is changed in tablaFPP.
function tablaFPP_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaFPP (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecg;
global textoant;
global VParregloP; 
global FParregloP; 
global FNarregloP;
if(click)
    click = false;
    if(size(FNarregloP,1) == 1)
        x = eventdata.Indices(1);
        y = eventdata.Indices(2);
        celdaValor = cell2mat(eventdata.Source.Data(x, 1));
        delete(textoant);
        if(y == 1 || y==2 || y == 3 || y==4) 
            xlim([celdaValor-1000 celdaValor+1000]);
            pos2 = [celdaValor ecg(celdaValor) 0];
            ecgplothandles = handles.ecgPlotPT;
            hold on;
            textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
        end
    end
else
    x = eventdata.Indices(1);
    y = eventdata.Indices(2);
    celdaValor = eventdata.Source.Data(x, 1);
    delete(textoant);
    if(y == 1 || y==2 || y == 3 || y==4) 
        xlim([celdaValor-1000 celdaValor+1000]);
        pos2 = [celdaValor ecg(celdaValor) 0];
        ecgplothandles = handles.ecgPlotPT;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
    end
end

