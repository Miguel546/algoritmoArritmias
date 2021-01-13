function [ecg, ecgs, Rindex, Q_index, QOn_index, S_index, K_index, anotacion, locs, ecg_hplot, ecg_dplot, ecg_splot, ecg_mplot, qrs_i, qrs_c, NOISL_buf, SIGL_buf, THRS_buf, qrs_i_raw,qrs_amp_raw, NOISL_buf1, SIGL_buf1, THRS_buf1] = detectarPuntoR(conexionBD, registromit, numero, fs, gr)
load(strcat('registro/',registromit));
load('queriesAnotaciones');
anotacionRegistro = queries(numero - 1);

ecg = val;
ecg = ecg(:);
setappdata(0, 'ecg', ecg);
anotacion = select(conexionBD, anotacionRegistro);
assignin('base','anotacionRegistro',anotacionRegistro);
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
ecg_d = conv (ecg_h ,h_d);
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

%Estos picos estan en la señal de integracion y en la misma posicion de la
%señal de filtrado a la misma altura ahí cerca hay un pico R


%% inicializar la fase de entrenamiento (2 segundos de la señal) para determinar el UMB_SEN y el UMB_RUIDO
%Las detecciones no van a ser correctas podría haber error. Si se esta
%cogiendo los umbrales los niveles de señal y ruido podría ser que en esos
%dos segundos no se detecte bien un QRS

%Hallar máximos 360 Hz, 360 muestras en un segundo en los dos primeros
%segundos vaya a los máximos y a ese máximo lo multiplicas por 1/3 y ese va
%a ser el valor inicial del umbral para la señal

%ecg_ventmov desde la muestra 1 hasta la muestra 720 va a encontrar el máximo los
%dos primeros segundos de la muestra halla el máximo. El máximo pico entre 3 es
%el umbral por eso es una fase de aprendizaje
%Los dos primeros segundos
%el primer umbral es el de la señal para la señal de la ventana movil tiene un umbral que cambia con el tiempo
%esto de aqui es el primer valor del umbral
%Ocurre en la señal de integracion
UMBRAL_SENAL = max(ecg_m(1:2*fs))*1/3; % 0.33 de la max amplitud
%Para el umbral de ruido en los dos primeros segundos va a hallar el promedio y lo multiplica * 1/2
UMBRAL_RUIDO = mean(ecg_m(1:2*fs))*1/2; % 0.5 de la maxima señal considerada por el ruido


%El valor inicial del nivel de la señal es igual al nivel del umbral de la
%señal
%Nivel de la señal es el umbral de la señal de integracion
NIVEL_SENAL= UMBRAL_SENAL;
%%El valor inicial del nivel del ruido es igual al nivel del umbral del
%%ruido

%Va a ser el umbral para el ruido que lo va a usar después

%Señal filtrada con la señal de integración
NIVEL_RUIDO = UMBRAL_RUIDO;

%% inicializa el umbral de señal para la señal filtrada
UMBRAL_SENAL1 = max(ecg_h(1:2*fs))*1/3; % 0.25 of the max amplitude
%inicializa umbral para el ruido
UMBRAL_RUIDO1 = mean(ecg_h(1:2*fs))*1/2;
%nivel de señal para la señal filtrada
NIVEL_SENAL1 = UMBRAL_SENAL1; % Signal level in Bandpassed filter
%nivel de ruido para la señal filtrada
NIVEL_RUIDO1 = UMBRAL_RUIDO1; % Noise level in Bandpassed filter
%% Umbrales y reglas de decision
for i = 1 : length(pks)
    
    %% con los picos en la señal de integracion y un ancho de 150 ms se busca un maximo en la señal filtrada
    %locs(i) es la posicion del pico en la señal de integracion
    if locs(i)-round(0.150*fs)>= 1 && locs(i)<= length(ecg_h)
        [y_i x_i] = max(ecg_h(locs(i)-round(0.150*fs):locs(i)));
    else
        if i == 1
            %Es la posicion del pico en la señal de integracion
            %Del pico 1 al pico 2 minimo hay 200 ms entonces si estas en
            %el pico 2 y retrocedes 150 ms vas a tener una muestra >=1
            %entonces vas a entrar en el caso de arriba que dice igual
            %que 1
            [y_i x_i] = max(ecg_h(1:locs(i)));
            %Vale 0 o 1
            %Aca le da un valor pero lo utiliza mas adelante
            ser_back = 1;
        elseif locs(i)>= length(ecg_h)
            %Si es que es el ultimo
            [y_i x_i] = max(ecg_h(locs(i)-round(0.150*fs):end));
        end
        
    end
    
    %% Actualizacion del ritmo cardiaco
    if length(qrs_c) >= 9
        %El diff halla la diferencia en un vector de un punto
        diffRR = diff(qrs_i(end-8:end)); %calculate RR interval
        %El promedio de todo
        %El promedio1RR es el promedio de los últimos 8 RRs
        promedio1RR = mean(diffRR); % calculate the mean of 8 previous R waves interval
        
        %El último RR hallado
        comp =qrs_i(end)-qrs_i(end-1); %latest RR
        
        %Si no cumple estos límites se hace esto de aca
        %Los umbrales se disminuyen a la mitad
        if comp <= 0.92*promedio1RR || comp >= 1.16*promedio1RR
            %Si esta fuera del limite es considerado irregular
            % disminuye el umbral en la señal de integracion
            UMBRAL_SENAL = 0.5*(UMBRAL_SENAL);
            %UMBRAL_RUIDO = 0.5*(UMBRAL_SENAL);
            % disminuye el umbral en la señal de filtrado
            UMBRAL_SENAL1 = 0.5*(UMBRAL_SENAL1);
            %UMBRAL_RUIDO1 = 0.5*(UMBRAL_SENAL1);
            
        elseif(comp > 0.92*promedio1RR && comp < 1.16*promedio1RR)
            %Si esta fuera del limite es considerado regular
            %si es regular entonces el ultimo RR > 0.92 y el ultimo RR <
            %1.16 mean RR
            %Regla de decision para poder hallar el promedio2
            promedio2RR = promedio1RR; %si el promedio de los 8 ultimos RR es regular, el promedio 1 es igual al promedio 2
        end
        
    end
    
    %%calcular el promedio de las 8 ultimas ondas R para hacerse seguro de
    %que el QRS no esta faltando
    %Si es que el R no es detectado entonces se activa la busqueda hacia
    %atras y hay 1.66*meanRR
    %RR missed limit
    %en test_m esta el RR promedio, si el ritmo es regular se usa
    %selected RR, sino solo se usa el promedio general
    if promedio2RR %Si es que tiene un valor diferente de 0
        test_m = promedio2RR; %si el intervalo RR es regular entonces usalo
    elseif promedio1RR && promedio2RR == 0 %
        test_m = promedio1RR; %test_m = promedio1RR el mean RR es el promedio de los ultimos 8 RR
    else
        test_m =0; %Esto sucede cuando no hay promedio 1 ni 2
    end
    
    %si ya hay latidos
    if test_m
        %si no se halla un punto rr mas alla del limite de tiempo, se hace
        %una busqueda hacia atras de 200 ms.
        
        %los picos de la ventana de integracion
        %qrs_i(end) senal de integracion locs(i) es el pico que estas
        %analizando y qrs_i(end) es el ultimo pico descubierto
        if (locs(i) - qrs_i(end)) >= round(1.66*test_m)% i
            [pks_temp,locs_temp] = max(ecg_m(qrs_i(end)+ round(0.200*fs):locs(i)-round(0.200*fs))); % busqueda hacia atras y localizacion del maximo en este intervalo
            %posicion con respecto al primer punto del intervalo de busqueda
            %El primer punto del intervalo de busqueda es qrs_i(end) +
            %La muestra 1000 lo va a tomar como si fuera 1 y el locs_temp es 1010 lo que va a pasar en
            %esa linea el locs_temp no va a valer 1010 va a valer 11 esto
            %lo va a tomar como si fuera 1
            %El pico temporal lo localiza con respecto con respecto al qrs_i end y el locs temp va a valer la distancia en muestras al qrs_i_end
            %La distancia del pico que has encontrado hasta el qrs_i_end
            locs_temp = qrs_i(end)+ round(0.200*fs) + locs_temp -1; %location
            %si el pico hallado es mayor que el umbral de ruido, puede ser pico R
            %en la señal de integracion
            %Fase de entrenamiento el valor del threshold noise va
            %cambiando si el pico temporal del umbral para el ruido es
            %mayor al umbral del ruido entonces se lo guarda como pico QRS
            %no se lo considera como pico QRS todavia
            %pks_temp estan en la senal de integracion
            if pks_temp > UMBRAL_RUIDO
                %graba el pico
                qrs_c = [qrs_c pks_temp];
                qrs_i = [qrs_i locs_temp];
                
                % hallar el pico en la señal filtrada
                % locs_temp localizacion temporal
                % el locs_temp estan en la senal de integracion
                if locs_temp <= length(ecg_h)
                    % la senal del filtado corre hacia la izquierda 150ms
                    [y_i_t x_i_t] = max(ecg_h(locs_temp-round(0.150*fs):locs_temp));
                else
                    %Compara el pico de locs_temp y el final hasta el final de la senal
                    %filtada
                    [y_i_t x_i_t] = max(ecg_h(locs_temp-round(0.150*fs):end));
                end
                
                % si el pico de la señal filtrada es mayor al umbral, es
                % pico R busqueda hacia atras solo en esta situacion lo hace
                % asi y_i_t es la senal del filtrado
                if y_i_t > UMBRAL_RUIDO1
                    %se guarda la posicion y amplitud del picoR,
                    qrs_i_raw = [qrs_i_raw locs_temp-round(0.150*fs)+ (x_i_t - 1)];% guarda el indice del filtro pasabanda
                    qrs_amp_raw =[qrs_amp_raw y_i_t]; %save amplitude of bandpass
                    %Regla SPKF = 0.25 PEAKF + 0.75 SPKF
                    NIVEL_SENAL1 = 0.25*y_i_t + 0.75*NIVEL_SENAL1; %actualiza nivel de señal filtrada
                end
                %Hay ruido y todo esta bien
                not_nois = 1;
                %Nivel de la senal de integracion
                NIVEL_SENAL = 0.25*pks_temp + 0.75*NIVEL_SENAL ;  %when found with the second threshold
            end
            
        else
            %No hay ruido y todo esta bien
            %No te has salteado un QRS
            not_nois = 0;
            
        end
    end
    %% Hallar el ruido y los picos QRS
    %Los picos qrs son mayores al umbral de senal de integracion
    if pks(i) >= UMBRAL_SENAL
        % si el if es un candidato QRS ocurre con 360ms del anterior QRS
        % el algoritmo determina si es una onda T o si es una QRS
        if length(qrs_c) >= 3
            if (locs(i)-qrs_i(end)) <= round(0.3600*fs)
                %Pendiente de la onda que estas analizando ahora
                Pendiente1 = mean(diff(ecg_m(locs(i)-round(0.075*fs):locs(i)))); %mean slope of the waveform at that position
                %Pendiente del R anterior
                Pendiente2 = mean(diff(ecg_m(qrs_i(end)-round(0.075*fs):qrs_i(end)))); %mean slope of previous R wave
                
                if abs(Pendiente1) <= abs(0.5*(Pendiente2))  % slope less then 0.5 of previous R
                    %El ruido es la onda T
                    nois_c = [nois_c pks(i)];
                    nois_i = [nois_i locs(i)];
                    skip = 1; % T wave identification
                    % adjust noise level in both filtered and
                    % MVI
                    %Actualiza los niveles de ruido.
                    NIVEL_RUIDO1 = 0.125*y_i + 0.875*NIVEL_RUIDO1;
                    NIVEL_RUIDO = 0.125*pks(i) + 0.875*NIVEL_RUIDO;
                else
                    skip = 0;
                end
                
            end
        end
        
        if skip == 0  % cuando es 1 se detecta una onda T
            %En este caso no se detecta onda T y se guarda al qrs_c y qrs_i
            qrs_c = [qrs_c pks(i)];
            qrs_i = [qrs_i locs(i)];
            
            %filtro pasabanda umbral chequear si el pico es mayor que el umbral
            %Si el el pico de la senal filtrada es mayor que el umbral
            if y_i >= UMBRAL_SENAL1
                if ser_back
                    qrs_i_raw = [qrs_i_raw x_i];  % guarda el indice de la senal del filtrado
                else
                    qrs_i_raw = [qrs_i_raw locs(i)-round(0.150*fs)+ (x_i - 1)];% guarda el indice de la senal del filtrado
                end
                qrs_amp_raw =[qrs_amp_raw y_i];% guardar amplitud del pasabanda
                NIVEL_SENAL1 = 0.125*y_i + 0.875*NIVEL_SENAL1;% ajustar el nivel de senal del filtado
            end
            
            %ajustar nivel de la senal
            NIVEL_SENAL = 0.125*pks(i) + 0.875*NIVEL_SENAL ;
        end
        
        
    elseif UMBRAL_RUIDO <= pks(i) && pks(i)<UMBRAL_SENAL
        %Si el nivel del umbral del ruido es menor al pico i y el nivel de
        %la senal es menor al nivel de la senal
        %ajustar el nivel del ruido en la senal filtrada
        NIVEL_RUIDO1 = 0.125*y_i + 0.875*NIVEL_RUIDO1;
        %ajustar el nivel del ruido en la ventana movil de integracion
        NIVEL_RUIDO = 0.125*pks(i) + 0.875*NIVEL_RUIDO;
        
    elseif pks(i) < UMBRAL_RUIDO
        %Si es menor al umbral del ruido simplemente lo guarda como un
        %vector del ruido
        nois_c = [nois_c pks(i)];
        nois_i = [nois_i locs(i)];
        
        % nivel de la senal en la senal filtrada
        NIVEL_RUIDO1 = 0.125*y_i + 0.875*NIVEL_RUIDO1;
        %end
        
        % nivel de ruido ajustado en la ventana de integracion
        NIVEL_RUIDO = 0.125*pks(i) + 0.875*NIVEL_RUIDO;
        
    end
    
    %% adjust the threshold with SNR
    %ajustar el umbral entre la senal el ruido y la senal de integracion
    if NIVEL_RUIDO ~= 0 || NIVEL_SENAL ~= 0
        UMBRAL_SENAL = NIVEL_RUIDO + 0.25*(abs(NIVEL_SENAL - NIVEL_RUIDO));
        UMBRAL_RUIDO = 0.5*(UMBRAL_SENAL);
    end
    
    % ajustar el umbral de la relacion entre la senal y el ruido
    if NIVEL_RUIDO1 ~= 0 || NIVEL_SENAL1 ~= 0
        UMBRAL_SENAL1 = NIVEL_RUIDO1 + 0.25*(abs(NIVEL_SENAL1 - NIVEL_RUIDO1));
        UMBRAL_RUIDO1 = 0.5*(UMBRAL_SENAL1);
    end
    
    
    % toma los valores de la senal integracion
    SIGL_buf = [SIGL_buf NIVEL_SENAL];
    NOISL_buf = [NOISL_buf NIVEL_RUIDO];
    THRS_buf = [THRS_buf UMBRAL_SENAL];
    
    % toma los valores de la senal filtrada
    SIGL_buf1 = [SIGL_buf1 NIVEL_SENAL1];
    NOISL_buf1 = [NOISL_buf1 NIVEL_RUIDO1];
    THRS_buf1 = [THRS_buf1 UMBRAL_SENAL1];
    
    skip = 0; %reset parameters
    not_nois = 0; %reset parameters
    ser_back = 0;  %reset bandpass param
end

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

%%Para detectar los Puntos R en los PVC
for c=1:length(Rindex)-1
    [maxt maxtind]=max(ecgs(Rindex(c):Rindex(c+1)));
    [minR minRind]=min(ecgs(Rindex(c):Rindex(c)+maxtind-1));
    %Cuando se tiene un punto R que a su derecha tiene un minimo muy
    %negativo y un maximo mayor al punto R, el minimo antes mencionado se
    %reconoce como punto R
    
    if(maxt>ecgs(Rindex(c))&&-minR>ecgs(Rindex(c)))
        Rindex(c)=minRind+Rindex(c)-1;
    end
     
end

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
                    disp('Q_index(j) == i');
                    disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
                else              
                    QOn_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                    QOn_amp_ECG(j) = ecgs(i);                      %Puntos S (sobre la curva ECG acondicionada)
                    Found_Q = 1;            %Punto Q encontrado
                    disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
                end
 
            end
            
        elseif ((i == 1) || (i == length(ecgs))) && (Found_Q ==0)
            QOn_index(j)= i+1;                                  %Guarda el número de muestra en el que ocurre el pico S
            QOn_amp_ECG(j) = ecgs(i+1);                      %Puntos S (sobre la curva ECG acondicionada)
            Found_Q = 1;                                    %Punto Q encontrado
            disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
           
        end
    end
    
    if Found_Q == 0                                              %Si no encuentra punto Q, lo asume a la mitad del rango de búsqueda
        ii = Q_index(j) - round(rango/2);
            if ii <= 0
                ii =1;
            end
            QOn_index(j)= ii;                                  %Guarda el número de muestra en el que ocurre el pico Q
            QOn_amp_ECG(j) = ecgs(ii);                      %Puntos S (sobre la curva ECG acondicionada)
        disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecgs(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecgs(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecgs(i+1))));
        
    end
    disp(QOn_index(j));
end
    
%     [qm qmi]=min(ecgs(Q_index(j):Rindex(j)));
%     if(qm<Q_amp_ECG(j))
%         Q_index(j)= Q_index(j)+qmi-1;                                  %Guarda el número de muestra en el que ocurre el pico S
%         Q_amp_ECG(j) = qm;                      %Puntos S (sobre la curva ECG acondicionada)
%     end
    
end