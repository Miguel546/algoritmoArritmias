Fecgtemp=fft(ecgs2(Rindex(i-1):Rindex(i+1)));
            %Para darle el eje X de la grafica
            %Modificar la amplitud para que se aplique la estandarizada
            f = fs*(0:(length(ecgs2(Rindex(i-1):Rindex(i+1)))/2))/length(ecgs2(Rindex(i-1):Rindex(i+1)));
            %Variables intermedias que se modifica la amplitud
            P2 = abs(Fecgtemp/length(ecgs2(Rindex(i-1):Rindex(i+1))));
            %P1 es la grafica final
P1 = P2((1:length(ecgs2(Rindex(i-1):Rindex(i+1)))/2)+1);