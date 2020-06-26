registromit = '100m';

dbname = 'mitarrythmiadatabase';
username = 'root';
password = 'root';
driver = 'com.mysql.jdbc.Driver';
dburl = ['jdbc:mysql://localhost:3306/' dbname];
javaclasspath('mysql-connector-java-5.1.47.jar');
[conexionBD] = conexion(dbname, username, password, driver, dburl);
seleccionarRegistro = 2;
fs = 360;
[ecgnormal, ecg, Rindex, Q_index, S_index, K_index,  anotacion] = detectarPuntoR(conexionBD, registromit, seleccionarRegistro, fs, 0);
[ecgs2, Rindex2, Tindex, Pindex, anotacionesP] = detectarOndasPT(conexionBD, registromit, seleccionarRegistro, ecgnormal, fs, Rindex, Q_index, S_index, K_index,0);

% Fecg = fft(ecgs2);
% f = fs *(0:(length(ecgs2)/2))/length(ecgs2);
% P2 = abs(Fecg/length(ecgs2));
% P1 = P2(1:length(ecgs2)/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% figure;
% plot(f,P1);
% xlabel('Hertz');
% ylabel('Decibelios');

for i = 1 : length(Rindex)
   PIN = 0;
    if(i>7)
        if(i<length(Rindex))
            %Fourier aplicado del R anterior hasta el R posterior para ver
            %las componentes senoidales
            Fecgtemp=fft(ecgs2(Rindex(i-1):Rindex(i+1)));
            %Para darle el eje X de la grafica
            %Modificar la amplitud para que se aplique la estandarizada
            f = fs*(0:(length(ecgs2(Rindex(i-1):Rindex(i+1)))/2))/length(ecgs2(Rindex(i-1):Rindex(i+1)));
            %Variables intermedias que se modifica la amplitud
            P2 = abs(Fecgtemp/length(ecgs2(Rindex(i-1):Rindex(i+1))));
            %P1 es la grafica final
            P1 = P2(1:length(ecgs2(Rindex(i-1):Rindex(i+1)))/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            %la onda F se busca si en la señal hay una componente senoidal (fourier) entre 200 a 400 pulsos por segundo (3.33Hz a a.6.66Hz) que sea predominante (mayor) sobre las componentes restantes
%             if(max(P1(0.8<f&f<1.888))<max(P1(1.888<f&f<6.666)))
%                 ondaF=1;
%                 hayondaP=0;
%             else
%                 ondaF=0;
%             end
              if(max(P1(f<0.5))>max(P1(f>1))) %forma del espectro de frecuencia para
                 ondaF=1;                     %la fibrilacion auricular
                 hayondaP=0;
              else
                 ondaF=0;
              end
              if(max(P1(f<0.5))>max(P1(1<f&f<3)))%&& max(P1(3<f))< max(P1(1<f&f<3)))
                 ondaFb=2;                     %forma del espectro de frecuencia para
                 hayondaP=0;                  %el aleteo auricular
              else
                 ondaFb=0;
              end
        end
    end
end