function [ecgs2, Rindex, Tindex, Pindex, anotacionesP] = detectarOndasPT(conexionBD, registromit, numero, ecg, fs, Rindex, Q_index, S_index, K_index, gr)
load('queriesAnotaciones') ;
anotacionRegistroP = queries(numero - 1);
anotacionesP = select(conexionBD, anotacionRegistroP);

assignin('base','anotacionRegistroP',anotacionRegistroP);
%% Onda P
%%
%filtro pasabanda
[b3,a3]=butter(2,[0.5 10]*2/fs);
ecgs2=filtfilt(b3,a3,ecg);
ecgs2=ecgs2/max(abs(ecgs2));
%Remover el QRS y convertirlos en 0.1 para poder enfocarnos en la onda P y convertirlos en 0.1 para poder enfocarnos en la onda P.
for m=1:length(Rindex)
    %El limite por la izquierda puede ser 0.083s o el punto Q, el que este
    %más a la izquierda
    limitQ=round(0.083*fs);
    if(Rindex(m)-Q_index(m)>round(0.083*fs))
        limitQ=Rindex(m)-Q_index(m);
    end
    if(Rindex(m)+round(0.166*fs)<=length(ecgs2))&& (Rindex(m)-limitQ>0)
        %Del punto R hacia la izquierda 83 ms y del punto R hacia la
        %derecha es 0.166 ms
        %Tomas muestras hacia la izquierda y hacia la derecha y tambien
        %tienes que tomar la muestra del punto R
        ecgs2(Rindex(m)-limitQ:Rindex(m)+round(0.166*fs))=zeros(length(ecgs2(Rindex(m)-limitQ:Rindex(m)+round(0.166*fs))),1)-0.1;
    elseif (Rindex(m)+round(0.166*fs)>length(ecgs2))
        %Si entra aca esta en la ultima muestra entonces 0 es -0.1
        ecgs2(Rindex(m)-limitQ:end)=0-0.1;
    elseif Rindex(m)-limitQ<=0
        %Si entra aca esta en la primera muestra entonces 0 es -0.1
        ecgs2(1:Rindex(m)+round(0.166*fs))=0-0.1;
    end
end

MApk=(1/round(0.025*fs))*ones(round(0.025*fs),1);
%Le aplicas el filtro con convulución
MApecgs2=conv(ecgs2,MApk);

MApw=(1/round(0.05*fs))*ones(round(0.05*fs),1);
MAwecgs2=conv(ecgs2,MApw);

for n=1:length(ecgs2)
    %Cuando el área es mayor a la ventana de 55 ms es mayor a la 110 ms
    if(MApecgs2(n)>MAwecgs2(n))
        %El punto se convierte en el punto de interes
        block(n)=0.25;
    else
        %Es considerado un bloque de interes si no no
        block(n)=0;
    end
end

for m=1:length(Rindex)
    %El limite por la izquierda puede ser 0.083s o el punto Q, el que este
    %más a la izquierda
    limitQb=round(0.083*fs);
    if(Rindex(m)-Q_index(m)>round(0.083*fs))
        limitQb=Rindex(m)-Q_index(m);
    end
    %Hay una parte de los bloques que se junta con el QRS y se vuelve 0
    if(Rindex(m)+round(0.166*fs)<=length(ecgs2))&& Rindex(m)-limitQb>0
        %Para esta misma region el bloque va a valer 0 la senal de los
        %rectangulos
        %Es el espacio de muestras que se va a hacer 0
        block(Rindex(m)-limitQb:Rindex(m)+round(0.166*fs))=zeros(length(block(Rindex(m)-limitQb:Rindex(m)+round(0.166*fs))),1);
    elseif (Rindex(m)+round(0.166*fs)>length(ecgs2))
        %es 0 mayor a la longitud de la señal
        block(Rindex(m)-limitQ:end)=0;
    elseif Rindex(m)-limitQb<=0
        %es 0 menor a la posicion de la primera muestra 
        block(1:Rindex(m)+round(0.166*fs))=0;
    end
end

m=1;
for k=1:length(ecgs2)
    %El bloque de interes es la parte inicial cuando pasa de 0 a 0.25 pero
    %que pasa si para la muestra 1 el bloque ya esta en 0.25
    if((k==1||block(k-1)==0)&&block(k)==0.25)
        Blim(m,1)=k; %Guarda la posicion del inicio del bloque del interes
    end
    %El bloque es la longitud del ecgs2 y el bloque es k+1=0 y el bloque k
    %es 0.25 entonces
    if((k==length(ecgs2)||block(k+1)==0)&&block(k)==0.25)
        Blim(m,2)=k; %Guarda la posicion del final del bloque de interes.
        m=m+1;
    end
    
end

%Son contadores de las ondas
o=1;
t=1;
f=1;
for j=1:length(Rindex)
    %Vale 0 cuando no haya onda P o T y cuando si vale 1
    Pwave=0;
    Twave=0;
    if(j==1)
        %Nblock va a ser el numero de rectangulos entre un RR
        Nblock=0;
        for k=1:length(Blim(:,1))
            if(ecgs2(1)<=Blim(k,1)&&Blim(k,2)<Rindex(j))
                %Bloques de interes por cada intervalo RR
                Nblock=Nblock+1;
                tempblock(Nblock,1)=Blim(k,1);
                tempblock(Nblock,2)=Blim(k,2);
            end
        end
        
        if(Nblock==1)
            [PT,PTindex]=max(ecgs2(tempblock(1,1):tempblock(1,2)));
            Tindex(t)=PTindex+tempblock(1,1)-1;
            Tamp(t)=PT;
            Pindex(o)=PTindex+tempblock(1,1)-1;
            Pamp(o)=PT;
            t=t+1;
            o=o+1;
            Pwave=1;
            Twave=1;
        elseif(Nblock>1)
            %Primera parte de la primera muestra hasta el primer pico
            for p=1:length(tempblock(:,1))
                [Bmax Bmaxind]=max(ecgs2(tempblock(p,1):tempblock(p,2)));
                if(Bmaxind+(tempblock(p,1)-1)-1>(Rindex(j)-1)*0.111)&&(Bmaxind+(tempblock(p,1)-1)-1<(Rindex(j)-1)*0.583)&&Twave==0
                    Tindex(t)=Bmaxind+tempblock(p,1)-1;
                    Tamp(t)=Bmax;
                    t=t+1;
                    Twave=1;
                end
                if(Rindex(j)-(Bmaxind+tempblock(length(tempblock(:,1))-p+1,1))-1>round(0.055*fs))&&(Rindex(j)-(Bmaxind+tempblock(p,1))-1<round(0.27*fs))&& Pwave==0
                    Pindex(o)=Bmaxind+tempblock(p,1)-1;
                    Pamp(o)=Bmax;
                    o=o+1;
                    Pwave=1;
                end
                %El Nblock>2 entonces halla las F y las guarda las
                %posiciones
                %Bloques de interes cada bloque de interes es
                if(Nblock>2)
                    %El numero de bloques entre cada intervalo RR
                    Findex(f)=Bmaxind+tempblock(p,1)-1;
                    f=f+1;
                end
            end
        end
    end
    Pwave=0;
    Twave=0;
    if(j>=1&&j<length(Rindex))
        %Nblock va a ser el numero de rectangulos entre un RR
        Nblock=0;
        for k=1:length(Blim(:,1))
            %Si el bloque de interes esta dentro del RR que estamos
            %analizando. Por cada bloque de interes que encuentra Nblock va
            %aumentando de 1 en 1 y los bloques de interes que estan dentro
            %del RR se guardan y es el if. Los bloques de interes sabemos que son ondas P en una onda normal generalment
            %hay dos bloques de interes uno para la onda T y otro para la
            %onda P generalmente deberian haber 2 o que no haya bloques o
            %que haya mas de 3, 4 o 5 asi entonces vamos a analizar esos
            %casos
            if(Rindex(j)<Blim(k,1)&&Blim(k,2)<Rindex(j+1))
                %Se va a analizar los bloques de interes dentro de un RR
                Nblock=Nblock+1;
                %Buscan los bloques de interes que estan dentro de un RR y
                %lo guardan
                tempblock(Nblock,1)=Blim(k,1);
                
                tempblock(Nblock,2)=Blim(k,2);
            end
        end
        if(Nblock==1)
            %La onda P y la onda T se haya deformado entonces ese punto se
            %guarda como P y T al mismo tiempo... y se guarda el indice y
            %la amplitud.
            %Hay un solo bloque de interes 
            [PT,PTindex]=max(ecgs2(tempblock(1,1):tempblock(1,2)));
            Tindex(t)=PTindex+tempblock(1,1)-1;
            Tamp(t)=PT;
            Pindex(o)=PTindex+tempblock(1,1)-1;
            Pamp(o)=PT;
            %El indice de las ondas T
            t=t+1;
            %El indice de las onda P
            o=o+1;
            Twave=1;
            Pwave=1;
        elseif(Nblock>1)
            for p=1:length(tempblock(:,1))
                [Bmax,Bmaxind]=max(ecgs2(tempblock(p,1):tempblock(p,2)));
                %Si la distancia del pico del bloque de interes al R
                %anterior es mayor a 0.111 por RR y es menor a 0.583 por RR
                %entonces se considera que es onda P y se guarda la amplitud
                %y la posicion
                %paper pag 
                if(Bmaxind+(tempblock(p,1)-Rindex(j))-1>(Rindex(j+1)-Rindex(j))*0.111)&&(Bmaxind+(tempblock(p,1)-Rindex(j))-1<(Rindex(j+1)-Rindex(j))*0.583)&&Twave==0
                    Tindex(t)=Bmaxind+tempblock(p,1)-1;
                    Tamp(t)=Bmax;
                    t=t+1;
                    Twave=1;
                end
                %El bloque mas pegado a la derecha y halla el pico entonces
                %es lo que esta ahi en la imagen
                [Bmax2,Bmaxind2]=max(ecgs2(tempblock(length(tempblock(:,1))-p+1,1):tempblock(length(tempblock(:,1))-p+1,2)));
                %Si la distancia de ese pico al R siguiente es mayor a 55 ms
                %y menor a 270 ms es onda P y nada mas se guardan los datos
                %en un vector
                %Tienes que bajarle de 0.47 a 0.27 ya que es muy grande
                %para los casos que son taquicardia y le bajas
                if(Rindex(j+1)-(Bmaxind2+tempblock(length(tempblock(:,1))-p+1,1))-1>round(0.055*fs))&&(Rindex(j+1)-(Bmaxind2+tempblock(length(tempblock(:,1))-p+1,1))-1<round(0.27*fs))&& Pwave==0
                    Pindex(o)=Bmaxind2+tempblock(length(tempblock(:,1))-p+1,1)-1;
                    Pamp(o)=Bmax2;
                    o=o+1;
                    Pwave=1;
                end
            end
        end
        
    elseif(j==length(Rindex))
        %Nblock va a ser el numero de rectangulos entre un RR
        Nblock=0;
        for k=1:length(Blim(:,1))
            %Si el bloque de interes esta dentro del RR que estamos
            %analizando. Por cada bloque de interes que encuentra Nblock va
            %aumentando de 1 en 1 y los bloques de interes que estan dentro
            %del RR se guardan y es el if. Los bloques de interes sabemos que son ondas P en una onda normal generalment
            %hay dos bloques de interes uno para la onda T y otro para la
            %onda P generalmente deberian haber 2 o que no haya bloques o
            %que haya mas de 3, 4 o 5 asi entonces vamos a analizar esos
            %casos
            if(Rindex(j)<Blim(k,1)&&Blim(k,2)<=ecgs2(end))
                Nblock=Nblock+1;
                tempblock(Nblock,1)=Blim(k,1);
                tempblock(Nblock,2)=Blim(k,2);
            end
        end
        
        if(Nblock==1)
            %La onda P y la onda T se haya deformado entonces ese punto se
            %guarda como P y T al mismo tiempo... y se guarda el indice y
            %la amplitud.
            [PT,PTindex]=max(ecgs2(tempblock(1,1):tempblock(1,2)));
            Tindex(t)=PTindex+tempblock(1,1)-1;
            Tamp(t)=PT;
            Pindex(o)=PTindex+tempblock(1,1)-1;
            Pamp(o)=PT;
            t=t+1;
            o=o+1;
            Twave=1;
            Pwave=1;
        elseif(Nblock>1)
            for p=1:length(tempblock(:,1))
                
                [Bmax Bmaxind]=max(ecgs2(tempblock(p,1):tempblock(p,2)));
                %Si la distancia del pico del bloque de interes al R
                %anterior es mayor a 0.111 por RR y es menor a 0.583 por RR
                %entonces se considera que es onda P y se guarda la amplitud
                %y la posicion
                if(Bmaxind+(tempblock(p,1)-Rindex(j))-1>(length(ecgs2)-Rindex(j))*0.111)&&(Bmaxind+(tempblock(p,1)-Rindex(j))-1<(length(ecgs2)-Rindex(j))*0.583)&&Twave==0
                    Tindex(t)=Bmaxind+tempblock(p,1)-1;
                    Tamp(t)=Bmax;
                    t=t+1;
                    Twave=1;
                end
                if(length(ecgs2)-(Bmaxind+tempblock(p,1))-1>round(0.055*fs))&&(length(ecgs2)-(Bmaxind+tempblock(p,1))-1<round(0.27*fs))&&Pwave==0
                    Pindex(o)=Bmaxind+tempblock(p,1)-1;
                    Pamp(o)=Bmax;
                    o=o+1;
                    Pwave=1;
                end
                if(Nblock>2)
                    Findex(f)=Bmaxind+tempblock(p,1)-1;;
                    f=f+1;
                end
            end
        end
    end
end
