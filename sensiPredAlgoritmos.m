function [matriz, VP,FP,FN, Sensi, Predp, VParreglo, FParreglo, FNarreglo]=sensiPred(algoritmo, prs, qrs, ritmoCardiaco, hayOndaP, ritmoRegular, anotacionesBD, abreviatura)
VP=0;
FP=0;
FN=length(anotacionesBD);
arrct=0;
matriz = zeros(length(algoritmo) + 1,length(anotacionesBD) + 1);
matriz(1,1) = "";
 for k=1:length(algoritmo)
     matriz(k+1,1) = algoritmo{k};
     for n=1:size(anotacionesBD, 1)
         matriz(1,n + 1) = anotacionesBD(n, 1); 
         if(algoritmo{k}<=anotacionesBD(n, 1)+20 && algoritmo{k}>=anotacionesBD(n, 1)-20)
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
            VParreglo(m, 2) = prs{k-1}; 
            VParreglo(m, 3) = qrs{k-1};
            VParreglo(m, 4) = ritmoCardiaco{k-1};
            VParreglo(m, 5) = hayOndaP{k-1};
            VParreglo(m, 6) = ritmoRegular{k-1};
            %VParreglo(m,2) = matriz(1, n);
            m = m + 1;
        end
        sumaFP = sumaFP + matriz(k,n);
    end
    if(sumaFP == 0)
        FParreglo(u, 1) = matriz(k, 1);
        minutos = matriz(k, 1)/360;
        FParreglo(u, 2) = floor(minutos/60);
        FParreglo(u, 3) = floor(minutos - FParreglo(u, 2) * 60);
        FParreglo(u, 4) = minutos - FParreglo(u, 2) - FParreglo(u, 3);
        u = u + 1;
    end
    sumaFP = 0;
end
if(VP == 0)
    VParreglo = 0;
end
if(FP == 0)
    FParreglo = 0;
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
        FNarreglo{u, 4} = minutos - cell2mat(FNarreglo(u, 2)) - cell2mat(FNarreglo(u, 3));
        FNarreglo{u, 5} = abreviatura;     
        u = u + 1;
    end
    sumaFN = 0;
end
if(FN == 0)
    FNarreglo = 0; 
end