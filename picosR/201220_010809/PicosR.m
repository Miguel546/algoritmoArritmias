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

% Last Modified by GUIDE v2.5 04-Aug-2019 18:52:37

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
global contar;
contar = 0;
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
global ecg;

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

% --- Executes on button press in btnAnalizar.
function btnAnalizar_Callback(hObject, eventdata, handles)
% hObject    handle to btnAnalizar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ecg;
global click;
global VParregloR; 
global FParregloR; 
global FNarregloR;
global contar;
global figura1;
global figura2;
if ishandle(figura1)
close(figura1)
end

if ishandle(figura2)
close(figura2)
end
click = true;
contar = contar + 1;
dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl); 

cla(handles.ecgPlotR);
ecgPlotR = handles.ecgPlotR;
items = get(handles.menuPicoR,'String');
seleccionarRegistro=get(handles.menuPicoR, 'value');
registromit = items{seleccionarRegistro};

fs = 360;
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index, anotacion, locs, ecg_hplot, ecg_dplot, ecg_splot, ecg_mplot, qrs_i, qrs_c, NOISL_buf, SIGL_buf, THRS_buf, qrs_i_raw,qrs_amp_raw, NOISL_buf1, SIGL_buf1, THRS_buf1] = detectarPuntoR(conexionBD, registromit, seleccionarRegistro, fs, 0);
gr = 1;

figura1 = figure,
if gr
title('Hola');
ax(1)=subplot(3,2,[1 2]);plot(ecg);axis tight;title(strcat('Senal ECG ', {' '}, registromit));
end
if gr
ax(3)=subplot(323);plot(ecg_hplot);axis tight;title('Filtro pasa banda');
end
if gr
ax(4)=subplot(324);plot(ecg_dplot);axis tight;title('Derivación después del filtrado');
end
if gr
ax(5)=subplot(325);plot(ecg_splot);axis tight;title('Elevar al cuadrado');
end
if gr
ax(6)=subplot(326);plot(ecg_mplot);axis tight;title('Promedio con 30 muestras,Ruido negro,Umbral verde adaptativo,Rojo Nivel de la señal,Círculos Rojos QRS detectados');
axis tight;
end
if gr
hold on,scatter(qrs_i,qrs_c,'m');
%rojo
hold on,plot(locs,NOISL_buf,'--k','LineWidth',2);
%negro
hold on,plot(locs,SIGL_buf,'--r','LineWidth',2);
%verde
hold on,plot(locs,THRS_buf,'--g','LineWidth',2);
linkaxes(ax,'x');
zoom on;
end

if gr
   figura2 = figure;
   az(1)=subplot(311);
   plot(ecg_hplot);
   title(strcat('QRS on Señal Filtrada', {' '}, registromit));
   axis tight;
   hold on,scatter(qrs_i_raw,qrs_amp_raw,'m');
   hold on,plot(locs,NOISL_buf1,'LineWidth',2,'Linestyle','--','color','k');
   hold on,plot(locs,SIGL_buf1,'LineWidth',2,'Linestyle','-.','color','r');
   hold on,plot(locs,THRS_buf1,'LineWidth',2,'Linestyle','-.','color','g');
   az(2)=subplot(312);plot(ecg_mplot);
   title('QRS en ventana móvil de integración y nivel de ruido(negro), nivel de señal (rojo) and filtro adaptativo(verde)');axis tight;
   hold on,scatter(qrs_i,qrs_c,'m');
   hold on,plot(locs,NOISL_buf,'LineWidth',2,'Linestyle','--','color','k');
   hold on,plot(locs,SIGL_buf,'LineWidth',2,'Linestyle','-.','color','r');
   hold on,plot(locs,THRS_buf,'LineWidth',2,'Linestyle','-.','color','g');
   az(3)=subplot(313);
   plot(ecg-mean(ecg));
   title('Tren de pulsos del QRS encontrado en la señal de ECG');
   axis tight;
   line(repmat(qrs_i_raw,[2 1]),...
       repmat([min(ecg-mean(ecg))/2; max(ecg-mean(ecg))/2],size(qrs_i_raw)),...
       'LineWidth',2.5,'LineStyle','-.','Color','r');
   linkaxes(az,'x');
   zoom on;
 end
assignin('base','figura1',figura1);
assignin('base','figura2',figura2);
[VPR,FPR,FNR, SensiR, PredpR, VParregloR, FParregloR, FNarregloR] = sensiPred(Rindex, anotacion);
assignin('base','VParregloR',VParregloR);
assignin('base','FParregloR',FParregloR);
assignin('base','FNarregloR',FNarregloR);

axes(ecgPlotR);
plot(ecg);title(strcat('Registro', 32,  registromit));
hold on,plot(Rindex,ecg(Rindex),'go');
hold on,plot(anotacion.('Sample'),ecg(anotacion.('Sample')),'m^');

legend('ecg','Rindex', 'anotaciones');
handles.ecgPlotR.XRuler.Exponent = 0;

ecgPlot = datacursormode(handles.figure1);

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

copyfile('queriesAnotaciones.mat', strcat('picosR/',fechahora, '/', 'queriesAnotaciones.mat'));

querie = evalin('base', 'anotacionRegistro');
nombresCol = {'registro','latidos','sensibilidad','predictividad','vp','fn','fp','errorsensibilidad','errorpredictividad','deteccionfallidalatidos','deteccionfallidaporc','tiempo', 'querie'};
dataInsertar = {registromit, height(anotacion), SensiR, PredpR, VPR, FNR, FPR, 100-SensiR, 100-PredpR, FPR+FNR, (((FPR+FNR)/height(anotacion))*100), fechahora, querie};
datainsert(conexionBD, 'picosr', nombresCol, dataInsertar);

set(handles.tablaVPR,'data',[])
set(handles.tablaVPR,'ColumnName', ["Algoritmo" "Anotaciones"]);
set(handles.tablaVPR, 'data', VParregloR);

set(handles.tablaFPR,'data',[])
set(handles.tablaFPR, 'ColumnName', ["Muestra" "Minutos" "Segundos" "Milisegundos"]);
set(handles.tablaFPR, 'data', FParregloR);

set(handles.tablaFNR,'data',[])
set(handles.tablaFNR, 'ColumnName', ["Muestra" "Minutos" "Segundos" "Milisegundos"]);
if(isempty(FNarregloR))
else
    for i = 1 : size(FNarregloR,1)
        for y = 1 : 5
            if(y == 5)
            else
                FNarregloRR(i,y) = FNarregloR(i,y);
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


% --- Executes when selected cell(s) is changed in tablaVPR.
function tablaVPR_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaVPR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecg;
global textoant;
global VParregloR; 
global FParregloR; 
global FNarregloR;
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

% --- Executes when selected cell(s) is changed in tablaFNR.
function tablaFNR_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaFNR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecg;
global textoant;
global VParregloR; 
global FParregloR; 
global FNarregloR;
if(click)
    click = false;
    if(size(FNarregloR,1) == 1)
        x = eventdata.Indices(1);
        y = eventdata.Indices(2);
        celdaValor = cell2mat(eventdata.Source.Data(x, 1));
        delete(textoant);
        if(y == 1 || y==2 || y == 3 || y==4) 
            xlim([celdaValor-1000 celdaValor+1000]);
            pos2 = [celdaValor ecg(celdaValor) 0];
            ecgplothandles = handles.ecgPlotR;
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
   ecgplothandles = handles.ecgPlotR;
   hold on;
   textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
end
end
% --- Executes when selected cell(s) is changed in tablaFPR.
function tablaFPR_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tablaFPR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global click;
global ecg;
global textoant;
global VParregloR; 
global FParregloR; 
global FNarregloR;
if(click)
    click = false;
    if(size(FNarregloR,1) == 1)
        x = eventdata.Indices(1);
        y = eventdata.Indices(2);
        celdaValor = cell2mat(eventdata.Source.Data(x, 1));
        delete(textoant);
        if(y == 1 || y==2 || y == 3 || y==4) 
            xlim([celdaValor-1000 celdaValor+1000]);
            pos2 = [celdaValor ecg(celdaValor) 0];
            ecgplothandles = handles.ecgPlotR;
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
        ecgplothandles = handles.ecgPlotR;
        hold on;
        textoant = text(pos2(1), pos2(2), '\Delta', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Parent', ecgplothandles);
    end
end
