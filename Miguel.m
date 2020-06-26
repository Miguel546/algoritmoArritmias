holaMiguel = {'Hola'; "mi"; "nombre"; "es"; "Miguel"};
holaMiguel2 = {"Hola"; "mi"; "nombre"; "es"; "Miguel"};
holaMiguel3 = '';
concatenar=[];
for i=1:length(arritmiasAlgoritmo)
     concatenar = [concatenar; arritmiasAlgoritmo(i,1) arritmiasAlgoritmo(i,2)];
end
z = 1;
for i=1:length(arritmiasAlgoritmo)
    for y=1:size(arritmiasAlgoritmo,2)
        if(y==1)
            %concatenar2 = concat(arritmiasAlgoritmo(i,y));
            %concatenar3(z) = arritmiasAlgoritmo(i,y); 
            %z = z + 1;
            concatenar3{i,y} = str2double(arritmiasAlgoritmo(i,y));
        elseif(y==2)
            concatenar3{i,y} = char(arritmiasAlgoritmo(i,y));
        end
    end
end
% miguelconcat= '';
% for i=1:length(concatenar3)
%     if(i==1)
%         miguelconcat = miguelconcat + "{" + strcat(concatenar3(i) + "");
%     elseif(i == length(concatenar3))
%         miguelconcat = miguelconcat + " '" + strcat(concatenar3(i) + "'}"); 
%     elseif(mod(i,2) == 0)
%         miguelconcat = miguelconcat + " '"+ strcat(concatenar3(i) + "';");
%     elseif(~mod(i,2) == 0)
%         miguelconcat = miguelconcat + ' ' + strcat(concatenar3(i));
%     end
% end
% 
% disp(miguelconcat);
% 
% a = {1 'Ritmo Sinusal Normal'; 3 'Aleteo auricular'; 4 'Fibrilacion Auricular'; 5 'Taquicardia Ventricular'; 6 'Fibrilacion Ventricular'};
% b = miguelconcat;
% 
% 
% conestesale = {1 'Ritmo sinusal Normal'; 2 'Bradicardia Sinusal'};

disp(concatenar3)