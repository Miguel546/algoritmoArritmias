function [VP,FP,FN, Sensi, Predp, VParreglo, FParreglo, FNarreglo]=sensiPred(algoritmo, anotaciones)
anotaciones = anotaciones(:);
anotacionesBD = anotaciones;
VP=0;
FP=0;
FN=length(anotacionesBD);
arrct=0;
matriz = zeros(length(algoritmo) + 1,length(anotacionesBD) + 1);
matriz(1,1) = "";
 for k=1:length(algoritmo)
     matriz(k+1,1) = algoritmo(k);
     for n=1:length(anotacionesBD)
         matriz(1,n + 1) = anotacionesBD(n); 
         if(algoritmo(k)<=anotacionesBD(n)+20 && algoritmo(k)>=anotacionesBD(n)-20)
             matriz(k+1, n+1) = 1;
             VP=VP+1;
             FN=FN-1;
             arrct=1;
         end
     end
     
     if(arrct==0)
         FP=FP+1;
     else
         arrct=0;
     end
 end
% 
% VP
% FN
% FP
% 
Sensi=100*VP/(VP+FN);
Predp=100*VP/(VP+FP);

m = 1;
[t, y] = size(matriz);
u= 1;
sumaFP = 0;

for k=2:t
    for n=2:y
        if matriz(k,n) == 1    
            VParreglo(m, 1) = matriz(k, 1);
            VParreglo(m,2) = matriz(1, n);
            
            m = m + 1;
        end
        sumaFP = sumaFP + matriz(k,n);
    end
    if(sumaFP == 0)
        FParreglo(u, 1) = matriz(k, 1);
        minutos = matriz(k, 1)/360;
        FParreglo(u, 2) = floor(minutos/60);
        FParreglo(u, 3) = floor(minutos - FParreglo(u, 2) * 60);
        integ=floor(minutos);
        FParreglo(u, 4) = minutos-integ;
        u = u + 1;
    end
    sumaFP = 0;
end
if(VP == 0)
    VParreglo = 0;
end
if(FP == 0)
    FParreglo = [];
else
   %FParreglo = FParreglo(:); 
end


sumaFN = 0;
u = 1;
%FNarreglo = 0;
for n=2:y
    for k=2:t
        sumaFN = sumaFN + matriz(k,n);
    end
    if(sumaFN == 0)
        FNarreglo{u, 1} = matriz(1, n);
        minutos = matriz(1, n)/360;
        FNarreglo{u, 2} = floor(minutos/60);
        FNarreglo{u, 3} = floor(minutos - cell2mat(FNarreglo(u, 2)) * 60);
        integ=floor(minutos);
        FNarreglo{u, 4} = minutos-integ;
        %FNarreglo{u, 5} = anotacionesBDType(n - 1);     
        u = u + 1;
    end
    sumaFN = 0;
end
if(FN == 0 || FN == -1 || FN == -2)
   FNarreglo = []; 
end