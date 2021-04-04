% Para detectar los Puntos R en los PVC
for c=1:length(Rindex)-1
    [maxt maxtind]=max(ecg(Rindex(c):Rindex(c+1)));
    [minR minRind]=min(ecg(Rindex(c):Rindex(c)+maxtind-1));
    %Cuando se tiene un punto R que a su derecha tiene un minimo muy
    %negativo y un maximo mayor al punto R, el minimo antes mencionado se
    %reconoce como punto R
    
    if(maxt>ecg(Rindex(c))&&-minR>ecg(Rindex(c)))
        Rindex(c)=minRind+Rindex(c)-1;
    end   
end