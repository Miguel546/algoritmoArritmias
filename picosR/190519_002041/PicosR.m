function varargout = PicosR(varargin)
% PICOSR MATLAB code for PicosR.fig
%      PICOSR, by itself, creates a new PICOSR or raises the existing
%      singleton*.
%
%      H = PICOSR returns the handle to a new PICOSR or the handle to
%      the existing singleton*.
%
%      PICOSR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PICOSR.M with the given input arguments.
%
%      PICOSR('Property','Value',...) creates a new PICOSR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PicosR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PicosR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PicosR

% Last Modified by GUIDE v2.5 19-May-2019 00:01:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PicosR_OpeningFcn, ...
                   'gui_OutputFcn',  @PicosR_OutputFcn, ...
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


% --- Executes just before PicosR is made visible.
function PicosR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PicosR (see VARARGIN)

% Choose default command line output for PicosR

global count;
count = 0;
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PicosR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PicosR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in menuPicoR.
function menuPicoR_Callback(hObject, eventdata, handles)
% hObject    handle to menuPicoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuPicoR contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuPicoR


% --- Executes during object creation, after setting all properties.
function menuPicoR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuPicoR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_x_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_x_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_x_R as text
%        str2double(get(hObject,'String')) returns contents of edit_x_R as a double


% --- Executes during object creation, after setting all properties.
function edit_x_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_x_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_y_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_y_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_y_R as text
%        str2double(get(hObject,'String')) returns contents of edit_y_R as a double


% --- Executes during object creation, after setting all properties.
function edit_y_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_y_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in irAMuestraR.
function irAMuestraR_Callback(hObject, eventdata, handles)
% hObject    handle to irAMuestraR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global count;
global textoactual;
global textoant;

count = count + 1;

if(count == 1)
       disp('Primera vez');
       x = get(handles.edit_x,'String');
   %disp(x);
   posx = str2double(x);
   xlim([posx-1000 posx+1000]);
   ecg = getappdata(0, 'ecg');
   ecg = ecg(:);
   pos2 = [posx ecg(posx) 0];
   set(handles.edit_y, 'String', pos2(2));
   ecgplothandles = handles.ecgplot;
   hold on;

   textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);

else
       s = strcat('Vez ', count);
       disp(s);
       disp(count);
   delete(textoant);
       delete(textoactual);
       x = get(handles.edit_x,'String');
   %disp(x);
   posx = str2double(x);
   xlim([posx-1000 posx+1000]);
   ecg = getappdata(0, 'ecg');
   ecg = ecg(:);
   pos2 = [posx ecg(posx) 0];
   set(handles.edit_y, 'String', pos2(2));
   ecgplothandles = handles.ecgplot;
   hold on;
   textoactual = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
end

% --- Executes on button press in btnAnalizar.
function btnAnalizar_Callback(hObject, eventdata, handles)
% hObject    handle to btnAnalizar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('C:\mysql\mysqlconnector\mysql-connector-java-5.1.47\mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl); 

cla(handles.ecgPlotR);
ecgPlotR = handles.ecgPlotR;
items = get(handles.menuPicoR,'String');
seleccionarRegistro=get(handles.menuPicoR, 'value');
registromit = items{seleccionarRegistro};

fs = 360;
[ecg, Rindex, anotacion] = detectarPuntoR(conexionBD, registromit, seleccionarRegistro, fs, 0);

[VPR,FPR,FNR, SensiR, PredpR, VParregloR, FParregloR, FNarregloR] = sensiPred(Rindex, anotacion);
setappdata(0,'VParregloR',VParregloR);
setappdata(0,'FParregloR',FParregloR);
setappdata(0,'FNarregloR',FNarregloR);
axes(ecgPlotR);
plot(ecg);title(strcat('Registro', 32,  registromit));
hold on,plot(Rindex,ecg(Rindex),'go');
hold on,plot(anotacion.('Sample'),ecg(anotacion.('Sample')),'m^');

legend('ecg','anotaciones', 'Rindex');
handles.ecgplot.XRuler.Exponent = 0;

ecgPlot =datacursormode(handles.figure1);

set(ecgPlot ,'UpdateFcn', {@myupdatefcn, handles.edit_x_R, handles.edit_y_R, 0});

set(handles.textSensibilidadR, 'String', ['Sensibilidad: ' num2str(SensiR)]);
set(handles.textPredictividadR, 'String', ['Predictividad: ' num2str(PredpR)]);
set(handles.textVPR, 'String', ['VP: ' num2str(VPR)]);
set(handles.textFPR, 'String', ['FP: ' num2str(FPR)]);
set(handles.textFNR, 'String', ['FN: ' num2str(FNR)]);

dia= datestr(now,'ddmmyy');
hora = datestr(now,'HH:MM:SS');
nuevahora = erase(hora, ':');
fechahora = strcat(dia, '_', nuevahora);

mkdir(strcat('picosR/',fechahora));

copyfile('PicosR.fig', strcat('picosR/',fechahora, '/', 'PicosR.fig'));
copyfile('PicosR.m', strcat('picosR/',fechahora, '/', 'PicosR.m'));
copyfile('detectarPuntoR.m',strcat('picosR/',fechahora, '/', 'detectarPuntoR.m'));
%copyfile('.m', strcat('picosR/',fechahora, '/', 'pan_tompkin.m'));
copyfile('queriesAnotaciones.mat', strcat('picosR/',fechahora, '/', 'queriesAnotaciones.mat'));

querie = evalin('base', 'anotacionRegistro');
nombresCol = {'registro','latidos','sensibilidad','predictividad','vp','fn','fp','errorsensibilidad','errorpredictividad','deteccionfallidalatidos','deteccionfallidaporc','tiempo', 'querie'};
dataInsertar = {registromit, height(anotacion), SensiR, PredpR, VPR, FNR, FPR, 100-SensiR, 100-PredpR, FPR+FNR, (((FPR+FNR)/height(anotacion))*100), fechahora, querie};
datainsert(conexionBD, 'picosr', nombresCol, dataInsertar);


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
