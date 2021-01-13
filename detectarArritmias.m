function [NSyR, SyBr, AtFl, AtFib, VTa, VFl, OtraArritmia, Resultados] = detectarArritmias(conexionBD, registromit, seleccionarRegistro, ecgs2, fs, Rindex, Pindex, P_ON_index, S_index, Q_index, QOn_index, Tindex, K_index);

contNSyR = 1;
contSyBr = 1;
contAtFib = 1;
contAtFl = 1;
contVTa = 1;
contVFl = 1;
contOtraArritmia = 1;
NSyR = {};
SyBr = {};
AtFib = {};
AtFl = {};
VTa = {};
VFl = {};
OtraArritmia = {};
for i=1 : length(Rindex)
    if((Rindex(i)/360) >= 10)
        diezSegundosMuestra = i;
        break;
    end
end

for i = 1 : length(Rindex)
   PIN = 0;
   if(i < length(Rindex))
    RR(i)=Rindex(i+1)-Rindex(i);
   end
   if(i==1)
        RRprima(1) = RR(1);
        RRnorm(i) = (RR(i)*100)/(RRprima(i));
        
        contP = 0;
        if(Pindex(i)<Rindex(i))
             hayondaP=1;
             contP = contP + 1;
             PIN=P_ON_index(i);
        end
        cuantasOndasP(i, 1) = i;
        cuantasOndasP(i, 2) = contP;
        
        if(cuantasOndasP(i, 2) >= 1)
            hayondaP=1;
        else
            hayondaP=0;
        end
        
        PR=QOn_index(i)-PIN;
        PRms=(PR/fs)*1000;
        
        %El ancho del QRS en muestras
        QRS=S_index(i)-Q_index(i);
       %El ancho del QRS en ms
        QRSms=(QRS/fs)*1000;
        
        %Resultados = [Resultados; Rindex(i) PRms QRSms 60/(RR_nuevo/fs)
        %hayondaP ritmo/360]
        PRmsRegistro(i) = PRms;
        QRSmsRegistro(i) = QRSms;
        RitmoCardiacoRegistro(i) = 60/(RR(i)/fs);
        HayOndaPRegistro(i) = cuantasOndasP(i, 2);
   elseif(i == length(Rindex))
       contP = 0;
        for y=1:length(Pindex)
            if (Pindex(y)<Rindex(i)&&Pindex(y)>Rindex(i-1))
                hayondaP=1;
                contP = contP + 1;
                PIN=P_ON_index(y);
            end
        end
        cuantasOndasP(i, 1) = i;
        cuantasOndasP(i, 2) = contP;
        PR=QOn_index(i)-PIN;
        PRms=(PR/360)*1000;
        
        if(cuantasOndasP(i, 2) >= 1)
            hayondaP=1;
        else
            hayondaP=0;
        end
        
        %El ancho del QRS en muestras
        QRS=S_index(i)-Q_index(i);
       %El ancho del QRS en ms
        QRSms=(QRS/360)*1000;
        
        if(QRSms<125)
            normalqrs=1;
        else
            normalqrs=0;
        end
        PRmsRegistro(i) = PRms;
        QRSmsRegistro(i) = QRSms;
        RitmoCardiacoRegistro(i) = 60/(RR(i-1)/fs);
        HayOndaPRegistro(i) = cuantasOndasP(i, 2);
        desviacion(i) = desviacion(i-1);
        
        if(60/(RR(i-1)/fs)<55)
                        latnormal=0;
                        taqui=0;
                        bradi=1;
                    elseif(60/(RR(i-1)/fs)>100)
                        latnormal=0;
                        taqui=1;
                        bradi=0;
                    else
                        %Latido normal en base de frecuencia de latidos por minuto
                        %porclatnormal=porclatnormal+  (Rindex(i) - Rindex(i-1));
                        latnormal=1;
                        taqui=0;
                        bradi=0;
                    end
                    
                    if(60/(RR(i-1)/fs)>75)
                        HRVTa = 1;
                    else
                        HRVTa = 0;
                    end
        
        
                    if(60/(RR(i-1)/fs)>120)
                        HRalto=1;
                    else
                        HRalto=0;
                    end
                    
                    %Pruebas variando
                    if(PRms>120&&PRms<=200)
                        PRint=1;
                    elseif(PRms>200)
                        PRint=2;
                    else
                        PRint=0;
                    end
                    
                    if(QRSms<125)
                        normalqrs=1;
                    else
                        normalqrs=0;
                    end
                    if(desviacion(i)<=200)
                        RitmoR=1;
                    else
                        RitmoR=0;
                    end
                    if(RitmoR && latnormal && PRint == 1 && hayondaP && normalqrs)
                        NSyR{contNSyR,1} = registromit;
                        NSyR{contNSyR,2} = Rindex(i);
                        NSyR{contNSyR,3} = PRmsRegistro(i);
                        NSyR{contNSyR,4} = QRSmsRegistro(i);
                        NSyR{contNSyR,5} = RitmoCardiacoRegistro(i);
                        NSyR{contNSyR,6} = HayOndaPRegistro(i);
                        NSyR{contNSyR,7} = desviacion(i);
                        contNSyR = contNSyR + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(N'};
                    elseif(RitmoR && bradi && PRint == 1 && hayondaP && normalqrs)
                        SyBr{contSyBr,1} = registromit;
                        SyBr{contSyBr,2} = Rindex(i);
                        SyBr{contSyBr,3} = PRmsRegistro(i);
                        SyBr{contSyBr,4} = QRSmsRegistro(i);
                        SyBr{contSyBr,5} = RitmoCardiacoRegistro(i);
                        SyBr{contSyBr,6} = HayOndaPRegistro(i);
                        SyBr{contSyBr,7} = desviacion(i);
                        contSyBr = contSyBr + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(SBR'};
                    elseif(~RitmoR &&  normalqrs && hayondaP)
                        AtFib{contAtFib,1} = registromit;
                        AtFib{contAtFib,2} = Rindex(i);
                        AtFib{contAtFib,3} = PRmsRegistro(i);
                        AtFib{contAtFib,4} = QRSmsRegistro(i);
                        AtFib{contAtFib,5} = RitmoCardiacoRegistro(i);
                        AtFib{contAtFib,6} = HayOndaPRegistro(i);
                        AtFib{contAtFib,7} = desviacion(i);
                        contAtFib = contAtFib + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(AFIB'};
                    elseif(RitmoR && normalqrs && hayondaP)
                        AtFl{contAtFl,1} = registromit;
                        AtFl{contAtFl,2} = Rindex(i);
                        AtFl{contAtFl,3} = PRmsRegistro(i);
                        AtFl{contAtFl,4} = QRSmsRegistro(i);
                        AtFl{contAtFl,5} = RitmoCardiacoRegistro(i);
                        AtFl{contAtFl,6} = HayOndaPRegistro(i);
                        AtFl{contAtFl,7} = desviacion(i);
                        contAtFl = contAtFl + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(AFL'};
                    elseif(RitmoR && HRVTa && ~normalqrs)
                        VTa{contVTa,1} = registromit;
                        VTa{contVTa,2} = Rindex(i);
                        VTa{contVTa,3} = PRmsRegistro(i);
                        VTa{contVTa,4} = QRSmsRegistro(i);
                        VTa{contVTa,5} = RitmoCardiacoRegistro(i);
                        VTa{contVTa,6} = HayOndaPRegistro(i);
                        VTa{contVTa,7} = desviacion(i);
                        contVTa = contVTa + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(VT'};
                    elseif(~RitmoR && HRalto && ~normalqrs)
                        VFl{contVFl,1} = registromit;
                        VFl{contVFl,2} = Rindex(i);
                        VFl{contVFl,3} = PRmsRegistro(i);
                        VFl{contVFl,4} = QRSmsRegistro(i);
                        VFl{contVFl,5} = RitmoCardiacoRegistro(i);
                        VFl{contVFl,6} = HayOndaPRegistro(i);
                        VFl{contVFl,7} = desviacion(i);
                        contVFl = contVFl + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(VFL'};
                    else
                        OtraArritmia{contOtraArritmia,1} = registromit;
                        OtraArritmia{contOtraArritmia,2} = Rindex(i);
                        OtraArritmia{contOtraArritmia,3} = PRmsRegistro(i);
                        OtraArritmia{contOtraArritmia,4} = QRSmsRegistro(i);
                        OtraArritmia{contOtraArritmia,5} = RitmoCardiacoRegistro(i);
                        OtraArritmia{contOtraArritmia,6} = HayOndaPRegistro(i);
                        OtraArritmia{contOtraArritmia,7} = desviacion(i);
                        contOtraArritmia = contOtraArritmia + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(OARR'};
                    end
   else
         RRprima(i) = 0.75*RRprima(i-1) + 0.25 * RR(i);
         RRnorm(i) = (RR(i)*100)/(RRprima(i)); 
        %for y=1:length(Pindex)
            %Si hay una onda P entre los R entonces se considera onda P
            contP = 0;                  
            for y=1:length(Pindex)
                if (Pindex(y)<Rindex(i)&&Pindex(y)>Rindex(i-1))
                    
                    contP = contP + 1;
                    PIN=P_ON_index(y);
                end
            end
            cuantasOndasP(i, 1) = i;
            cuantasOndasP(i, 2) = contP;
        %end
        if(cuantasOndasP(i, 2) >= 1)
            hayondaP=1;
        else
            hayondaP=0;
        end
        PR=QOn_index(i)-PIN;
        PRms=(PR/360)*1000;
        
        %El ancho del QRS en muestras
       QRS=S_index(i)-Q_index(i);
       %El ancho del QRS en ms
        QRSms=(QRS/360)*1000;
        
        
        PRmsRegistro(i) = PRms;
        QRSmsRegistro(i) = QRSms;
        RitmoCardiacoRegistro(i) = 60/(RR(i)/fs);
        HayOndaPRegistro(i) = cuantasOndasP(i, 2);
        if(i >= diezSegundosMuestra)
            if(i == diezSegundosMuestra)
                for j=1 : diezSegundosMuestra
                    desviacion(j) = (RRnorm(j) - mean(RRnorm(1:diezSegundosMuestra)))^2;
                    PRms = PRmsRegistro(j);
                    QRSms = QRSmsRegistro(j);
                    cuantasP = HayOndaPRegistro(j);
                    if(cuantasP >= 1)
                        hayondaP=1;
                    else
                        hayondaP=0;
                    end
                    if(60/(RR(j)/fs)<55)
                        latnormal=0;
                        taqui=0;
                        bradi=1;
                    elseif(60/(RR(j)/fs)>100)
                        latnormal=0;
                        taqui=1;
                        bradi=0;
                    else
                        %Latido normal en base de frecuencia de latidos por minuto
                        %porclatnormal=porclatnormal+  (Rindex(i) - Rindex(i-1));
                        latnormal=1;
                        taqui=0;
                        bradi=0;
                    end
        
                    if(60/(RR(j)/fs)>120)
                        HRalto=1;
                        HRVTa = 0;
                    elseif(60/(RR(j)/fs)>75)
                        HRVTa = 1;
                        HRalto = 0;
                    else
                        HRalto=0;
                        HRVTa = 0;
                    end
                    
                    
                    
                    %Pruebas variando
                    if(PRms>120&&PRms<=200)
                        PRint=1;
                    elseif(PRms>200)
                        PRint=2;
                    else
                        PRint=0;
                    end
                    
                    if(QRSms<125)
                        normalqrs=1;
                    else
                        normalqrs=0;
                    end
                    if(desviacion(j)<=70)
                        RitmoR=1;
                    else
                        RitmoR=0;
                    end
                    if(RitmoR && latnormal && PRint == 1 && hayondaP && normalqrs)
                        NSyR{contNSyR,1} = registromit;
                        NSyR{contNSyR,2} = Rindex(j);
                        NSyR{contNSyR,3} = PRmsRegistro(j);
                        NSyR{contNSyR,4} = QRSmsRegistro(j);
                        NSyR{contNSyR,5} = RitmoCardiacoRegistro(j);
                        NSyR{contNSyR,6} = HayOndaPRegistro(j);
                        NSyR{contNSyR,7} = desviacion(j);
                        contNSyR = contNSyR + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(N'};
                    elseif(RitmoR && bradi && PRint == 1 && hayondaP && normalqrs)
                        SyBr{contSyBr,1} = registromit;
                        SyBr{contSyBr,2} = Rindex(j);
                        SyBr{contSyBr,3} = PRmsRegistro(j);
                        SyBr{contSyBr,4} = QRSmsRegistro(j);
                        SyBr{contSyBr,5} = RitmoCardiacoRegistro(j);
                        SyBr{contSyBr,6} = HayOndaPRegistro(j);
                        SyBr{contSyBr,7} = desviacion(j);
                        contSyBr = contSyBr + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(SBR'};
                    elseif(~RitmoR &&  normalqrs && hayondaP)
                        AtFib{contAtFib,1} = registromit;
                        AtFib{contAtFib,2} = Rindex(j);
                        AtFib{contAtFib,3} = PRmsRegistro(j);
                        AtFib{contAtFib,4} = QRSmsRegistro(j);
                        AtFib{contAtFib,5} = RitmoCardiacoRegistro(j);
                        AtFib{contAtFib,6} = HayOndaPRegistro(j);
                        AtFib{contAtFib,7} = desviacion(j);
                        contAtFib = contAtFib + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(AFIB'};
                    elseif(RitmoR && normalqrs && hayondaP)
                        AtFl{contAtFl,1} = registromit;
                        AtFl{contAtFl,2} = Rindex(j);
                        AtFl{contAtFl,3} = PRmsRegistro(j);
                        AtFl{contAtFl,4} = QRSmsRegistro(j);
                        AtFl{contAtFl,5} = RitmoCardiacoRegistro(j);
                        AtFl{contAtFl,6} = HayOndaPRegistro(j);
                        AtFl{contAtFl,7} = desviacion(j);
                        contAtFl = contAtFl + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(AFL'};
                    elseif(RitmoR && HRVTa && ~normalqrs)
                        VTa{contVTa,1} = registromit;
                        VTa{contVTa,2} = Rindex(j);
                        VTa{contVTa,3} = PRmsRegistro(j);
                        VTa{contVTa,4} = QRSmsRegistro(j);
                        VTa{contVTa,5} = RitmoCardiacoRegistro(j);
                        VTa{contVTa,6} = HayOndaPRegistro(j);
                        VTa{contVTa,7} = desviacion(j);
                        contVTa = contVTa + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(VT'};
                    elseif(~RitmoR && HRalto && ~normalqrs)
                        VFl{contVFl,1} = registromit;
                        VFl{contVFl,2} = Rindex(j);
                        VFl{contVFl,3} = PRmsRegistro(j);
                        VFl{contVFl,4} = QRSmsRegistro(j);
                        VFl{contVFl,5} = RitmoCardiacoRegistro(j);
                        VFl{contVFl,6} = HayOndaPRegistro(j);
                        VFl{contVFl,7} = desviacion(j);
                        contVFl = contVFl + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(VFL'};
                    else
                        OtraArritmia{contOtraArritmia,1} = registromit;
                        OtraArritmia{contOtraArritmia,2} = Rindex(j);
                        OtraArritmia{contOtraArritmia,3} = PRmsRegistro(j);
                        OtraArritmia{contOtraArritmia,4} = QRSmsRegistro(j);
                        OtraArritmia{contOtraArritmia,5} = RitmoCardiacoRegistro(j);
                        OtraArritmia{contOtraArritmia,6} = HayOndaPRegistro(j);
                        OtraArritmia{contOtraArritmia,7} = desviacion(j);
                        contOtraArritmia = contOtraArritmia + 1;
                        Resultados{j,1} = Rindex(j);
                        Resultados{j,2} = PRmsRegistro(j);
                        Resultados{j,3} = QRSmsRegistro(j);
                        Resultados{j,4} = RitmoCardiacoRegistro(j);
                        Resultados{j,5} = HayOndaPRegistro(j);
                        Resultados{j,6} = desviacion(j);
                        Resultados{j,7} = {'(OARR'};
                    end
                    
                end
            else
                desviacion(i) = (RRnorm(i) - mean(RRnorm(i-diezSegundosMuestra+1:i)))^2;
                
                
                if(60/(RR(i)/fs)<55)
                        latnormal=0;
                        taqui=0;
                        bradi=1;
                    elseif(60/(RR(i)/fs)>100)
                        latnormal=0;
                        taqui=1;
                        bradi=0;
                    else
                        %Latido normal en base de frecuencia de latidos por minuto
                        %porclatnormal=porclatnormal+  (Rindex(i) - Rindex(i-1));
                        latnormal=1;
                        taqui=0;
                        bradi=0;
                    end
        
                    if(60/(RR(i)/fs)>120)
                        HRalto=1;
                    else
                        HRalto=0;
                    end
                    
                    if(60/(RR(i)/fs)>75)
                        HRVTa = 1;
                    else
                        HRVTa = 0;
                    end
                    
                    %Pruebas variando
                    if(PRms>120&&PRms<=200)
                        PRint=1;
                    elseif(PRms>200)
                        PRint=2;
                    else
                        PRint=0;
                    end
                    
                    if(QRSms<125)
                        normalqrs=1;
                    else
                        normalqrs=0;
                    end
                    if(desviacion(i)<=200)
                        RitmoR=1;
                    else
                        RitmoR=0;
                    end
                     if(RitmoR && latnormal && PRint == 1 && hayondaP && normalqrs)
                        NSyR{contNSyR,1} = registromit;
                        NSyR{contNSyR,2} = Rindex(i);
                        NSyR{contNSyR,3} = PRmsRegistro(i);
                        NSyR{contNSyR,4} = QRSmsRegistro(i);
                        NSyR{contNSyR,5} = RitmoCardiacoRegistro(i);
                        NSyR{contNSyR,6} = HayOndaPRegistro(i);
                        NSyR{contNSyR,7} = desviacion(i);
                        contNSyR = contNSyR + 1;
                        Resultados{i,1} = Rindex(i);
                Resultados{i,2} = PRmsRegistro(i);
                Resultados{i,3} = QRSmsRegistro(i);
                Resultados{i,4} = RitmoCardiacoRegistro(i);
                Resultados{i,5} = HayOndaPRegistro(i);
                Resultados{i,6} = desviacion(i);
                Resultados{i,7} = {'(N'};
                    elseif(RitmoR && bradi && PRint == 1 && hayondaP && normalqrs)
                        SyBr{contSyBr,1} = registromit;
                        SyBr{contSyBr,2} = Rindex(i);
                        SyBr{contSyBr,3} = PRmsRegistro(i);
                        SyBr{contSyBr,4} = QRSmsRegistro(i);
                        SyBr{contSyBr,5} = RitmoCardiacoRegistro(i);
                        SyBr{contSyBr,6} = HayOndaPRegistro(i);
                        SyBr{contSyBr,7} = desviacion(i);
                        contSyBr = contSyBr + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(SBR'};
                    elseif(~RitmoR &&  normalqrs && hayondaP)
                        AtFib{contAtFib,1} = registromit;
                        AtFib{contAtFib,2} = Rindex(i);
                        AtFib{contAtFib,3} = PRmsRegistro(i);
                        AtFib{contAtFib,4} = QRSmsRegistro(i);
                        AtFib{contAtFib,5} = RitmoCardiacoRegistro(i);
                        AtFib{contAtFib,6} = HayOndaPRegistro(i);
                        AtFib{contAtFib,7} = desviacion(i);
                        contAtFib = contAtFib + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(AFIB'};
                    elseif(RitmoR && normalqrs && hayondaP)
                        AtFl{contAtFl,1} = registromit;
                        AtFl{contAtFl,2} = Rindex(i);
                        AtFl{contAtFl,3} = PRmsRegistro(i);
                        AtFl{contAtFl,4} = QRSmsRegistro(i);
                        AtFl{contAtFl,5} = RitmoCardiacoRegistro(i);
                        AtFl{contAtFl,6} = HayOndaPRegistro(i);
                        AtFl{contAtFl,7} = desviacion(i);
                        contAtFl = contAtFl + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(AFL'};
                    elseif(RitmoR && HRVTa && ~normalqrs)
                        VTa{contVTa,1} = registromit;
                        VTa{contVTa,2} = Rindex(i);
                        VTa{contVTa,3} = PRmsRegistro(i);
                        VTa{contVTa,4} = QRSmsRegistro(i);
                        VTa{contVTa,5} = RitmoCardiacoRegistro(i);
                        VTa{contVTa,6} = HayOndaPRegistro(i);
                        VTa{contVTa,7} = desviacion(i);
                        contVTa = contVTa + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(VT'};
                    elseif(~RitmoR && HRalto && ~normalqrs)
                        VFl{contVFl,1} = registromit;
                        VFl{contVFl,2} = Rindex(i);
                        VFl{contVFl,3} = PRmsRegistro(i);
                        VFl{contVFl,4} = QRSmsRegistro(i);
                        VFl{contVFl,5} = RitmoCardiacoRegistro(i);
                        VFl{contVFl,6} = HayOndaPRegistro(i);
                        VFl{contVFl,7} = desviacion(i);
                        contVFl = contVFl + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(VFL'};
                    else
                        OtraArritmia{contOtraArritmia,1} = registromit;
                        OtraArritmia{contOtraArritmia,2} = Rindex(i);
                        OtraArritmia{contOtraArritmia,3} = PRmsRegistro(i);
                        OtraArritmia{contOtraArritmia,4} = QRSmsRegistro(i);
                        OtraArritmia{contOtraArritmia,5} = RitmoCardiacoRegistro(i);
                        OtraArritmia{contOtraArritmia,6} = HayOndaPRegistro(i);
                        OtraArritmia{contOtraArritmia,7} = desviacion(i);
                        contOtraArritmia = contOtraArritmia + 1;
                        Resultados{i,1} = Rindex(i);
                        Resultados{i,2} = PRmsRegistro(i);
                        Resultados{i,3} = QRSmsRegistro(i);
                        Resultados{i,4} = RitmoCardiacoRegistro(i);
                        Resultados{i,5} = HayOndaPRegistro(i);
                        Resultados{i,6} = desviacion(i);
                        Resultados{i,7} = {'(OARR'};
                    end
            end
        end
   end

end
assignin('base','cuantasOndasP',cuantasOndasP);
assignin('base','VFl',VFl);
assignin('base','NSyR',NSyR);
assignin('base','SyBr',SyBr);
%assignin('base','SyTa',SyTa);
%assignin('base','SyAr',SyAr);
assignin('base','AtFl',AtFl);
assignin('base','AtFib',AtFib);
assignin('base','VTa',VTa);
assignin('base','VFib',VFl);
%assignin('base','B1Gr',B1Gr);
assignin('base','OtraArritmia',OtraArritmia);
assignin('base', 'Resultados', Resultados);