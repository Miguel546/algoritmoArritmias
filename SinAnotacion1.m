for i = 1 : size(anotaciones2,1)
    numero(i) = i;
end
numero = numero(:);

anotaciones2.numero = numero;

z = 0;

for i = 1 : size(anotaciones2,1)
    if(strlength(anotaciones2{i,7}))
        z = z + 1;
        anotacionesRitmo(z,1) = anotaciones2(i,1);
        anotacionesRitmo(z,2) = anotaciones2(i,2);
        anotacionesRitmo(z,3) = anotaciones2(i,3);
        anotacionesRitmo(z,4) = anotaciones2(i,4);
        anotacionesRitmo(z,5) = anotaciones2(i,5);
        anotacionesRitmo(z,6) = anotaciones2(i,6);
        anotacionesRitmo(z,7) = anotaciones2(i,7);
        anotacionesRitmo(z,8) = anotaciones2(i,8);
        anotacionesRitmo(z,9) = anotaciones2(i,9);
    end
end

for i = 1 : size(anotacionesRitmo,1)
    if i == size(anotacionesRitmo,1)
        comienzo(i) = anotacionesRitmo{i,9} +1;
        final(i) = size(anotaciones2,1);
    else
        comienzo(i) = anotacionesRitmo{i,9} +1;
        final(i) = anotacionesRitmo{i+1,9} -1;
    end
end

comienzo = comienzo(:);
final = final(:);
anotacionesRitmo.comienzo = comienzo;
anotacionesRitmo.final = final;