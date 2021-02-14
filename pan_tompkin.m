function [ecg, Rindex, Q_index, QOn_index, S_index, K_index, anotacion, locs, ecg_h, ecg_d, ecg_s, ecg_m, qrs_i, qrs_c, NOISL_buf, SIGL_buf, THRS_buf, qrs_i_raw,qrs_amp_raw, NOISL_buf1, SIGL_buf1, THRS_buf1]=pan_tompkin(conexionBD, registromit, numero, fs, gr)
load(strcat('registro/',registromit));
load('queriesAnotaciones');
anotacionRegistro = queries(numero - 1);
anotacion = select(conexionBD, anotacionRegistro);
assignin('base','anotacionRegistro',anotacionRegistro);
ecg = val;

ecg = ecg(:); % vectorizar

%Inicializar
delay = 0;
skip = 0;                                                                  % toma el valor de 1 cuando la onda T es detectada
m_selected_RR = 0;
mean_RR = 0;
ser_back = 0; 
ax = zeros(1,6);

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
 ecg_h = filtfilt(a,b,ecg);
 ecg_h = ecg_h/ max( abs(ecg_h));

%% Derivación
% H(z) = (1/8T)(-z^(-2) - 2z^(-1) + 2z + z^(2))
    b = [1 2 0 -2 -1].*(1/8)*fs;   


 ecg_d = filtfilt(b,1,ecg_h);
 ecg_d = ecg_d/max(ecg_d);

%% Elevando al cuadrado
 ecg_s = ecg_d.^2;

%% Ventana de integración
% Y(nt) = (1/N)[x(nT-(N - 1)T)+ x(nT - (N - 2)T)+...+x(nT)]
ecg_m = conv(ecg_s ,ones(1 ,round(0.150*fs))/round(0.150*fs));
delay = delay + round(0.150*fs)/2;

%% Marca fiducial
% Nota : una distancia minima de 72 muestras (por 360 Hz) es considerada entre cada onda
% R desde el punto fisiologico de la vista RR no puede ser menor a 200 ms
% De la ventana de integracion va a hallar los picos maximos y sus
% localizaciones esta poniendo como condición que la distancia minima entre
% los picos sea 200 ms
%picos, localización
%Te da los picos y los indices
[pks,locs] = findpeaks(ecg_m,'MINPEAKDISTANCE',round(0.2*fs));
%% Inicializar otros parámetros
LLp = length(pks);
% Almacena QRS de la señal y la señal filtrada
qrs_c = zeros(1,LLp);           % amplitud de R
qrs_i = zeros(1,LLp);           % indice
qrs_i_raw = zeros(1,LLp);       % amplitud de R
qrs_amp_raw= zeros(1,LLp);      % indice
% buffers ruido
nois_c = zeros(1,LLp);
nois_i = zeros(1,LLp);
% Buffers para la señal y el ruido
SIGL_buf = zeros(1,LLp);
NOISL_buf = zeros(1,LLp);
SIGL_buf1 = zeros(1,LLp);
NOISL_buf1 = zeros(1,LLp);
THRS_buf1 = zeros(1,LLp);
THRS_buf = zeros(1,LLp);


%% inicializar la fase de entrenamiento (2 segundos de la señal) para determinar el THR_SIG y THR_NOISE
THR_SIG = max(ecg_m(1:2*fs))*1/3;                                          % 0.33 de la max amplitud 
THR_NOISE = mean(ecg_m(1:2*fs))*1/2;                                       % 0.5 de la maxima señal considerada por el ruido
SIG_LEV= THR_SIG;
NOISE_LEV = THR_NOISE;


%% inicializa el umbral de señal para la señal filtrada (2 segundos de la señal filtrada)
THR_SIG1 = max(ecg_h(1:2*fs))*1/3;                                          % 0.33 de la max amplitud 
THR_NOISE1 = mean(ecg_h(1:2*fs))*1/2; 
SIG_LEV1 = THR_SIG1;                                                        % Nivel de la señal en el filtro pasabanda
NOISE_LEV1 = THR_NOISE1;                                                    % Nivel del urido en el filtro pasabanda
%% Umbrales y la regla de decisión %%
Beat_C = 0;                                                                 % Raw Beats
Beat_C1 = 0;                                                                % Filtered Beats
Noise_Count = 0;                                                            % Noise Counter
for i = 1 : LLp  
   %% Localizando los picos corresponidentes a la señal filtrada
   % con los picos en la señal de integracion y un ancho de 150 ms se busca un maximo en la señal filtrada
   % locs(i) es la posicion del pico en la señal de integracion
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
  %% Actualizacion del ritmo cardiaco 
    if Beat_C >= 9        
        diffRR = diff(qrs_i(Beat_C-8:Beat_C));                                   % calcular el intervalo RR
        mean_RR = mean(diffRR);                                            % calcular el promedio de los 8 previos picos R
        comp =qrs_i(Beat_C)-qrs_i(Beat_C-1);                                     % ultimo RR
    
        if comp <= 0.92*mean_RR || comp >= 1.16*mean_RR
            %Si esta fuera del limite es considerado irregular
            % disminuye el umbral en la señal de integracion
                THR_SIG = 0.5*(THR_SIG);
                THR_SIG1 = 0.5*(THR_SIG1);               
        else
            m_selected_RR = mean_RR;                                       % The latest regular beats mean
        end 
          
    end
    
 %%calcular el promedio de las 8 ultimas ondas R para hacerse seguro de que el QRS no esta faltando
       if m_selected_RR
           test_m = m_selected_RR;                                         %si el intervalo RR es regular entonces usalo 
       elseif mean_RR && m_selected_RR == 0
           test_m = mean_RR;   
       else
           test_m = 0;
       end
        
    if test_m
          if (locs(i) - qrs_i(Beat_C)) >= round(1.66*test_m)                  % muesta a un R perdido 
              [pks_temp,locs_temp] = max(ecg_m(qrs_i(Beat_C)+ round(0.200*fs):locs(i)-round(0.200*fs))); % buscar atras y mostrar el máximo intervalo R localizado
              locs_temp = qrs_i(Beat_C)+ round(0.200*fs) + locs_temp -1;      % localizado
             
              if pks_temp > THR_NOISE
               Beat_C = Beat_C + 1;
               qrs_c(Beat_C) = pks_temp;
               qrs_i(Beat_C) = locs_temp;      
              % Localizar en la señal filtrada
               if locs_temp <= length(ecg_h)
                  [y_i_t,x_i_t] = max(ecg_h(locs_temp-round(0.150*fs):locs_temp));
               else
                  [y_i_t,x_i_t] = max(ecg_h(locs_temp-round(0.150*fs):end));
               end
              % Umbral de la señal filtro pasabanda
               if y_i_t > THR_NOISE1 
                  Beat_C1 = Beat_C1 + 1;
                  qrs_i_raw(Beat_C1) = locs_temp-round(0.150*fs)+ (x_i_t - 1);% guardando indice de filtro pasabanda 
                  qrs_amp_raw(Beat_C1) = y_i_t;                               % guardanado la amplitud del filtro pasabanda 
                  SIG_LEV1 = 0.25*y_i_t + 0.75*SIG_LEV1;                      % cuando encuentras en el segundo umbral
               end
               
               not_nois = 1;
               SIG_LEV = 0.25*pks_temp + 0.75*SIG_LEV ;                       % cuando lo encuentras en el segundo umbral             
             end             
          else
              not_nois = 0;         
          end
    end
  
   %% Hallando ruido y picos QRS
    if pks(i) >= THR_SIG      
      % si el if es un candidato QRS ocurre con 360ms del anterior QRS
      % el algoritmo determina si es una onda T o si es una QRS
       if Beat_C >= 3
          if (locs(i)-qrs_i(Beat_C)) <= round(0.3600*fs)
              Slope1 = mean(diff(ecg_m(locs(i)-round(0.075*fs):locs(i))));       %Pendiente de la onda R que estas analizando ahora
              Slope2 = mean(diff(ecg_m(qrs_i(Beat_C)-round(0.075*fs):qrs_i(Beat_C)))); %Pendiente de la onda R anterior
              if abs(Slope1) <= abs(0.5*(Slope2))                              % Pendiente menor que 0.5 del anterior R
                 Noise_Count = Noise_Count + 1;
                 nois_c(Noise_Count) = pks(i);
                 nois_i(Noise_Count) = locs(i);
                 skip = 1;                                                 % Identificando onda T
                 % Ajustando niveles de ruido
                 NOISE_LEV1 = 0.125*y_i + 0.875*NOISE_LEV1;
                 NOISE_LEV = 0.125*pks(i) + 0.875*NOISE_LEV; 
              else
                 skip = 0;
              end
            
           end
        end
       % cuando es 1 se detecta una onda T
            %En este caso no se detecta onda T y se guarda al qrs_c y qrs_i
        if skip == 0    
          Beat_C = Beat_C + 1;
          qrs_c(Beat_C) = pks(i);
          qrs_i(Beat_C) = locs(i);
        
        %filtro pasabanda umbral chequear si el pico es mayor que el umbral
            %Si el el pico de la senal filtrada es mayor que el umbral
          if y_i >= THR_SIG1  
              Beat_C1 = Beat_C1 + 1;
              if ser_back 
                 qrs_i_raw(Beat_C1) = x_i;                                 % guarda el indice de la senal del filtrado 
              else
                 qrs_i_raw(Beat_C1)= locs(i)-round(0.150*fs)+ (x_i - 1);   % guarda el indice de la senal del filtrado 
              end
              qrs_amp_raw(Beat_C1) =  y_i;                                 % guarda el amplitud de la senal del filtrado
              SIG_LEV1 = 0.125*y_i + 0.875*SIG_LEV1;                       % ajustar el nivel de senal del filtado
          end
         SIG_LEV = 0.125*pks(i) + 0.875*SIG_LEV ;                          % ajustar el nivel de senal
        end
              
    elseif (THR_NOISE <= pks(i)) && (pks(i) < THR_SIG)
         NOISE_LEV1 = 0.125*y_i + 0.875*NOISE_LEV1;                        %ajustar el nivel del ruido en la senal filtrada
         NOISE_LEV = 0.125*pks(i) + 0.875*NOISE_LEV;                       %ajustar el nivel del ruido en la ventana movil de integracion      
    elseif pks(i) < THR_NOISE
        Noise_Count = Noise_Count + 1;
        nois_c(Noise_Count) = pks(i);
        nois_i(Noise_Count) = locs(i);    
        NOISE_LEV1 = 0.125*y_i + 0.875*NOISE_LEV1;                         %ajustar el nivel del ruido en la senal filtrada   
        NOISE_LEV = 0.125*pks(i) + 0.875*NOISE_LEV;                        %ajustar el nivel del ruido en la ventana movil de integracion    
    end
               
     %ajustar el umbral entre la senal el ruido y la senal de integracion
    if NOISE_LEV ~= 0 || SIG_LEV ~= 0
        THR_SIG = NOISE_LEV + 0.25*(abs(SIG_LEV - NOISE_LEV));
        THR_NOISE = 0.5*(THR_SIG);
    end
    
    % ajustar el umbral de la relacion entre la senal y el ruido para el
    % filtro pasabanda
    if NOISE_LEV1 ~= 0 || SIG_LEV1 ~= 0
        THR_SIG1 = NOISE_LEV1 + 0.25*(abs(SIG_LEV1 - NOISE_LEV1));
        THR_NOISE1 = 0.5*(THR_SIG1);
    end
    
    
 % toma los valores de la senal suavizada
SIGL_buf(i) = SIG_LEV;
NOISL_buf(i) = NOISE_LEV;
THRS_buf(i) = THR_SIG;

 % toma los valores de la senal filtrada
SIGL_buf1(i) = SIG_LEV1;
NOISL_buf1(i) = NOISE_LEV1;
THRS_buf1(i) = THR_SIG1;
% Resetear parámetros
skip = 0;                                                   
not_nois = 0; 
ser_back = 0;    
end
%% Ajustar medidas
qrs_i_raw = qrs_i_raw(1:Beat_C1);
qrs_amp_raw = qrs_amp_raw(1:Beat_C1);
qrs_c = qrs_c(1:Beat_C);
qrs_i = qrs_i(1:Beat_C);

%for m=1:length(qrs_i_raw)
    %Busca el máximo y lo que registra en la posición
%    [Rpks(m) Rindex(m)]=max(ecg(qrs_i_raw(m)-5:qrs_i_raw(m)+5));
%    Rindex(m)=Rindex(m)+qrs_i_raw(m)-6;
%end

% Para detectar los Puntos R en los PVC
%for c=1:length(Rindex)-1
%    [maxt maxtind]=max(ecg(Rindex(c):Rindex(c+1)));
%    [minR minRind]=min(ecg(Rindex(c):Rindex(c)+maxtind-1));
    %Cuando se tiene un punto R que a su derecha tiene un minimo muy
    %negativo y un maximo mayor al punto R, el minimo antes mencionado se
    %reconoce como punto R
    
%    if(maxt>ecg(Rindex(c))&&-minR>ecg(Rindex(c)))
%        Rindex(c)=minRind+Rindex(c)-1;
%    end
     
%end

Rindex = qrs_i_raw;
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
        if (1 < i) && (i < length(ecg)) && (Found == 0)%15000
            if((ecg(Rindex(j)) < 0) && (ecg(i) > ecg(i-1)) && (ecg(i) > ecg(i+1)))
                S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
                S_amp_ECG(j) = ecg(i);              %Puntos S (sobre la curva ECG acondicionada)
                Found = 1;                              %Pico encontrado, no continua con búsqueda
            elseif ((ecg(i) < ecg(i+1)) && (ecg(i) < ecg(i-1))) %| (i == IR1 + rango)  %Busca (en unas 7 muestras adelante) si es menor entre dos puntos adyacentes (pico negativo correspondiente a S), derecha e izquierda
                if(Rindex(j) == i)
                else
                    S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
                    S_amp_ECG(j) = ecg(i);              %Puntos S (sobre la curva ECG acondicionada)
                    Found = 1;                              %Pico encontrado, no continua con búsqueda
                end
                 
            elseif (i==IR1 + rango) && (Found==0)
                S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
                S_amp_ECG(j) = ecg(i);              %Puntos S (sobre la curva ECG acondicionada)
                Found = 1;                              %Pico encontrado, no continua con búsqueda      
            end
        elseif (i == 0) || (i == length(ecg))
            S_index(j)= i;                          %Guarda el número de muestra en el que ocurre el pico S
            S_amp_ECG(j) = ecg(i);      %Puntos S (sobre la curva ECG acondicionada)
        end
    end
end
%Gráfica
%La base X del tiempo
S_t=(1:length(ecg))/360;
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
        if (i < length(ecg)) && (i > 1)
            if(ecg(Rindex(j)) < 0 && ecg(i) > ecg(i+1) && ecg(i) > ecg(i-1))
                Q_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                Q_amp_ECG(j) = ecg(i);
                Found_Q = 1;
            elseif  ((ecg(i) <= ecg(i+1)) && (ecg(i)<= ecg(i-1))&&ecg(i)<Q_amp_ECG(j))%&&(Found_Q ==0)) %| (i == rango)     %Busca la menor muestra en las 7 muestras y que corresponde al Q (ubicado a la izquierda del R respectivo
                if(Rindex(j) == i)
                    
                else              
                    Q_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                    Q_amp_ECG(j) = ecg(i);                      %Puntos S (sobre la curva ECG acondicionada)
                    Found_Q = 1;                                    %Punto Q encontrado
                end
 
            end
            
        elseif ((i == 1) || (i == length(ecg))) && (Found_Q ==0)
            Q_index(j)= i+1;                                  %Guarda el número de muestra en el que ocurre el pico S
            Q_amp_ECG(j) = ecg(i+1);                      %Puntos S (sobre la curva ECG acondicionada)
            Found_Q = 1;                                    %Punto Q encontrado
        end
    end
    
    if Found_Q == 0                                              %Si no encuentra punto Q, lo asume a la mitad del rango de búsqueda
        ii = i - round(rango/2);
        if ii <= 0
            ii =1;
        end
        Q_index(j)= ii;                                  %Guarda el número de muestra en el que ocurre el pico Q
        Q_amp_ECG(j) = ecg(ii);                      %Puntos S (sobre la curva ECG acondicionada)
    end
    
%     [qm qmi]=min(ecg(Q_index(j):Rindex(j)));
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
        if  ecg(i) >= 0
            K_index(j) = i;                              %Almacena número de muestra en que se encuentra el K
            foundk = 1;                                  %En caso encuentre el punto
            K_amp_ECG(j) = ecg(i);                      %Puntos S (sobre la curva ECG acondicionada)
            break
        end
        i = i - 1;
    end
    
    if foundk == 0                                          %En caso no encuentre el punto, toma el punto extremo del rango
        K_index(j)=i+1;
        K_amp_ECG(j) = ecg(i+1);                        %Puntos S (sobre la curva ECG acondicionada)
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
        if (i < length(ecg)) && (i > 1)
            if  ((ecg(i) >= ecg(i+1)) && (ecg(i)>= ecg(i-1))&&ecg(i)<QOn_amp_ECG(j))%&&(Found_Q ==0)) %| (i == rango)     %Busca la menor muestra en las 7 muestras y que corresponde al Q (ubicado a la izquierda del R respectivo
                if(Q_index(j) == i)
                    
                    %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecg(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecg(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecg(i+1))));
                else              
                    QOn_index(j)= i;                                  %Guarda el número de muestra en el que ocurre el pico Q
                    QOn_amp_ECG(j) = ecg(i);                      %Puntos S (sobre la curva ECG acondicionada)
                    Found_Q = 1;            %Punto Q encontrado
                    %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecg(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecg(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecg(i+1))));
                end
 
            end
            
        elseif ((i == 1) || (i == length(ecg))) && (Found_Q ==0)
            QOn_index(j)= i+1;                                  %Guarda el número de muestra en el que ocurre el pico S
            QOn_amp_ECG(j) = ecg(i+1);                      %Puntos S (sobre la curva ECG acondicionada)
            Found_Q = 1;                                    %Punto Q encontrado
            %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecg(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecg(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecg(i+1))));
           
        end
    end
    
    if Found_Q == 0                                              %Si no encuentra punto Q, lo asume a la mitad del rango de búsqueda
        ii = Q_index(j) - round(rango/2);
            if ii <= 0
                ii =1;
            end
            QOn_index(j)= ii;                                  %Guarda el número de muestra en el que ocurre el pico Q
            QOn_amp_ECG(j) = ecg(ii);                      %Puntos S (sobre la curva ECG acondicionada)
        %disp(strcat('i-1: ', num2str(i-1), ', ecg(i-1)', num2str(ecg(i-1)), ' , i: ', num2str(i), ', ecg(i): ', num2str(ecg(i)), ', (i+1)', num2str(i+1), ', ecg(i+1)', num2str(ecg(i+1))));
        
    end
    %disp(QOn_index(j));
end
end
 








