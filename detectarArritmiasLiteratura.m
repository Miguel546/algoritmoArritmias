function [ritmoregular, bradicardiamatriz, taquicardiamatriz, PicoR, NSyR, SyBr, SyTa, SyAr, AtFl, AtFib, VTa, VFl, B1Gr, OtraArritmia] = detectarArritmias(conexionBD, registromit, seleccionarRegistro, ecgs2, fs, Rindex, Pindex, S_index, Q_index, Tindex, K_index);

Findex=[];
porcbradi=0;
porctaqui=0;
porclatnormal=0;

porcnsyr=0;
porcsybr=0;
porcsyta=0;
porcsyar=0;
porcatfl=0;
porcatfib=0;
porcvta=0;
porcvfl=0;
porcb1gr=0;
porcoarr = 0;


Intervalos=[0 0];

NSyR=[];
SyBr=[];
SyTa=[];
SyAr=[];
AtFl=[];
AtFib=[];
VTa=[];
VFl=[];
B1Gr=[];
OtraArritmia=[];
PicoR=[];

matrizintreg = []; %intervalo regular
matrizintirreg = [];
matrizbradi = [];
matriztaqui = [];
matriznormal = [];
matrizanormal = [];

ritmoregular=[];
ritmoirregular=[0 0 0 0 0 0 0 0 0];
bradicardiamatriz=[];
taquicardiamatriz=[];
latnormalmatriz=[0 0 0 0 0 0 0 0 0 0];


for i = 1 : length(Rindex)
   PIN = 0;
   if(i == 1)
       tseg=mod(Rindex(1)/fs,60);
        tmin=(Rindex(1)/fs-mod(Rindex(1)/fs,60))/60;
        tsegfinal= mod(Rindex(i)/fs,60);
        tminfinal=(Rindex(i)/fs-mod(Rindex(i)/fs,60))/60;
        RR_nuevo=Rindex(2)-Rindex(1);
        %Desde el octavo hacia atras hacia el ultimo
        diffRR2 = diff(Rindex(1:2));
        %Se repite tres veces
        %Todos los RR lo va a mostrar tres veces
        %Para que eso no pase el RR temporal del RR nuevo
        if(abs(max(diffRR2)-min(diffRR2))<=round(0.080*fs))
            ritmoregular=[ritmoregular; (Rindex(i)) Rindex(i) (Rindex(i)/fs) (Rindex(i)/fs)  (RR_nuevo/fs) tmin tseg tminfinal tsegfinal];
            RitmoR=1;
        else
            RitmoR=0;
        end
        
        if(60/(mean(diffRR2)/fs)<60)
            bradicardiamatriz=[bradicardiamatriz;(Rindex(i)) Rindex(i) (Rindex(i)/fs) (Rindex(i)/fs) tmin tseg tminfinal  tsegfinal  60/(RR_nuevo/fs) RR_nuevo/fs];
            porcbradi = porcbradi +  (Rindex(2) - Rindex(1));
            latnormal=0;
            taqui=0;
            bradi=1;
        elseif(60/(mean(diffRR2)/fs)>100)
            tseg=mod(Rindex(1)/fs,60);
            tmin=(Rindex(2)/fs-mod(Rindex(1)/fs,60))/60;
            tsegfinal= mod(Rindex(i)/fs,60);
            tminfinal=(Rindex(i)/fs-mod(Rindex(i)/fs,60))/60;
            taquicardiamatriz=[taquicardiamatriz; Rindex(i) Rindex(i) (Rindex(i)/fs) (Rindex(i)/fs) tmin tseg tminfinal  tsegfinal  60/(RR_nuevo/fs) RR_nuevo/fs];
            porctaqui = porctaqui +  (Rindex(2) - Rindex(1));
            latnormal=0;
            taqui=1;
            bradi=0;
        else
            %Latido normal en base de frecuencia de latidos por minuto
            porclatnormal=porclatnormal+  (Rindex(2) - Rindex(1));
            latnormal=1;
            taqui=0;
            bradi=0;
        end
        
        if(60/(mean(diffRR2)/fs)>120)
            HRalto=1;
        else
            HRalto=0;
        end
        
        hayondaP=0;

        for y=1:length(Pindex)
            %Si hay una onda P entre los R entonces se considera onda P
            if (Pindex(y)<Rindex(1))
                hayondaP=1;
                PIN=Pindex(y);
            end
        end
        
        PR=Rindex(i)-PIN;
        PRms=(PR/360)*1000;
        
        %Pruebas variando
        if(PRms>120&&PRms<=200)
            PRint=1;
        elseif(PRms>200)
                PRint=2;
        else
            PRint=0;
        end
        
        %El ancho del QRS en muestras
       QRS=S_index(i)-Q_index(i);
       %El ancho del QRS en ms
        QRSms=(QRS/360)*1000;
        
        if(QRSms<120)
            normalqrs=1;
        else
            normalqrs=0;
        end

        Intervalos=[Intervalos;PRms QRSms];
        
        Intervalos=[Intervalos;PRms QRSms];
        
        ranterior = (Rindex(1));
        ractual = Rindex(i);
        segundoanterior = floor(Rindex(i)/fs); 
        restoanterior = (Rindex(i)/fs)-floor(Rindex(i)/fs);
        segundoactual = floor(Rindex(i)/fs); 
        restoactual = ((Rindex(i)/fs)-floor(Rindex(i)/fs));
        tiemporr = (RR_nuevo/fs); 
        if(RitmoR && latnormal && PRint && hayondaP && normalqrs)
        %if(RitmoR && latnormal && hayondaP && PRint && normalqrs)
            NSyR=[NSyR; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
            %porcnsyr = porcnsyr + (Rindex(i) - Rindex(i-1));
        elseif(RitmoR && bradi && PRint && hayondaP && normalqrs)
        %elseif(RitmoR && bradi && hayondaP && PRint && normalqrs)
            SyBr=[SyBr; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
            %porcsybr = porcsybr + (Rindex(i) - Rindex(i-1));
        %elseif(ondaF==1 && ~RitmoR &&  normalqrs)
        elseif(~RitmoR &&  normalqrs && ~hayondaP)
            AtFib=[AtFib; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))]
            %porcatfib = porcatfib + (Rindex(i) - Rindex(i-1));
        %elseif(ondaFb==2 && RitmoR && normalqrs)
        elseif(RitmoR && normalqrs && ~hayondaP)
            AtFl =[AtFl; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
            %porcatfl = porcatfl + (Rindex(i) - Rindex(i-1));
        elseif(RitmoR && taqui && ~normalqrs)
            VTa=[VTa; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
            %porcvta = porcvta + (Rindex(i) - Rindex(i-1));
        elseif(~RitmoR && HRalto && ~normalqrs && ~hayondaP)
            VFl=[VFl; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
            %porcvfl = porcvfl + (Rindex(i) - Rindex(i-1));
        else
            OtraArritmia=[OtraArritmia; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
            %porcoarr = porcoarr + (Rindex(i) - Rindex(i-1));
        end
   elseif(i >1 && i < 7)
       tseg=mod(Rindex(i-1)/fs,60);
        tmin=(Rindex(i-1)/fs-mod(Rindex(i-1)/fs,60))/60;
        tsegfinal= mod(Rindex(i)/fs,60);
        tminfinal=(Rindex(i)/fs-mod(Rindex(i)/fs,60))/60;
        RR_nuevo=Rindex(i)-Rindex(i-1);
        desviacion(i)= std([Rindex(i-1) Rindex(i)]);
        %Desde el octavo hacia atras hacia el ultimo
        diffRR2 = diff(Rindex(1:i));
        %Se repite tres veces
        %Todos los RR lo va a mostrar tres veces
        %Para que eso no pase el RR temporal del RR nuevo
        if(abs(max(diffRR2)-min(diffRR2))<=round(0.080*fs))
            ritmoregular=[ritmoregular; (Rindex(i-1)) Rindex(i) (Rindex(i-1)/fs) (Rindex(i)/fs)  (RR_nuevo/fs) tmin tseg tminfinal tsegfinal];
            RitmoR=1;
        else
            RitmoR=0;
        end
        
        if(60/(mean(diffRR2)/fs)<60)
            bradicardiamatriz=[bradicardiamatriz;(Rindex(i-1)) Rindex(i) (Rindex(i-1)/fs) (Rindex(i)/fs) tmin tseg tminfinal  tsegfinal  60/(RR_nuevo/fs) RR_nuevo/fs];
            porcbradi = porcbradi +  (Rindex(i) - Rindex(i-1));
            latnormal=0;
            taqui=0;
            bradi=1;
        elseif(60/(mean(diffRR2)/fs)>100)
            tseg=mod(Rindex(i-1)/fs,60);
            tmin=(Rindex(i-1)/fs-mod(Rindex(i-1)/fs,60))/60;
            tsegfinal= mod(Rindex(i)/fs,60);
            tminfinal=(Rindex(i)/fs-mod(Rindex(i)/fs,60))/60;
            taquicardiamatriz=[taquicardiamatriz; Rindex(i-1) Rindex(i) (Rindex(i-1)/fs) (Rindex(i)/fs) tmin tseg tminfinal  tsegfinal  60/(RR_nuevo/fs) RR_nuevo/fs];
            porctaqui = porctaqui +  (Rindex(i) - Rindex(i-1));
            latnormal=0;
            taqui=1;
            bradi=0;
        else
            %Latido normal en base de frecuencia de latidos por minuto
            porclatnormal=porclatnormal+  (Rindex(i) - Rindex(i-1));
            latnormal=1;
            taqui=0;
            bradi=0;
        end
        
        if(60/(mean(diffRR2)/fs)>120)
            HRalto=1;
        else
            HRalto=0;
        end
        
        hayondaP=0;
        
        for y=1:length(Pindex)
            %Si hay una onda P entre los R entonces se considera onda P
            if (Pindex(y)<Rindex(i)&&Pindex(y)>Rindex(i-1))
                hayondaP=1;
                PIN=Pindex(y);
            end
        end
        
        PR=Rindex(i)-PIN;
        PRms=(PR/360)*1000;
        
        %Pruebas variando
        if(PRms>120&&PRms<=200)
            PRint=1;
        elseif(PRms>200)
                PRint=2;
        else
            PRint=0;
        end
        
        %El ancho del QRS en muestras
        if(size(S_index,1) - size(Q_index,1) == 0)
            S_index(2) = S_index(1);
            Q_index(2) = Q_index(1);
        end
       QRS=S_index(i)-Q_index(i);
       %El ancho del QRS en ms
        QRSms=(QRS/360)*1000;
        
        if(QRSms<120)
            normalqrs=1;
        else
            normalqrs=0;
        end

        Intervalos=[Intervalos;PRms QRSms];
        
        Intervalos=[Intervalos;PRms QRSms];
        
        ranterior = (Rindex(i-1));
        ractual = Rindex(i);
        segundoanterior = floor(Rindex(i-1)/fs); 
        restoanterior = (Rindex(i-1)/fs)-floor(Rindex(i-1)/fs);
        segundoactual = floor(Rindex(i)/fs); 
        restoactual = ((Rindex(i)/fs)-floor(Rindex(i)/fs));
        tiemporr = (RR_nuevo/fs); 
        
        if(RitmoR && latnormal && PRint && hayondaP && normalqrs)
            NSyR=[NSyR; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(RitmoR && bradi && PRint && hayondaP && normalqrs)
            SyBr=[SyBr; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(~RitmoR &&  normalqrs && ~hayondaP)
            AtFib=[AtFib; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))]
        elseif(RitmoR && normalqrs && ~hayondaP)
            AtFl =[AtFl; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(RitmoR && taqui && ~normalqrs)
            VTa=[VTa; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(~RitmoR && HRalto && ~normalqrs && ~hayondaP)
            VFl=[VFl; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        else
            OtraArritmia=[OtraArritmia; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        end
       
   elseif(i>7)
        tseg=mod(Rindex(i-1)/fs,60);
        tmin=(Rindex(i-1)/fs-mod(Rindex(i-1)/fs,60))/60;
        tsegfinal= mod(Rindex(i)/fs,60);
        tminfinal=(Rindex(i)/fs-mod(Rindex(i)/fs,60))/60;
        RR_nuevo=Rindex(i)-Rindex(i-1);
        desviacion(i)= std([Rindex(i-1) Rindex(i)]);
        %Desde el octavo hacia atras hacia el ultimo
        diffRR2 = diff(Rindex(i-7:i));
        %Se repite tres veces
        %Todos los RR lo va a mostrar tres veces
        %Para que eso no pase el RR temporal del RR nuevo
        if(abs(max(diffRR2)-min(diffRR2))<=round(0.080*fs))
            ritmoregular=[ritmoregular; (Rindex(i-1)) Rindex(i) (Rindex(i-1)/fs) (Rindex(i)/fs)  (RR_nuevo/fs) tmin tseg tminfinal tsegfinal];
            RitmoR=1;
        else
            RitmoR=0;
        end
        
        if(60/(mean(diffRR2)/fs)<60)
            bradicardiamatriz=[bradicardiamatriz;(Rindex(i-1)) Rindex(i) (Rindex(i-1)/fs) (Rindex(i)/fs) tmin tseg tminfinal  tsegfinal  60/(RR_nuevo/fs) RR_nuevo/fs];
            porcbradi = porcbradi +  (Rindex(i) - Rindex(i-1));
            latnormal=0;
            taqui=0;
            bradi=1;
        elseif(60/(mean(diffRR2)/fs)>100)
            tseg=mod(Rindex(i-1)/fs,60);
            tmin=(Rindex(i-1)/fs-mod(Rindex(i-1)/fs,60))/60;
            tsegfinal= mod(Rindex(i)/fs,60);
            tminfinal=(Rindex(i)/fs-mod(Rindex(i)/fs,60))/60;
            taquicardiamatriz=[taquicardiamatriz; Rindex(i-1) Rindex(i) (Rindex(i-1)/fs) (Rindex(i)/fs) tmin tseg tminfinal  tsegfinal  60/(RR_nuevo/fs) RR_nuevo/fs];
            porctaqui = porctaqui +  (Rindex(i) - Rindex(i-1));
            latnormal=0;
            taqui=1;
            bradi=0;
        else
            %Latido normal en base de frecuencia de latidos por minuto
            porclatnormal=porclatnormal+  (Rindex(i) - Rindex(i-1));
            latnormal=1;
            taqui=0;
            bradi=0;
        end
        
        if(60/(mean(diffRR2)/fs)>250)
            HRalto=1;
        else
            HRalto=0;
        end
        
        hayondaP=0;
        
        for y=1:length(Pindex)
            %Si hay una onda P entre los R entonces se considera onda P
            if (Pindex(y)<Rindex(i)&&Pindex(y)>Rindex(i-1))
                hayondaP=1;
                PIN=Pindex(y);
            end
        end
        
        PR=Rindex(i)-PIN;
        PRms=(PR/360)*1000;
        
        %Pruebas variando
        if(PRms>120&&PRms<=200)
            PRint=1;
        elseif(PRms>200)
                PRint=2;
        else
            PRint=0;
        end
        
        %El ancho del QRS en muestras
       QRS=S_index(i)-Q_index(i);
       %El ancho del QRS en ms
        QRSms=(QRS/360)*1000;
        
        if(QRSms<120)
            normalqrs=1;
        else
            normalqrs=0;
        end

        Intervalos=[Intervalos;PRms QRSms];
        
        Intervalos=[Intervalos;PRms QRSms];
        
        ranterior = (Rindex(i-1));
        ractual = Rindex(i);
        segundoanterior = floor(Rindex(i-1)/fs); 
        restoanterior = (Rindex(i-1)/fs)-floor(Rindex(i-1)/fs);
        segundoactual = floor(Rindex(i)/fs); 
        restoactual = ((Rindex(i)/fs)-floor(Rindex(i)/fs));
        tiemporr = (RR_nuevo/fs); 
        if(RitmoR && latnormal && PRint && hayondaP && normalqrs)
            NSyR=[NSyR; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(RitmoR && bradi && PRint && hayondaP && normalqrs)
            SyBr=[SyBr; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(~RitmoR &&  normalqrs && ~hayondaP)
            AtFib=[AtFib; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))]
        elseif(RitmoR && normalqrs && ~hayondaP)
            AtFl =[AtFl; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(RitmoR && taqui && ~normalqrs)
            VTa=[VTa; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        elseif(~RitmoR && HRalto && ~normalqrs && ~hayondaP)
            VFl=[VFl; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        else
            OtraArritmia=[OtraArritmia; ranterior ractual segundoanterior restoanterior segundoactual restoactual tiemporr tmin tseg tminfinal tsegfinal PRms QRSms 60/(mean(diffRR2)/fs) abs(max(diffRR2)-min(diffRR2))];
        end
    end
end

assignin('base','VFl',VFl);
assignin('base','ritmoregular',ritmoregular);
assignin('base','bradicardiamatriz',bradicardiamatriz);
assignin('base','taquicardiamatriz',taquicardiamatriz);
assignin('base','NSyR',NSyR);
assignin('base','SyBr',SyBr);
assignin('base','SyTa',SyTa);
assignin('base','SyAr',SyAr);
assignin('base','AtFl',AtFl);
assignin('base','AtFib',AtFib);
assignin('base','VTa',VTa);
assignin('base','VFib',VFl);
assignin('base','B1Gr',B1Gr);
assignin('base','OtraArritmia',OtraArritmia);