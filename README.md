# Aplicación para la detección temprana de arritmias basado en los algoritmos de Pan & Tompkins, Elgendi y Boonperm

Las arritmias son anomalías en el correcto funcionamiento del sistema eléctrico del corazón. Las cuatro cámaras del corazón por lo general laten con un patrón estable y rítmico. La presencia de arritmias es peligrosa para quien las padece y de no ser tratadas a tiempo pueden devenir en enfermedades cardiovasculares que traerán consecuencias fatales y podrían producir la muerte. Para detectar arritmias cardiacas en forma temprana se suelen utilizar monitores de funciones vitales que son costosos, no son portables y cuyo software no es abierto. Ante este contexto se propone una aplicación para la detección de las arritmias: Bradicardia Sinusal, Taquicardia Ventricular, Fibrilación Auricular, Flutter Auricular y Aleteo Auricular, a partir de los algoritmos Pan y Tompkins, Elgendi y Boonperm cuyo código podría ser instalado en dispositivos móviles (Android y iOS) para que los monitores de funciones vitales no sean la única opción para poder detectar dichas arritmias. El algoritmo ensamblado ha sido probado con la base de datos de arritmias del MIT-BIH, primer conjunto de datos de prueba estándar disponible para el ámbito académico. Se analizaron los 48 registros de dicha base de datos y se obtuvo 37.22% de sensibilidad y 65.09% de predictividad en la detección de arritmias, a pesar de los valores obtenidos en la detección de los complejos QRS se obtuvo 99.02 sensibilidad y 99.11% predictividad, lo cual indica que el algoritmo híbrido es confiable solo para la detección de complejos QRS. 

Figura en la que se compara un electrocardiograma de un corazón sano y un electrocardiograma de una Fibrilación Auricular.

![ECG_RSN_FA](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/rsn_fa.png)

## Requisitos

- MATLAB 2015 o superior
- PC con procesador con Intel Core i3 o superior
- MySQL 5.0 o superior
- 8 gb de ram o superior

## Pasos para poder ejecutar el programa

En la consola de mysql ejecutar

```
mysql> \. rutaProyecto\MitArrythmiaDatabase.sql
```

Video - Base de datos de arritmias MySQL --> https://www.youtube.com/watch?v=GYFVdQaUO4E 

Después será capaz de ejecutar el programa de detección de arritmias, el de los picos R y el de los puntos P.

## Metodología

Para la presente investigación para la validación de la efectividad de la aplicación de detección de arritmias se implementará 3 algoritmos. Para la detección del complejo QRS se hace uso del algoritmo Pan Tompkins para detectar el complejo QRS y para las ondas P propuesta por Elgendi y para hallar las arritmias se utilizó las reglas de decisión de Parayikorn. La base de datos utilizada es la MIT-BIH Arrythmia Database del portal Physionet, la cual contiene 48 registros, cada registro digitalizado con 360 muestras/segundo y cada registro con 650000 muestras con registros de electrocardiogramas de diversas arritmias cada registro de 47 sujetos estudiados en el BIH Arrhythmia Laboratory entre 1975 y 1979. (Moody G.B & Mark R.G, 2001, p. 45-47)

Para descargarse los registros tiene que acceder a la siguiente url: https://archive.physionet.org/cgi-bin/atm/ATM tienes que seleccionar MIT-BIH Arrhythmia Database (mitdb) y en signals seleccionar MLII, en caso de los registros 102 y 104m seleccionar el registro V5 y descargarlos en formato .mat en toolbox seleccionar "Export signals as .mat" en la duración ponerle "to end" y en time format "time/date". Los registros descargdos ya estan en la carpeta registro de este repositorio en formato .mat.

**1. Pan & Tompkins, 1985** desarrollaron un algoritmo en tiempo real para la detección de complejos QRS en señales electrocardiográficas, el cual es capaz de detectar el complejo QRS basado en la pendiente, amplitud y ancho. Un filtro pasabanda especial reduce falsas detecciones causadas por varios tipos de ruido presentes en la señal ECG lo cual permite el uso de umbrales lo que aumenta la sensibilidad de detección. El algoritmo ajusta automáticamente los umbrales y los parámetros periódicamente para adaptarse a los cambios de electrocardiograma como la morfología QRS y la frecuencia cardíaca” (Pan Tompkins, 1985, p. 230).  Para el estándar de la base de datos de arritmias del MIT-BIH 24 horas, se replicó el algoritmo Pan-Tompkins en MATLAB detectando correctamente el 96,32% de los complejos QRS mientras que en el artículo original dice un 99.3% por lo tanto el valor obtenido oscila con el original.

Para poder ejecutar el programa ubicarse sobre el archivo **PicoR.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide PicosR](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/picoROpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - Picos R](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/picoRPlay.png)

Después se abrirá el programa para hallar los Picos R. Selecciona el registro a analizar(100m-234m). Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. 

![Picos R](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/PicoR.png)

Video Pan Tompkins --> https://www.youtube.com/watch?v=AkSHIWIy5X8

## **Tabla de resultados Pan Tompkins**

| Registro Mit  | Numero de latidos | VP    | FP | FN  | Sensibilidad | Predictividad |
|--------------|-------------------|--------|-----|------|--------------|---------------|
| 100m         | 2273              | 2273   | 0   | 0    | 100          | 100           |
| 101m         | 1863              | 1862   | 6   | 1    | 99.94632313  | 99.67880086   |
| 102m         | 2187              | 2053   | 134 | 134  | 93.87288523  | 93.87288523   |
| 103m         | 2084              | 2083   | 0   | 1    | 99.95201536  | 100           |
| 104m         | 2229              | 2186   | 47  | 43   | 98.0708838   | 97.89520824   |
| 105m         | 2572              | 2558   | 53  | 14   | 99.45567652  | 97.97012639   |
| 106m         | 2027              | 2023   | 1   | 4    | 99.80266404  | 99.95059289   |
| 107m         | 2137              | 2111   | 6   | 26   | 98.78334113  | 99.71658007   |
| 108m         | 1761              | 1741   | 325 | 20   | 98.86428166  | 84.26911907   |
| 109m         | 2532              | 2526   | 1   | 6    | 99.76303318  | 99.96042738   |
| 111m         | 2123              | 2107   | 4   | 16   | 99.24634951  | 99.81051634   |
| 112m         | 2539              | 2539   | 0   | 0    | 100          | 100           |
| 113m         | 1789              | 1789   | 6   | 0    | 100          | 99.66573816   |
| 114m         | 1879              | 1877   | 1   | 2    | 99.8935604   | 99.94675186   |
| 115m         | 1953              | 1953   | 0   | 0    | 100          | 100           |
| 116m         | 2412              | 2388   | 4   | 24   | 99.00497512  | 99.83277592   |
| 117m         | 1535              | 1535   | 0   | 0    | 100          | 100           |
| 118m         | 2274              | 2274   | 5   | 0    | 100          | 99.78060553   |
| 119m         | 1987              | 1987   | 1   | 0    | 100          | 99.94969819   |
| 121m         | 1863              | 1861   | 0   | 2    | 99.89264627  | 100           |
| 122m         | 2476              | 2476   | 0   | 0    | 100          | 100           |
| 123m         | 1518              | 1515   | 0   | 3    | 99.80237154  | 100           |
| 124m         | 1619              | 1606   | 2   | 13   | 99.19703521  | 99.87562189   |
| 200m         | 2601              | 2595   | 7   | 6    | 99.76931949  | 99.73097617   |
| 201m         | 1961              | 1893   | 2   | 68   | 96.53238144  | 99.8944591    |
| 202m         | 2136              | 2126   | 0   | 10   | 99.53183521  | 100           |
| 203m         | 2974              | 2869   | 49  | 105  | 96.46940148  | 98.32076765   |
| 205m         | 2656              | 2651   | 2   | 5    | 99.81174699  | 99.92461364   |
| 207m         | 2332              | 1970   | 205 | 362  | 84.47684391  | 90.57471264   |
| 208m         | 2953              | 2907   | 6   | 46   | 98.44226211  | 99.79402678   |
| 209m         | 3005              | 3005   | 0   | 0    | 100          | 100           |
| 210m         | 2649              | 2591   | 23  | 58   | 97.81049453  | 99.12012242   |
| 212m         | 2748              | 2748   | 0   | 0    | 100          | 100           |
| 213m         | 3251              | 3218   | 31  | 33   | 98.98492771  | 99.04586026   |
| 214m         | 2262              | 2254   | 5   | 8    | 99.64633068  | 99.77866313   |
| 215m         | 3363              | 3359   | 0   | 4    | 99.88105858  | 100           |
| 217m         | 2208              | 2204   | 2   | 4    | 99.81884058  | 99.90933817   |
| 219m         | 2154              | 2154   | 0   | 0    | 100          | 100           |
| 220m         | 2048              | 2048   | 0   | 0    | 100          | 100           |
| 221m         | 2427              | 2423   | 0   | 4    | 99.83518747  | 100           |
| 222m         | 2483              | 2458   | 25  | 25   | 98.99315344  | 98.99315344   |
| 223m         | 2605              | 2593   | 0   | 12   | 99.53934741  | 100           |
| 228m         | 2053              | 2047   | 12  | 6    | 99.70774476  | 99.41719281   |
| 230m         | 2256              | 2256   | 0   | 0    | 100          | 100           |
| 231m         | 1571              | 1571   | 0   | 0    | 100          | 100           |
| 232m         | 1780              | 1780   | 2   | 0    | 100          | 99.88776655   |
| 233m         | 3079              | 3076   | 0   | 3    | 99.90256577  | 100           |
| 234m         | 2753              | 2750   | 0   | 3    | 99.89102797  | 100           |
| 48 registros | 109940            | 108869 | 967 | 1071 | 99.02583227  | 99.11959649   |

**2. Elgendi, 2016** propuso un método basado en dos filtros de promedio móvil seguido de un umbral de duración de evento dinámico para detectar ondas P y T en señales electrocardiográficas. La detección de las ondas P y T es afectada por la calidad de las grabaciones de electrocardiogramas y las anormalidades de las señales electrocardiográficas. Dicho método detecta ondas P y T en señales electrocardiográficas de arritmias que sufren: 1) efectos no estacionarios, 2) baja relación señal / ruido, 3) Complejo auricular prematuro, 5) Bloques de rama izquierda y 6) Bloques de rama derecha. Cabe destacar que el detector de ondas P y T obtuvo una sensibilidad del 98.05 por ciento y una predictividad positiva del 97.11 por ciento para las ondas P sobre 10 registros de la base de datos de arritmia MIT-BIH con 21702 latidos

Para poder ejecutar el programa ubicarse sobre el archivo **OndasPT.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide OndasP](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndasPOpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - Ondas P](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndaPPlay.png)

Después se abrirá el programa para hallar los Ondas P. Selecciona un registros de los 12 registros de la Onda P del MIT-BIH Arrythmias Database. Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. 

![Ondas P](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/OndaP.png)

Video - Ondas P - Elgendi --> https://www.youtube.com/watch?v=Jn7FqlnJGWw

## **Tabla de resultados Elgendi**

|Registro MIT|Ondas P|VP   |FN  |FP  |Sensibilidad|Predictividad|
|------------|-------|-----|----|----|------------|-------------|
|100m        |2257   |2254 |3   |19  |99.87       |99.16        |
|101m        |1865   |1849 |16  |13  |99.14       |99.30        |
|103m        |2084   |2054 |30  |20  |98.56       |99.04        |
|106m        |1507   |1482 |25  |542 |98.34       |73.22        |
|117m        |1534   |1533 |1   |2   |99.93       |99.87        |
|119m        |1620   |1617 |3   |448 |99.81       |78.31        |
|122m        |2475   |2475 |0   |1   |100.00      |99.96        |
|207m        |1415   |875  |540 |1085|61.84       |44.64        |
|214m        |2001   |1947 |54  |254 |97.30       |88.46        |
|222m        |1257   |1135 |122 |1266|90.29       |47.27        |
|223m        |2099   |2067 |32  |505 |98.48       |80.37        |
|231m        |1994   |1567 |427 |3   |78.59       |99.81        |
|12 registros|22108  |20855|1253|4158|94.33       |83.38        |

**3. Boonperm, 2014** et al. propone un programa con interfaz gráfica que detecta arritmias usando MATLAB con los parámetros de el complejo QRS, la onda P, intervalo RR, el intervalo PR, y el ritmo del ECG usando la base de datos de arritmias del MIT.

***Cinco características para clasificar arritmias.***

| Arritmia                | Ritmo     | Ritmo cardiaco | Onda P | Intervalo PR | Complejo QRS |
|-------------------------|-----------|----------------|--------|--------------|--------------|
| Ritmo sinusal normal    | Regular   | 55-100 lpm     | 1      | 120-200 ms   | < 125 ms     |
| Bradicardia sinusal     | Regular   | < 55 lpm       | 1      | 120-200ms    | < 125 ms     |
| Fibrilación auricular   | Irregular | cualquiera     | >=1    | No           | < 125 ms     |
| Aleteo auricular        | Regular   | cualquiera     | >=1    | No           | < 125 ms     |
| Taquicardia ventricular | Regular   | >75 lpm        | No     | No           | > 125 ms     |
| Flutter ventricular     | Irregular | >120 lpm       | No     | No           | > 125 ms     |

Para poder ejecutar el programa ubicarse sobre el archivo **DetectorArritmias.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide DetectorArritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/ArritmiasOpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - DetectorArritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/ArritmiasPlay.png)

Después se abrirá el programa para detectar las arritmias. Selecciona un registros de los 48 del MIT-BIH 24h Arrythmias Database. Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. La aplicación detecta la arritmia y te dice en que muestra la detecta.

![Arritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/Arritmias.png)

Video - Programa para detectar arritmias --> https://www.youtube.com/watch?v=d4xTK3QCPPQ

## **Tabla de resultados Arritmias**

| Registro      | Arritmia                | Sensibilidad | Predictividad | Numero de latidos | VP    | FP    | FN    |
|---------------|-------------------------|--------------|---------------|-------------------|-------|-------|-------|
| 100m          | Ritmo Sinusal Normal    | 69.1157      | 100           | 2273              | 1571  | 0     | 702   |
| 101m          | Ritmo Sinusal Normal    | 96.0816      | 100           | 1863              | 1790  | 0     | 73    |
| 102m          | Ritmo Sinusal Normal    | 64.7059      | 46.8085       | 102               | 66    | 75    | 36    |
| 102m          | Otra Arritmia           | 54.6763      | 95.8789       | 2085              | 1140  | 49    | 945   |
| 103m          | Ritmo Sinusal Normal    | 73.5125      | 100           | 2084              | 1532  | 0     | 552   |
| 104m          | Ritmo Sinusal Normal    | 17.9931      | 36.1111       | 289               | 52    | 92    | 237   |
| 104m          | Otra Arritmia           | 33.7629      | 81.875        | 1940              | 655   | 145   | 1285  |
| 105m          | Ritmo Sinusal Normal    | 11.8585      | 99.6732       | 2572              | 305   | 1     | 2267  |
| 106m          | Ritmo Sinusal Normal    | 49.9663      | 99.8652       | 1483              | 741   | 1     | 742   |
| 106m          | Taquicardia ventricular | 0            | 0             | 3                 | 0     | 5     | 3     |
| 106m          | Otra Arritmia           | 54.8983      | 48.2927       | 541               | 297   | 318   | 244   |
| 107m          | Otra Arritmia           | 95.5077      | 99.8044       | 2137              | 2041  | 4     | 96    |
| 108m          | Ritmo Sinusal Normal    | 16.5247      | 99.6575       | 1761              | 291   | 1     | 1470  |
| 109m          | Ritmo Sinusal Normal    | 3.4755       | 100           | 2532              | 88    | 0     | 2444  |
| 111m          | Ritmo Sinusal Normal    | 1.1776       | 96.1538       | 2123              | 25    | 1     | 2098  |
| 112m          | Ritmo Sinusal Normal    | 25.7582      | 100           | 2539              | 654   | 0     | 1885  |
| 113m          | Ritmo Sinusal Normal    | 73.7283      | 99.8486       | 1789              | 1319  | 2     | 470   |
| 114m          | Ritmo Sinusal Normal    | 15.8654      | 100           | 1872              | 297   | 0     | 1575  |
| 114m          | Otra Arritmia           | 57.1429      | 0.27952       | 7                 | 4     | 1427  | 3     |
| 115m          | Ritmo Sinusal Normal    | 84.895       | 100           | 1953              | 1658  | 0     | 295   |
| 116m          | Ritmo Sinusal Normal    | 56.7993      | 100           | 2412              | 1370  | 0     | 1042  |
| 117m          | Ritmo Sinusal Normal    | 0.78176      | 100           | 1535              | 12    | 0     | 1523  |
| 118m          | Ritmo Sinusal Normal    | 35.1363      | 100           | 2274              | 799   | 0     | 1475  |
| 119m          | Ritmo Sinusal Normal    | 63.7517      | 92.8988       | 1498              | 955   | 73    | 543   |
| 119m          | Otra Arritmia           | 42.5358      | 50.6083       | 489               | 208   | 203   | 281   |
| 121m          | Ritmo Sinusal Normal    | 21.8465      | 100           | 1863              | 407   | 0     | 1456  |
| 122m          | Ritmo Sinusal Normal    | 99.273       | 100           | 2476              | 2458  | 0     | 18    |
| 123m          | Ritmo Sinusal Normal    | 6.2582       | 100           | 1518              | 95    | 0     | 1423  |
| 124m          | Ritmo Sinusal Normal    | 11.9296      | 94.3299       | 1534              | 183   | 11    | 1351  |
| 124m          | Otra Arritmia           | 61.1765      | 8.7395        | 85                | 52    | 543   | 33    |
| 200m          | Ritmo Sinusal Normal    | 27.4678      | 94.1176       | 1398              | 384   | 24    | 1014  |
| 200m          | Taquicardia ventricular | 21.7391      | 1.3441        | 23                | 5     | 367   | 18    |
| 200m          | Otra Arritmia           | 29.8305      | 75.5365       | 1180              | 352   | 114   | 828   |
| 201m          | Ritmo Sinusal Normal    | 4.0639       | 15.6425       | 689               | 28    | 151   | 661   |
| 201m          | Fibrilacion Auricular   | 14.27        | 39.039        | 911               | 130   | 203   | 781   |
| 201m          | Otra Arritmia           | 50.9695      | 28.2642       | 361               | 184   | 467   | 177   |
| 202m          | Ritmo Sinusal Normal    | 11.8132      | 65.8163       | 1092              | 129   | 67    | 963   |
| 202m          | Aleteo Auricular        | 75.9615      | 33.9056       | 104               | 79    | 154   | 25    |
| 202m          | Fibrilacion Auricular   | 9.1489       | 68.8          | 940               | 86    | 39    | 854   |
| 203m          | Aleteo Auricular        | 12.6866      | 30.4933       | 536               | 68    | 155   | 468   |
| 203m          | Fibrilacion Auricular   | 15.9864      | 66.7851       | 2352              | 376   | 187   | 1976  |
| 203m          | Taquicardia ventricular | 20.2532      | 2.2599        | 79                | 16    | 692   | 63    |
| 203m          | Otra Arritmia           | 14.2857      | 0.12755       | 7                 | 1     | 783   | 6     |
| 205m          | Ritmo Sinusal Normal    | 95.9724      | 100           | 2607              | 2502  | 0     | 105   |
| 205m          | Taquicardia ventricular | 38.7755      | 39.5833       | 49                | 19    | 29    | 30    |
| 207m          | Ritmo Sinusal Normal    | 0.3367       | 71.4286       | 1485              | 5     | 2     | 1480  |
| 207m          | Taquicardia ventricular | 0            | 0             | 6                 | 0     | 492   | 6     |
| 207m          | Flutter ventricular     | 14.6186      | 58.4746       | 472               | 69    | 49    | 403   |
| 207m          | Otra Arritmia           | 41.1924      | 10.7042       | 369               | 152   | 1268  | 217   |
| 208m          | Ritmo Sinusal Normal    | 10.438       | 65.051        | 2443              | 255   | 137   | 2188  |
| 208m          | Otra Arritmia           | 11.3725      | 10.6422       | 510               | 58    | 487   | 452   |
| 209m          | Ritmo Sinusal Normal    | 50.1822      | 100           | 2744              | 1377  | 0     | 1367  |
| 209m          | Otra Arritmia           | 1.9157       | 62.5          | 261               | 5     | 3     | 256   |
| 210m          | Fibrilacion Auricular   | 7.4489       | 92.3445       | 2591              | 193   | 16    | 2398  |
| 210m          | Taquicardia ventricular | 8.3333       | 0.079618      | 12                | 1     | 1255  | 11    |
| 210m          | Otra Arritmia           | 21.7391      | 2.3641        | 46                | 10    | 413   | 36    |
| 212m          | Ritmo Sinusal Normal    | 87.2635      | 100           | 2748              | 2398  | 0     | 350   |
| 213m          | Ritmo Sinusal Normal    | 0.41467      | 100           | 3135              | 13    | 0     | 3122  |
| 213m          | Taquicardia ventricular | 28.5714      | 0.55556       | 7                 | 2     | 358   | 5     |
| 213m          | Otra Arritmia           | 0            | 0             | 109               | 0     | 8     | 109   |
| 214m          | Ritmo Sinusal Normal    | 18.5424      | 98.2885       | 2168              | 402   | 7     | 1766  |
| 214m          | Taquicardia ventricular | 16.6667      | 0.15244       | 6                 | 1     | 655   | 5     |
| 214m          | Otra Arritmia           | 22.7273      | 2.2198        | 88                | 20    | 881   | 68    |
| 215m          | Ritmo Sinusal Normal    | 0.47662      | 100           | 3357              | 16    | 0     | 3341  |
| 215m          | Taquicardia ventricular | 0            | 0             | 6                 | 0     | 995   | 6     |
| 217m          | Fibrilacion Auricular   | 2.9586       | 45.4545       | 338               | 10    | 12    | 328   |
| 217m          | Taquicardia ventricular | 0            | 0             | 3                 | 0     | 314   | 3     |
| 217m          | Otra Arritmia           | 84.1457      | 92.3032       | 1867              | 1571  | 131   | 296   |
| 219m          | Ritmo Sinusal Normal    | 6.079        | 3.5149        | 329               | 20    | 549   | 309   |
| 219m          | Fibrilacion Auricular   | 17.7026      | 62.9191       | 1802              | 319   | 188   | 1483  |
| 219m          | Otra Arritmia           | 34.7826      | 1.5564        | 23                | 8     | 506   | 15    |
| 220m          | Ritmo Sinusal Normal    | 33.3003      | 99.8516       | 2021              | 673   | 1     | 1348  |
| 220m          | Otra Arritmia           | 3.7037       | 0.11751       | 27                | 1     | 850   | 26    |
| 221m          | Fibrilacion Auricular   | 12.4735      | 96.3934       | 2357              | 294   | 11    | 2063  |
| 221m          | Taquicardia ventricular | 33.3333      | 0.31596       | 6                 | 2     | 631   | 4     |
| 221m          | Otra Arritmia           | 46.875       | 3.5971        | 64                | 30    | 804   | 34    |
| 222m          | Ritmo Sinusal Normal    | 68.9246      | 91.6667       | 1181              | 814   | 74    | 367   |
| 222m          | Aleteo Auricular        | 24.3935      | 59.5395       | 742               | 181   | 123   | 561   |
| 222m          | Fibrilacion Auricular   | 22.3404      | 7.554         | 188               | 42    | 514   | 146   |
| 222m          | Otra Arritmia           | 42.2043      | 42.5474       | 372               | 157   | 212   | 215   |
| 223m          | Ritmo Sinusal Normal    | 43.2365      | 96.8575       | 1996              | 863   | 28    | 1133  |
| 223m          | Taquicardia ventricular | 47.5138      | 9.6521        | 181               | 86    | 805   | 95    |
| 223m          | Otra Arritmia           | 15.1869      | 32.6633       | 428               | 65    | 134   | 363   |
| 228m          | Ritmo Sinusal Normal    | 10.428       | 98.8571       | 1659              | 173   | 2     | 1486  |
| 228m          | Otra Arritmia           | 58.8832      | 42.4132       | 394               | 232   | 315   | 162   |
| 230m          | Ritmo Sinusal Normal    | 61.1484      | 93.7143       | 1341              | 820   | 55    | 521   |
| 230m          | Otra Arritmia           | 49.071       | 63.1505       | 915               | 449   | 262   | 466   |
| 231m          | Ritmo Sinusal Normal    | 90.7906      | 100           | 1151              | 1045  | 0     | 106   |
| 231m          | Otra Arritmia           | 0.95238      | 19.0476       | 420               | 4     | 17    | 416   |
| 232m          | Bradicardia Sinusal     | 1.1236       | 100           | 1780              | 20    | 0     | 1760  |
| 233m          | Ritmo Sinusal Normal    | 5.8865       | 100           | 2871              | 169   | 0     | 2702  |
| 233m          | Taquicardia ventricular | 27.7778      | 0.62344       | 18                | 5     | 797   | 13    |
| 233m          | Otra Arritmia           | 52.6316      | 14.0056       | 190               | 100   | 614   | 90    |
| 234m          | Ritmo Sinusal Normal    | 95.7085      | 99.8842       | 2703              | 2587  | 3     | 116   |
| 234m          | Otra Arritmia           | 4            | 100           | 50                | 2     | 0     | 48    |
| 48 resgistros |                         | 37.42313989  | 65.82458723   | 109940            | 41143 | 21361 | 68797 |

## Conclusiones

* Se implementó el algoritmo Pan Tompkins para hallar los picos R con una sensibilidad de 99.02% y predictividad de 99.11% sobre los 48 registros que proporciona la base de datos de arritmias del MIT-BIH 24H.
* Se implementó el algoritmo de Mohamed Elgendi para hallar las ondas P con una sensibilidad de 94.33% y predictividad de 88.37% sobre los 12 registros que proporciona la base de datos de arritmias del MIT-BIH 24H para las ondas P.
* Se implementó las reglas de decisión de Parayikorn para poder detectar las arritmias con una sensibilidad de 37.42% y predictividad de 65.82% sobre los 48 registros de la base de datos de arritmias del MIT-BIH 24H.
