%resultados = {'Resultados100m.mat' 'Resultados103m' 'Resultados112m' 'Resultados201m' 'Resultados207m' 'Resultados221m' 'Resultados222m' 'Resultados223m' 'Resultados232m'}
load('Resultados100m');
load('Resultados103m');
load('Resultados112m');
load('Resultados201m');
load('Resultados207m');
load('Resultados221m');
load('Resultados222m');
load('Resultados223m');
load('Resultados232m');
count = 1;
for i=1:length(Resultados100m)
    Resultados{count, 1} = Resultados100m{i,1};
    count = count + 1;
end
for i=1:length(Resultados103m)
    Resultados{count, 1} = Resultados103m{i,1};
    count = count + 1;
end