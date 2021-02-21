function [ecg, ecgs, Rindex, Q_index, QOn_index, S_index, K_index, anotacion, locs, ecg_hplot, ecg_dplot, ecg_splot, ecg_mplot, qrs_i, qrs_c, NOISL_buf, SIGL_buf, THRS_buf, qrs_i_raw,qrs_amp_raw, NOISL_buf1, SIGL_buf1, THRS_buf1] = detectarPuntoR(conexionBD, registromit, numero, fs, gr)
load(strcat('registro/',registromit));
load('queriesAnotaciones');
anotacionRegistro = queries(numero - 1);

ecg = val;
ecg = ecg(:);
setappdata(0, 'ecg', ecg);
anotacion = select(conexionBD, anotacionRegistro);
assignin('base','anotacionRegistro',anotacionRegistro);

delay = 0;
skip = 0;                                                                  % becomes one when a T wave is detected
m_selected_RR = 0;
mean_RR = 0;
ser_back = 0; 
%% Inicializar
qrs_c =[]; %amplitud de la onda R
qrs_i =[]; %indice
nois_c =[]; %amplitud del ruido
nois_i =[]; %posicion del ruido
delay = 0; %retraso
skip = 0; % se convierte en una onda T cuando es detectada
promedio2RR = 0; % Promedio de los RR regulares
promedio1RR = 0; %Es el promdio de los 8 ultimos
qrs_i_raw =[]; %La posicion del qrs
qrs_amp_raw=[]; %La amplitud del qrs
ser_back = 0; % Variable que es verdadera o falsa vale 1 cuando se tiene que hacer una busqueda hacia atras
SIGL_buf = []; % La senal despues de la ventana de integracion
NOISL_buf = []; % Ruido en la ventana de integracion
THRS_buf = []; %
SIGL_buf1 = [];
NOISL_buf1 = [];
THRS_buf1 = [];

%% Plot differently based on filtering settings
%% Diferencialmente ploteo basado en la configuracion del filtrado

%% Cancelación del ruido (Filtrado % Filtrado (Filtro entre 5-15 Hz)
%% filtro pasabanda para Cancelación del ruido o otras muestras de frecuencias (Filtrado)
f1=5; %pasa alto pasan las frecuencias mayores a 5 para deshacerse de la fluctuación lenta de fase de línea base
f2=15; %pasan las frecuencias menores a 15
Wn=[f1 f2]*2/fs; % frecuencia de corte basada en la frecuencia de muestreo
%Es el orden del filtro
%Se lo dejas a MatLab el diseño del filtro le pones lo que quieres y te
%bota los coeficientes
N = 3; % orden de 3 menos procesamiento
%Mientras mas orden le pones al filtro mas preciso es la fracción es de
%H(z)
[a,b] = butter(N,Wn); %Filtro pasabanda
%La señal filtrada
ecg_h = filtfilt(a,b,ecg);
%Normaliza
ecg_h = ecg_h/ max( abs(ecg_h)); % Se normaliza la señal para que vaya de -1 a 1

ecg_hplot = ecg_h;


%% derivative filter H(z) = (1/8T)(-z^(-2) - 2z^(-1) + 2z + z^(2))
%Derivada la ecuación de diferencias entre 1/8
%z ecuación de transferencia
%el operador derivada
h_d = [-1 -2 0 2 1]*(1/8);%1/8*fs
%La señal despues de la derivación o la señal derivada
ecg_d = filtfilt(b,1,ecg_h);
%Normalizar señal
ecg_d = ecg_d/max(ecg_d);
%Demora de dos muestras
delay = delay + 2; % delay of derivative filter 2 samples
%Para graficar la diferenciación
ecg_dplot = ecg_d;

%% Elevar al cuadrado los picos dominantes
%En una línea eleva al cuadrado
ecg_s = ecg_d.^2;
ecg_splot = ecg_s;


%% Ventana de integracion Y(nt) = (1/N)[x(nT-(N - 1)T)+ x(nT - (N - 2)T)+...+x(nT)]
%Hallar el área bajo la curva dentro de la ventana
%ecg_ventmov después de la ventana de integración y lo grafica

%Aplicar la ventana a la señal

ecg_m = conv(ecg_s ,ones(1 ,round(0.150*fs))/round(0.150*fs));
delay = delay + 15;
%Después de la señal de integración
ecg_mplot = ecg_m;


%% Marca fiducial
% Nota : una distancia minima de 72 muestras (por 360 Hz) es considerada entre cada onda
% R desde el punto fisiologico de la vista RR no puede ser menor a 200 ms
% De la ventana de integracion va a hallar los picos maximos y sus
% localizaciones esta poniendo como condición que la distancia minima entre
% los picos sea 200 ms
%picos, localización
%Te da los picos y los indices
[pks,locs] = findpeaks(ecg_m,'MINPEAKDISTANCE',round(0.2*fs));

%% =================== Initialize Some Other Parameters =============== %%
LLp = length(pks);
% ---------------- Stores QRS wrt Sig and Filtered Sig ------------------%
qrs_c = zeros(1,LLp);           % amplitude of R
qrs_i = zeros(1,LLp);           % index
qrs_i_raw = zeros(1,LLp);       % amplitude of R
qrs_amp_raw= zeros(1,LLp);      % Index
% ------------------- Noise Buffers ---------------------------------%
nois_c = zeros(1,LLp);
nois_i = zeros(1,LLp);
% ------------------- Buffers for Signal and Noise ----------------- %
SIGL_buf = zeros(1,LLp);
NOISL_buf = zeros(1,LLp);
SIGL_buf1 = zeros(1,LLp);
NOISL_buf1 = zeros(1,LLp);
THRS_buf1 = zeros(1,LLp);
THRS_buf = zeros(1,LLp);


%% initialize the training phase (2 seconds of the signal) to determine the THR_SIG and THR_NOISE
THR_SIG = max(ecg_m(1:2*fs))*1/3;                                          % 0.25 of the max amplitude 
THR_NOISE = mean(ecg_m(1:2*fs))*1/2;                                       % 0.5 of the mean signal is considered to be noise
SIG_LEV= THR_SIG;
NOISE_LEV = THR_NOISE;


%% Initialize bandpath filter threshold(2 seconds of the bandpass signal)
THR_SIG1 = max(ecg_h(1:2*fs))*1/3;                                          % 0.25 of the max amplitude 
THR_NOISE1 = mean(ecg_h(1:2*fs))*1/2; 
SIG_LEV1 = THR_SIG1;                                                        % Signal level in Bandpassed filter
NOISE_LEV1 = THR_NOISE1;                                                    % Noise level in Bandpassed filter
%% ============ Thresholding and desicion rule ============= %%
Beat_C = 0;                                                                 % Raw Beats
Beat_C1 = 0;                                                                % Filtered Beats
Noise_Count = 0;                                                            % Noise Counter
for i = 1 : LLp  
   %% ===== locate the corresponding peak in the filtered signal === %%
    if locs(i)-round(0.150*fs)>= 1 && locs(i)<= length(ecg_h)
          [y_i,x_i] = max(ecg_h(locs(i)-round(0.150*fs):locs(i)));
       else
          if i == 1
            [y_i,x_i] = max(ecg_h(1:locs(i)));
            ser_back = 1;
          elseif locs(i)>= length(ecg_h)
            [y_i,x_i] = max(ecg_h(locs(i)-round(0.150*fs):end));
          end       
    end       
  %% ================= update the heart_rate ==================== %% 
    if Beat_C >= 9        
        diffRR = diff(qrs_i(Beat_C-8:Beat_C));                                   % calculate RR interval
        mean_RR = mean(diffRR);                                            % calculate the mean of 8 previous R waves interval
        comp =qrs_i(Beat_C)-qrs_i(Beat_C-1);                                     % latest RR
    
        if comp <= 0.92*mean_RR || comp >= 1.16*mean_RR
     % ------ lower down thresholds to detect better in MVI -------- %
                THR_SIG = 0.5*(THR_SIG);
                THR_SIG1 = 0.5*(THR_SIG1);               
        else
            m_selected_RR = mean_RR;                                       % The latest regular beats mean
        end 
          
    end
    
 %% == calculate the mean last 8 R waves to ensure that QRS is not ==== %%
       if m_selected_RR
           test_m = m_selected_RR;                                         %if the regular RR availabe use it   
       elseif mean_RR && m_selected_RR == 0
           test_m = mean_RR;   
       else
           test_m = 0;
       end
        
    if test_m
          if (locs(i) - qrs_i(Beat_C)) >= round(1.66*test_m)                  % it shows a QRS is missed 
              [pks_temp,locs_temp] = max(ecg_m(qrs_i(Beat_C)+ round(0.200*fs):locs(i)-round(0.200*fs))); % search back and locate the max in this interval
              locs_temp = qrs_i(Beat_C)+ round(0.200*fs) + locs_temp -1;      % location 
             
              if pks_temp > THR_NOISE
               Beat_C = Beat_C + 1;
               qrs_c(Beat_C) = pks_temp;
               qrs_i(Beat_C) = locs_temp;      
              % ------------- Locate in Filtered Sig ------------- %
               if locs_temp <= length(ecg_h)
                  [y_i_t,x_i_t] = max(ecg_h(locs_temp-round(0.150*fs):locs_temp));
               else
                  [y_i_t,x_i_t] = max(ecg_h(locs_temp-round(0.150*fs):end));
               end
              % ----------- Band pass Sig Threshold ------------------%
               if y_i_t > THR_NOISE1 
                  Beat_C1 = Beat_C1 + 1;
                  qrs_i_raw(Beat_C1) = locs_temp-round(0.150*fs)+ (x_i_t - 1);% save index of bandpass 
                  qrs_amp_raw(Beat_C1) = y_i_t;                               % save amplitude of bandpass 
                  SIG_LEV1 = 0.25*y_i_t + 0.75*SIG_LEV1;                      % when found with the second thres 
               end
               
               not_nois = 1;
               SIG_LEV = 0.25*pks_temp + 0.75*SIG_LEV ;                       % when found with the second threshold             
             end             
          else
              not_nois = 0;         
          end
    end
  
    %% ===================  find noise and QRS peaks ================== %%
    if pks(i) >= THR_SIG      
      % ------ if No QRS in 360ms of the previous QRS See if T wave ------%
       if Beat_C >= 3
          if (locs(i)-qrs_i(Beat_C)) <= round(0.3600*fs)
              Slope1 = mean(diff(ecg_m(locs(i)-round(0.075*fs):locs(i))));       % mean slope of the waveform at that position
              Slope2 = mean(diff(ecg_m(qrs_i(Beat_C)-round(0.075*fs):qrs_i(Beat_C)))); % mean slope of previous R wave
              if abs(Slope1) <= abs(0.5*(Slope2))                              % slope less then 0.5 of previous R
                 Noise_Count = Noise_Count + 1;
                 nois_c(Noise_Count) = pks(i);
                 nois_i(Noise_Count) = locs(i);
                 skip = 1;                                                 % T wave identification
                 % ----- adjust noise levels ------ %
                 NOISE_LEV1 = 0.125*y_i + 0.875*NOISE_LEV1;
                 NOISE_LEV = 0.125*pks(i) + 0.875*NOISE_LEV; 
              else
                 skip = 0;
              end
            
           end
        end
        %---------- skip is 1 when a T wave is detected -------------- %
        if skip == 0    
          Beat_C = Beat_C + 1;
          qrs_c(Beat_C) = pks(i);
          qrs_i(Beat_C) = locs(i);
        
        %--------------- bandpass filter check threshold --------------- %
          if y_i >= THR_SIG1  
              Beat_C1 = Beat_C1 + 1;
              if ser_back 
                 qrs_i_raw(Beat_C1) = x_i;                                 % save index of bandpass 
              else
                 qrs_i_raw(Beat_C1)= locs(i)-round(0.150*fs)+ (x_i - 1);   % save index of bandpass 
              end
              qrs_amp_raw(Beat_C1) =  y_i;                                 % save amplitude of bandpass 
              SIG_LEV1 = 0.125*y_i + 0.875*SIG_LEV1;                       % adjust threshold for bandpass filtered sig
          end
         SIG_LEV = 0.125*pks(i) + 0.875*SIG_LEV ;                          % adjust Signal level
        end
              
    elseif (THR_NOISE <= pks(i)) && (pks(i) < THR_SIG)
         NOISE_LEV1 = 0.125*y_i + 0.875*NOISE_LEV1;                        % adjust Noise level in filtered sig
         NOISE_LEV = 0.125*pks(i) + 0.875*NOISE_LEV;                       % adjust Noise level in MVI       
    elseif pks(i) < THR_NOISE
        Noise_Count = Noise_Count + 1;
        nois_c(Noise_Count) = pks(i);
        nois_i(Noise_Count) = locs(i);    
        NOISE_LEV1 = 0.125*y_i + 0.875*NOISE_LEV1;                         % noise level in filtered signal    
        NOISE_LEV = 0.125*pks(i) + 0.875*NOISE_LEV;                        % adjust Noise level in MVI     
    end
               
    %% ================== adjust the threshold with SNR ============= %%
    if NOISE_LEV ~= 0 || SIG_LEV ~= 0
        THR_SIG = NOISE_LEV + 0.25*(abs(SIG_LEV - NOISE_LEV));
        THR_NOISE = 0.5*(THR_SIG);
    end
    
    %------ adjust the threshold with SNR for bandpassed signal -------- %
    if NOISE_LEV1 ~= 0 || SIG_LEV1 ~= 0
        THR_SIG1 = NOISE_LEV1 + 0.25*(abs(SIG_LEV1 - NOISE_LEV1));
        THR_NOISE1 = 0.5*(THR_SIG1);
    end
    
    
%--------- take a track of thresholds of smoothed signal -------------%
SIGL_buf(i) = SIG_LEV;
NOISL_buf(i) = NOISE_LEV;
THRS_buf(i) = THR_SIG;

%-------- take a track of thresholds of filtered signal ----------- %
SIGL_buf1(i) = SIG_LEV1;
NOISL_buf1(i) = NOISE_LEV1;
THRS_buf1(i) = THR_SIG1;
% ----------------------- reset parameters -------------------------- % 
skip = 0;                                                   
not_nois = 0; 
ser_back = 0;    
end
%% ======================= Adjust Lengths ============================ %%
qrs_i_raw = qrs_i_raw(1:Beat_C1);
qrs_amp_raw = qrs_amp_raw(1:Beat_C1);
qrs_c = qrs_c(1:Beat_C);
qrs_i = qrs_i(1:Beat_C);

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

for m=1:length(qrs_i_raw)
    %Busca el máximo y lo que registra en la posición
    [Rpks(m) Rindex(m)]=max(ecgs(qrs_i_raw(m)-5:qrs_i_raw(m)+5));
    Rindex(m)=Rindex(m)+qrs_i_raw(m)-6;
end

% %%Para detectar los Puntos R en los PVC
% for c=1:length(Rindex)-1
%     [maxt maxtind]=max(ecgs(Rindex(c):Rindex(c+1)));
%     [minR minRind]=min(ecgs(Rindex(c):Rindex(c)+maxtind-1));
%     %Cuando se tiene un punto R que a su derecha tiene un minimo muy
%     %negativo y un maximo mayor al punto R, el minimo antes mencionado se
%     %reconoce como punto R
%     
%     if(maxt>ecgs(Rindex(c))&&-minR>ecgs(Rindex(c)))
%         Rindex(c)=minRind+Rindex(c)-1;
%     end
%      
% end

%% Detección de los puntos S
R_len= length(Rindex);               %Cantidad de picos R encontrados
%El rango de busqueda en milisegundos va a cambiar para cada punto R.
%Los pulsos están muy juntos este factor va a disminuir el rango de
%búsqueda
rango = round(fs*0.15);
for j = 1:R_len                                   %Por cada pico:
    IR1 = Rindex(j);                                   %Número de muestra en la que ocurre el pico R
    Found = 0;                                          %Pico no encontrado (condición inicial)
    for i = IR1 : IR1 + rango                           %De la muestra IR1 busca 150ms
        if (1 < i) && (i < length(ecgs)) && (Found == 0)%15000
            if((ecgs(Rindex(j)) < 0) && (ecgs(i) > ecgs(i-1)) && (ecgs(i) > ecgs(i+1)))
                S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
                S_amp_ECG(j) = ecgs(i);              %Puntos S (sobre la curva ECG acondicionada)
                Found = 1;                              %Pico encontrado, no continua con búsqueda
            elseif ((ecgs(i) < ecgs(i+1)) && (ecgs(i) < ecgs(i-1))) %| (i == IR1 + rango)  %Busca (en unas 7 muestras adelante) si es menor entre dos puntos adyacentes (pico negativo correspondiente a S), derecha e izquierda
                if(Rindex(j) == i)
                else
                    S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
                    S_amp_ECG(j) = ecgs(i);              %Puntos S (sobre la curva ECG acondicionada)
                    Found = 1;                              %Pico encontrado, no continua con búsqueda
                end
                 
            elseif (i==IR1 + rango) && (Found==0)
                S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
                S_amp_ECG(j) = ecgs(i);              %Puntos S (sobre la curva ECG acondicionada)
                Found = 1;                              %Pico encontrado, no continua con búsqueda      
            end
        elseif (i == 0) || (i == length(ecgs))
            S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
            S_amp_ECG(j) = ecgs(i);      %Puntos S (sobre la curva ECG acondicionada)
        end
    end
end
%Gráfica
%La base X del tiempo
S_t=(1:length(ecgs))/360;
% fprintf(1,'Picos S  detectados: %2.0f \n', length(S_index))

%% Detección de los puntos Q
for j = 1:R_len                                                 %Cantidad de picos R encontrados
    IR1 = Rindex(j);                                           %Por cada pico R encontrado, dado por su número de muestra:
    %buscas 60 ms hacia atras
    rango = round(fs*0.15);
    Found_Q = 0;                                                %Punto Q no encontrado (al inicio)
    Q_amp_ECG(j)=2;
    %Son los puntos donde estan los picos R
    for i = IR1 : -1 : IR1 - rango                              %Busca unas 7 muestras hacia atraz SE AMPLIO RANGO AL TRIPLE, DE 0.03 A 0.09
        %Se inicia i en IR+2 pues con solo IR se genera error de índice
        if (i < length(ecgs)) && (i > 1)
            if(ecgs(Rindex(j)) < 0 && ecgs(i) > ecgs(i+1) && ecgs(i) > ecgs(i-1))
                Q_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                Q_amp_ECG(j) = ecgs(i);
                Found_Q = 1;
            elseif  ((ecgs(i) <= ecgs(i+1)) && (ecgs(i)<= ecgs(i-1))&&ecgs(i)<Q_amp_ECG(j))%&&(Found_Q ==0)) %| (i == rango)     %Busca la menor muestra en las 7 muestras y que corresponde al Q (ubicado a la izquierda del R respectivo
                if(Rindex(j) == i)
                    
                else              
                    Q_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                    Q_amp_ECG(j) = ecgs(i);                      %Puntos S (sobre la curva ECG acondicionada)
                    Found_Q = 1;                                    %Punto Q encontrado
                end
 
            end
            
        elseif ((i == 1) || (i == length(ecgs))) && (Found_Q ==0)
            Q_index(j)= i+1;                                  %Guarda el número de muestra en el que ocurre el pico S
            Q_amp_ECG(j) = ecgs(i+1);                      %Puntos S (sobre la curva ECG acondicionada)
            Found_Q = 1;                                    %Punto Q encontrado
        end
    end
    
    if Found_Q == 0                                              %Si no encuentra punto Q, lo asume a la mitad del rango de búsqueda
        ii = i - round(rango/2);
        if ii <= 0
            ii =1;
        end
        Q_index(j)= ii;                                  %Guarda el número de muestra en el que ocurre el pico Q
        Q_amp_ECG(j) = ecgs(ii);                      %Puntos S (sobre la curva ECG acondicionada)
    end
    
%     [qm qmi]=min(ecgs(Q_index(j):Rindex(j)));
%     if(qm<Q_amp_ECG(j))
%         Q_index(j)= Q_index(j)+qmi-1;                                  %Guarda el número de muestra en el que ocurre el pico S
%         Q_amp_ECG(j) = qm;                      %Puntos S (sobre la curva ECG acondicionada)
%     end
    
end

% fprintf(1,'Picos Q  detectados: %2.0f \n', length(Q_index))

%% Detección de los puntos K                                  %Similar al punto J
Q_len = length(Q_index);                                   %Busca unos 30ms antes del Q, que la señal se haga cero o positiva
HRm=Rindex(2)-Rindex(1);
%Si el HRM que es el RR si el ritmo cardiaco es muy alto el rango de
%busqueda disminuye y si el ritmo cardiaco es muy bajo el rango de busqueda
%aumenta
HRm=60/(HRm/fs);
for j = 1:Q_len
    IQ1 = Q_index(j);
    foundk = 0;
    
    i = IQ1;
    %A partir del punto Q hacia atras busca se cruza en 0 y ese punto o el
    %mas cercano lo define como K
    while (i > 0) && (i > (IQ1- (round(fs*0.06*(75/HRm)))))
        if  ecgs(i) >= 0
            K_index(j) = i;                              %Almacena número de muestra en que se encuentra el K
            foundk = 1;                                  %En caso encuentre el punto
            K_amp_ECG(j) = ecgs(i);                      %Puntos S (sobre la curva ECG acondicionada)
            break
        end
        i = i - 1;
    end
    
    if foundk == 0                                          %En caso no encuentre el punto, toma el punto extremo del rango
        K_index(j)=i+1;
        K_amp_ECG(j) = ecgs(i+1);                        %Puntos S (sobre la curva ECG acondicionada)
    end
    if(j+1<=length(qrs_i_raw))
        HRm=Rindex(j+1)-Rindex(j);
        HRm=60/(HRm/fs);
    end
end


%Hallando el Q_on
Q_len = length(Q_index);                                   %Busca unos 30ms antes del Q, que la señal se haga cero o positiva
HRm=Rindex(2)-Rindex(1);
%Si el HRM que es el RR si el ritmo cardiaco es muy alto el rango de
%busqueda disminuye y si el ritmo cardiaco es muy bajo el rango de busqueda
%aumenta
%HRm=60/(HRm/fs);
for j = 1:Q_len
    IQ1 = Q_index(j);
    %buscas 60 ms hacia atras
    rango = round(fs*0.07);
    Found_Q = 0;                                                %Punto Q no encontrado (al inicio)
    QOn_amp_ECG(j)=2;
    %Son los puntos donde estan los picos R
    for i = IQ1 : -1 : IQ1 - rango                              %Busca unas 7 muestras hacia atraz SE AMPLIO RANGO AL TRIPLE, DE 0.03 A 0.09
        %Se inicia i en IR+2 pues con solo IR se genera error de índice
        if (i < length(ecgs)) && (i > 1)
            if  ((ecgs(i) >= ecgs(i+1)) && (ecgs(i)>= ecgs(i-1))&&ecgs(i)<QOn_amp_ECG(j))%&&(Found_Q ==0)) %| (i == rango)     %Busca la menor muestra en las 7 muestras y que corresponde al Q (ubicado a la izquierda del R respectivo
                if(Q_index(j) == i)
                    
                    %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
                else              
                    QOn_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                    QOn_amp_ECG(j) = ecgs(i);                      %Puntos S (sobre la curva ECG acondicionada)
                    Found_Q = 1;            %Punto Q encontrado
                    %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
                end
 
            end
            
        elseif ((i == 1) || (i == length(ecgs))) && (Found_Q ==0)
            QOn_index(j)= i+1;                                  %Guarda el número de muestra en el que ocurre el pico S
            QOn_amp_ECG(j) = ecgs(i+1);                      %Puntos S (sobre la curva ECG acondicionada)
            Found_Q = 1;                                    %Punto Q encontrado
            %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
           
        end
    end
    
    if Found_Q == 0                                              %Si no encuentra punto Q, lo asume a la mitad del rango de búsqueda
        ii = Q_index(j) - round(rango/2);
            if ii <= 0
                ii =1;
            end
            QOn_index(j)= ii;                                  %Guarda el número de muestra en el que ocurre el pico Q
            QOn_amp_ECG(j) = ecgs(ii);                      %Puntos S (sobre la curva ECG acondicionada)
        %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
        
    end
    %disp(QOn_index(j));
end
    
%     [qm qmi]=min(ecgs(Q_index(j):Rindex(j)));
%     if(qm<Q_amp_ECG(j))
%         Q_index(j)= Q_index(j)+qmi-1;                                  %Guarda el número de muestra en el que ocurre el pico S
%         Q_amp_ECG(j) = qm;                      %Puntos S (sobre la curva ECG acondicionada)
%     end
    
end