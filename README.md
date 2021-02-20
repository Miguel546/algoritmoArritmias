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

**Tabla de resultados Pan Tompkins**

| registromit  | Numero de latidos | VPR    | FPR | FNR  | Sensibilidad | Predictividad |
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

**Tabla de resultados Elgendi**

| # registro   |  latidos |  sensibilidad |  predictividad |  vp   |  fn  |  fp  |
|--------------|----------|---------------|----------------|-------|------|------|
| 100m         | 2257     | 99.86708      | 99.1641        | 2254  | 3    | 19   |
| 101m         | 1865     | 99.142091     | 99.301826      | 1849  | 16   | 13   |
| 103m         | 2084     | 98.560461     | 99.03568       | 2054  | 30   | 20   |
| 106m         | 1507     | 98.341075     | 73.221344      | 1482  | 25   | 542  |
| 117m         | 1534     | 99.934811     | 99.869707      | 1533  | 1    | 2    |
| 119m         | 1620     | 99.814815     | 78.305085      | 1617  | 3    | 448  |
| 122m         | 2475     | 100           | 99.959612      | 2475  | 0    | 1    |
| 207m         | 1415     | 61.837456     | 44.642857      | 875   | 540  | 1085 |
| 214m         | 2001     | 97.301349     | 88.459791      | 1947  | 54   | 254  |
| 222m         | 1257     | 90.294352     | 47.27197       | 1135  | 122  | 1266 |
| 223m         | 2099     | 98.475465     | 80.365474      | 2067  | 32   | 505  |
| 231m         | 1994     | 78.585757     | 99.808917      | 1567  | 427  | 3    |
| 12 registros | 22108    | 94.33236837   | 83.37664415    | 20855 | 1253 | 4158 |

**3. Boonperm, 2014** et al. propone un programa con interfaz gráfica que detecta arritmias usando MATLAB con los parámetros de el complejo QRS, la onda P, intervalo RR, el intervalo PR, y el ritmo del ECG usando la base de datos de arritmias del MIT.

***Cinco características para clasificar arritmias.***

| Arritmia                | Ritmo     | Ritmo cardiaco | Onda P | Intervalo PR | Complejo QRS |
|-------------------------|-----------|----------------|--------|--------------|--------------|
| Ritmo sinusal normal    | Regular   | 55-100 lpm     | 1      | 120-200 ms   | < 125 ms     |
| Bradicardia sinusal     | Regular   | < 55 lpm       | 1      | 120-200ms    | < 125 ms     |
| Fibrilación auricular   | Irregular | cualquiera     | >=1    | No           | < 125 ms     |
| Flutter atrial          | Regular   | cualquiera     | >=1    | No           | < 125 ms     |
| Taquicardia ventricular | Regular   | >75 lpm        | No     | No           | > 125 ms     |
| Fibrilación ventricular | Irregular | >120 lpm       | No     | No           | > 125 ms     |

Para poder ejecutar el programa ubicarse sobre el archivo **DetectorArritmias.fig** y darle click derecho y seleccionar **"Open in GUIDE"**

![Open in Guide DetectorArritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/ArritmiasOpenGuide.png)

Luego se te abrira la figura dale **CTRL + T** o **Run Figure** para ejecutar el programa.

![Run Figure - DetectorArritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/ArritmiasPlay.png)

Después se abrirá el programa para detectar las arritmias. Selecciona un registros de los 48 del MIT-BIH 24h Arrythmias Database. Al grafico le puedes hacer zoom +, zoom -, moverte por el registro, poner el punto en un punto y te aparecera la muestra y el voltaje en las cajas de texto. La aplicación detecta la arritmia y te dice en que muestra la detecta.

![Arritmias](https://github.com/Miguel546/algoritmoArritmias/blob/master/imagenes/Arritmias.png)

**Tabla de resultados Arritmias**

| Registro     | Arritmia                | Sensibilidad | Predictividad | Numero de latidos | VP    | FP    | FN    |
|--------------|-------------------------|--------------|---------------|-------------------|-------|-------|-------|
| 100m         | Ritmo Sinusal Normal    | 69.1157      | 100           | 2273              | 1571  | 0     | 702   |
| 101m         | Ritmo Sinusal Normal    | 95.5686      | 100           | 1873              | 1790  | 0     | 83    |
| 102m         | Ritmo Sinusal Normal    | 65.6863      | 30.0448       | 102               | 67    | 156   | 35    |
| 102m         | Otra Arritmia           | 54.0048      | 95.7483       | 2085              | 1126  | 50    | 959   |
| 103m         | Ritmo Sinusal Normal    | 73.3493      | 100           | 2090              | 1533  | 0     | 557   |
| 104m         | Ritmo Sinusal Normal    | 16.5563      | 29.2398       | 302               | 50    | 121   | 252   |
| 104m         | Otra Arritmia           | 35.1833      | 82.7545       | 1964              | 691   | 144   | 1273  |
| 105m         | Ritmo Sinusal Normal    | 11.5985      | 99.6805       | 2690              | 312   | 1     | 2378  |
| 106m         | Ritmo Sinusal Normal    | 49.0391      | 99.865        | 1509              | 740   | 1     | 769   |
| 106m         | Taquicardia ventricular | 0            | 0             | 3                 | 0     | 5     | 3     |
| 106m         | Otra Arritmia           | 54.5956      | 48.2927       | 544               | 297   | 318   | 247   |
| 107m         | Otra Arritmia           | 95.4184      | 99.8044       | 2139              | 2041  | 4     | 98    |
| 108m         | Ritmo Sinusal Normal    | 16.0176      | 99.6587       | 1823              | 292   | 1     | 1531  |
| 109m         | Ritmo Sinusal Normal    | 12.2731      | 100           | 2534              | 311   | 0     | 2223  |
| 111m         | Ritmo Sinusal Normal    | 0.93809      | 95.2381       | 2132              | 20    | 1     | 2112  |
| 112m         | Ritmo Sinusal Normal    | 25.6571      | 100           | 2549              | 654   | 0     | 1895  |
| 113m         | Ritmo Sinusal Normal    | 73.5933      | 100           | 1795              | 1321  | 0     | 474   |
| 114m         | Ritmo Sinusal Normal    | 16.2963      | 66.443        | 1215              | 198   | 100   | 1017  |
| 114m         | Otra Arritmia           | 57.1429      | 0.27972       | 7                 | 4     | 1426  | 3     |
| 115m         | Ritmo Sinusal Normal    | 84.5997      | 100           | 1961              | 1659  | 0     | 302   |
| 116m         | Ritmo Sinusal Normal    | 56.6116      | 100           | 2420              | 1370  | 0     | 1050  |
| 117m         | Ritmo Sinusal Normal    | 0.78023      | 100           | 1538              | 12    | 0     | 1526  |
| 118m         | Ritmo Sinusal Normal    | 34.8261      | 100           | 2300              | 801   | 0     | 1499  |
| 119m         | Ritmo Sinusal Normal    | 63.7333      | 92.9057       | 1500              | 956   | 73    | 544   |
| 119m         | Otra Arritmia           | 42.3625      | 50.6083       | 491               | 208   | 203   | 283   |
| 121m         | Ritmo Sinusal Normal    | 21.7067      | 100           | 1875              | 407   | 0     | 1468  |
| 122m         | Ritmo Sinusal Normal    | 99.1929      | 100           | 2478              | 2458  | 0     | 20    |
| 123m         | Ritmo Sinusal Normal    | 6.2582       | 100           | 1518              | 95    | 0     | 1423  |
| 124m         | Ritmo Sinusal Normal    | 11.9141      | 94.3299       | 1536              | 183   | 11    | 1353  |
| 124m         | Otra Arritmia           | 61.1765      | 8.7395        | 85                | 52    | 543   | 33    |
| 200m         | Ritmo Sinusal Normal    | 28.5313      | 93.9815       | 1423              | 406   | 26    | 1017  |
| 200m         | Taquicardia ventricular | 21.7391      | 1.3441        | 23                | 5     | 367   | 18    |
| 200m         | Otra Arritmia           | 29.2154      | 75.431        | 1198              | 350   | 114   | 848   |
| 201m         | Ritmo Sinusal Normal    | 3.8356       | 15.2174       | 730               | 28    | 156   | 702   |
| 201m         | Fibrilacion Auricular   | 14.1603      | 38.7387       | 911               | 129   | 204   | 782   |
| 201m         | Otra Arritmia           | 50.6887      | 28.2642       | 363               | 184   | 467   | 179   |
| 202m         | Ritmo Sinusal Normal    | 11.7002      | 65.3061       | 1094              | 128   | 68    | 966   |
| 202m         | Aleteo Auricular        | 75.9615      | 33.7607       | 104               | 79    | 155   | 25    |
| 202m         | Fibrilacion Auricular   | 9.2553       | 69.0476       | 940               | 87    | 39    | 853   |
| 203m         | Aleteo Auricular        | 12.1693      | 30            | 567               | 69    | 161   | 498   |
| 203m         | Fibrilacion Auricular   | 15.7742      | 67.3759       | 2409              | 380   | 184   | 2029  |
| 203m         | Taquicardia ventricular | 20           | 2.2599        | 80                | 16    | 692   | 64    |
| 203m         | Otra Arritmia           | 14.2857      | 0.12804       | 7                 | 1     | 780   | 6     |
| 205m         | Ritmo Sinusal Normal    | 95.8621      | 100           | 2610              | 2502  | 0     | 108   |
| 205m         | Taquicardia ventricular | 38.7755      | 39.5833       | 49                | 19    | 29    | 30    |
| 207m         | Ritmo Sinusal Normal    | 0.26578      | 66.6667       | 1505              | 4     | 2     | 1501  |
| 207m         | Taquicardia ventricular | 0            | 0             | 6                 | 0     | 492   | 6     |
| 207m         | Flutter ventricular     | 14.4351      | 58.4746       | 478               | 69    | 49    | 409   |
| 207m         | Otra Arritmia           | 40.5914      | 10.6413       | 372               | 151   | 1268  | 221   |
| 208m         | Ritmo Sinusal Normal    | 10.2709      | 64.9616       | 2473              | 254   | 137   | 2219  |
| 208m         | Otra Arritmia           | 11.284       | 10.6422       | 514               | 58    | 487   | 456   |
| 209m         | Ritmo Sinusal Normal    | 50           | 100           | 2770              | 1385  | 0     | 1385  |
| 209m         | Otra Arritmia           | 1.9157       | 62.5          | 261               | 5     | 3     | 256   |
| 210m         | Fibrilacion Auricular   | 7.3946       | 92.3445       | 2610              | 193   | 16    | 2417  |
| 210m         | Taquicardia ventricular | 8.3333       | 0.079618      | 12                | 1     | 1255  | 11    |
| 210m         | Otra Arritmia           | 21.7391      | 2.3641        | 46                | 10    | 413   | 36    |
| 212m         | Ritmo Sinusal Normal    | 86.8573      | 100           | 2762              | 2399  | 0     | 363   |
| 213m         | Ritmo Sinusal Normal    | 0.44657      | 100           | 3135              | 14    | 0     | 3121  |
| 213m         | Taquicardia ventricular | 28.5714      | 0.55556       | 7                 | 2     | 358   | 5     |
| 213m         | Otra Arritmia           | 0            | 0             | 109               | 0     | 8     | 109   |
| 214m         | Ritmo Sinusal Normal    | 18.6275      | 97.555        | 2142              | 399   | 10    | 1743  |
| 214m         | Taquicardia ventricular | 16.6667      | 0.15244       | 6                 | 1     | 655   | 5     |
| 214m         | Otra Arritmia           | 29.2683      | 3.9956        | 123               | 36    | 865   | 87    |
| 215m         | Ritmo Sinusal Normal    | 0.43651      | 68.75         | 2520              | 11    | 5     | 2509  |
| 215m         | Taquicardia ventricular | 0            | 0             | 6                 | 0     | 995   | 6     |
| 215m         | Otra Arritmia           | 3.6909       | 31.068        | 867               | 32    | 71    | 835   |
| 217m         | Fibrilacion Auricular   | 2.9412       | 45.4545       | 340               | 10    | 12    | 330   |
| 217m         | Taquicardia ventricular | 0            | 0             | 3                 | 0     | 314   | 3     |
| 217m         | Otra Arritmia           | 84.0107      | 92.5206       | 1870              | 1571  | 127   | 299   |
| 219m         | Ritmo Sinusal Normal    | 4.3573       | 3.2949        | 459               | 20    | 587   | 439   |
| 219m         | Fibrilacion Auricular   | 17.758       | 62.9921       | 1802              | 320   | 188   | 1482  |
| 219m         | Otra Arritmia           | 30.7692      | 1.581         | 26                | 8     | 498   | 18    |
| 220m         | Ritmo Sinusal Normal    | 33.251       | 99.8516       | 2024              | 673   | 1     | 1351  |
| 220m         | Otra Arritmia           | 3.5714       | 0.11751       | 28                | 1     | 850   | 27    |
| 221m         | Fibrilacion Auricular   | 12.7111      | 95.8599       | 2368              | 301   | 13    | 2067  |
| 221m         | Taquicardia ventricular | 33.3333      | 0.31596       | 6                 | 2     | 631   | 4     |
| 221m         | Otra Arritmia           | 43.0769      | 3.3981        | 65                | 28    | 796   | 37    |
| 222m         | Ritmo Sinusal Normal    | 68.5185      | 91.5636       | 1188              | 814   | 75    | 374   |
| 222m         | Aleteo Auricular        | 24.2627      | 59.3443       | 746               | 181   | 124   | 565   |
| 222m         | Fibrilacion Auricular   | 22.8723      | 7.6786        | 188               | 43    | 517   | 145   |
| 222m         | Otra Arritmia           | 40.4255      | 41.8733       | 376               | 152   | 211   | 224   |
| 223m         | Ritmo Sinusal Normal    | 43.0854      | 96.8575       | 2003              | 863   | 28    | 1140  |
| 223m         | Taquicardia ventricular | 46.9945      | 9.6521        | 183               | 86    | 805   | 97    |
| 223m         | Otra Arritmia           | 15.1515      | 32.5          | 429               | 65    | 135   | 364   |
| 228m         | Ritmo Sinusal Normal    | 10.9459      | 98.3957       | 1681              | 184   | 3     | 1497  |
| 228m         | Otra Arritmia           | 57.2115      | 43.5101       | 416               | 238   | 309   | 178   |
| 230m         | Ritmo Sinusal Normal    | 61.3264      | 93.7358       | 1342              | 823   | 55    | 519   |
| 230m         | Otra Arritmia           | 48.964       | 63.1505       | 917               | 449   | 262   | 468   |
| 231m         | Ritmo Sinusal Normal    | 91.2929      | 66.2201       | 758               | 692   | 353   | 66    |
| 231m         | Otra Arritmia           | 1.1043       | 42.8571       | 815               | 9     | 12    | 806   |
| 232m         | Bradicardia Sinusal     | 1.1019       | 100           | 1815              | 20    | 0     | 1795  |
| 233m         | Ritmo Sinusal Normal    | 5.8824       | 100           | 2873              | 169   | 0     | 2704  |
| 233m         | Taquicardia ventricular | 27.7778      | 0.62344       | 18                | 5     | 797   | 13    |
| 233m         | Otra Arritmia           | 52.6316      | 14.0056       | 190               | 100   | 614   | 90    |
| 234m         | Ritmo Sinusal Normal    | 95.426       | 99.8842       | 2711              | 2587  | 3     | 124   |
| 234m         | Otra Arritmia           | 4            | 100           | 50                | 2     | 0     | 48    |
| 48 registros |                         | 37.22529092  | 65.09333714   | 110253            | 41042 | 22009 | 69211 |

## Conclusiones

* Se implementó el algoritmo Pan Tompkins para hallar los picos R con una sensibilidad de 99.02% y predictividad de 99.11% sobre los 48 registros que proporciona la base de datos de arritmias del MIT-BIH 24H.
* Se implementó el algoritmo de Mohamed Elgendi para hallar las ondas P con una sensibilidad de 94.33% y predictividad de 88.37% sobre los 12 registros que proporciona la base de datos de arritmias del MIT-BIH 24H para las ondas P.
* Se implementó las reglas de decisión de Parayikorn para poder detectar las arritmias con una sensibilidad de 37.22% y predictividad de 65.09% sobre los 48 registros de la base de datos de arritmias del MIT-BIH 24H.
